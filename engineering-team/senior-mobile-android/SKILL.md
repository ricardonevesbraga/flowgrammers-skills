---
name: "senior-mobile-android"
description: "Engenheiro Android sênior especializado em Kotlin, Jetpack Compose, Coroutines, Flow, arquitetura (Clean Architecture, MVI/MVVM), Hilt DI, Room, Retrofit, testes (JUnit5, Turbine, Paparazzi), CI/CD (Gradle, GitHub Actions, Firebase App Distribution) e publicação na Play Store. Use ao desenvolver apps Android nativos, revisar código Kotlin, otimizar performance de UI, implementar Material Design 3, trabalhar com KMP, integrar SDKs ou quando o usuário mencionar Android, Kotlin, Jetpack Compose, Play Store ou Gradle."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: engineering-team
  domain: mobile-android
  updated: 2026-04-23
agents:
  - claude-code
---

# Engenheiro Android Sênior

Desenvolvimento Android nativo de nível mundial com Kotlin, Jetpack Compose, Coroutines, arquitetura modular e entrega contínua.

## Palavras-chave
Android, Kotlin, Jetpack Compose, Material 3, Coroutines, Flow, StateFlow, Hilt, Dagger, Room, Retrofit, WorkManager, DataStore, KMP, Kotlin Multiplatform, JUnit5, Turbine, Paparazzi, Gradle, Play Store, Firebase

## Fluxos Principais

### 1. Arquitetura Recomendada (Clean + MVI)

```kotlin
// Domain: use case puro
class GetOrderUseCase(private val repository: OrderRepository) {
    suspend operator fun invoke(orderId: String): Result<Order> =
        repository.getOrder(orderId)
}

// Data: repository com Flow
class OrderRepositoryImpl(
    private val api: OrderApi,
    private val dao: OrderDao
) : OrderRepository {
    override suspend fun getOrder(orderId: String): Result<Order> = runCatching {
        val remote = api.getOrder(orderId)
        dao.insert(remote.toEntity())
        remote.toDomain()
    }
}

// Presentation: ViewModel + StateFlow
@HiltViewModel
class CheckoutViewModel @Inject constructor(
    private val getOrder: GetOrderUseCase
) : ViewModel() {

    private val _state = MutableStateFlow<CheckoutState>(CheckoutState.Idle)
    val state: StateFlow<CheckoutState> = _state.asStateFlow()

    fun load(orderId: String) {
        viewModelScope.launch {
            _state.value = CheckoutState.Loading
            getOrder(orderId)
                .onSuccess { _state.value = CheckoutState.Loaded(it) }
                .onFailure { _state.value = CheckoutState.Error(it.message ?: "Erro") }
        }
    }
}

sealed interface CheckoutState {
    data object Idle : CheckoutState
    data object Loading : CheckoutState
    data class Loaded(val order: Order) : CheckoutState
    data class Error(val message: String) : CheckoutState
}
```

**Princípios:**
- Separe domain / data / presentation em módulos Gradle separados
- Use `sealed interface` para states (exhaustive `when`)
- `StateFlow` para UI, `SharedFlow` para eventos one-shot
- Injeção com Hilt (não use Service Locator)

### 2. Jetpack Compose UI

```kotlin
@Composable
fun CheckoutScreen(
    viewModel: CheckoutViewModel = hiltViewModel(),
    onBack: () -> Unit
) {
    val state by viewModel.state.collectAsStateWithLifecycle()

    Scaffold(
        topBar = { TopAppBar(title = { Text("Checkout") }, navigationIcon = {
            IconButton(onClick = onBack) { Icon(Icons.Default.ArrowBack, null) }
        }) }
    ) { padding ->
        Box(Modifier.padding(padding).fillMaxSize()) {
            when (val s = state) {
                is CheckoutState.Idle, CheckoutState.Loading -> CircularProgressIndicator(
                    Modifier.align(Alignment.Center)
                )
                is CheckoutState.Loaded -> OrderDetailsContent(s.order)
                is CheckoutState.Error -> ErrorContent(s.message) {
                    viewModel.load(orderId = "current")
                }
            }
        }
    }
}
```

**Regras de performance:**
- `remember` para computações estáveis
- `derivedStateOf` para estado derivado
- `key()` em `LazyColumn` com chave estável
- Evite passar lambdas inline — use `remember { { ... } }` quando necessário
- `Modifier.pointerInput(Unit) { ... }` com keys corretos para evitar re-captura

### 3. Coroutines e Flow

```kotlin
// Combine múltiplos Flows
val dashboardState: StateFlow<DashboardState> = combine(
    orderRepository.observeOrders(),
    userRepository.observeUser(),
    notificationRepository.observeUnread()
) { orders, user, unread ->
    DashboardState(orders, user, unread)
}.stateIn(
    scope = viewModelScope,
    started = SharingStarted.WhileSubscribed(5_000),
    initialValue = DashboardState.Empty
)

// Cancelamento estrutural
suspend fun loadAll() = coroutineScope {
    val ordersAsync = async { fetchOrders() }
    val userAsync = async { fetchUser() }
    Dashboard(
        orders = ordersAsync.await(),
        user = userAsync.await()
    )
}
```

**Patterns obrigatórios:**
- `viewModelScope` para operações ligadas ao ViewModel
- `lifecycleScope` ou `repeatOnLifecycle(STARTED)` em UI
- `Dispatchers.IO` para I/O; `Dispatchers.Default` para CPU
- `SupervisorJob` quando falhas de filhas não devem cancelar pai

### 4. Testes

```kotlin
// Teste de ViewModel
class CheckoutViewModelTest {
    @get:Rule val dispatcherRule = MainDispatcherRule()

    @Test
    fun `load success emits Loaded state`() = runTest {
        val useCase = FakeGetOrderUseCase(Result.success(Order.mock))
        val viewModel = CheckoutViewModel(useCase)

        viewModel.state.test {
            assertThat(awaitItem()).isEqualTo(CheckoutState.Idle)
            viewModel.load("123")
            assertThat(awaitItem()).isEqualTo(CheckoutState.Loading)
            assertThat(awaitItem()).isEqualTo(CheckoutState.Loaded(Order.mock))
        }
    }
}

// Screenshot test com Paparazzi
class CheckoutScreenshotTest {
    @get:Rule val paparazzi = Paparazzi(
        deviceConfig = PIXEL_5,
        theme = "android:Theme.Material.NoActionBar"
    )

    @Test
    fun `loaded state`() {
        paparazzi.snapshot {
            OrderDetailsContent(order = Order.mock)
        }
    }
}
```

**Ferramentas:**
- JUnit 5 (Jupiter) para unit tests
- Turbine para testar Flow
- MockK para mocks (mais idiomático que Mockito em Kotlin)
- Paparazzi para screenshot tests (mais rápido que Roborazzi)
- Compose UI Testing para interação

### 5. Performance Android

**Checklist:**
- `R8` habilitado em release (minify + shrink + obfuscate)
- `ProGuard rules` para reflection (Retrofit, Gson, Hilt)
- Baseline Profiles (AGP 7.1+) para redução de 30% no startup
- Startup Tracing com `androidx.tracing`
- App size: bundle APK (AAB) + split por ABI/density
- Image loading: Coil (Compose-native) ou Glide

**Métricas:**
- Cold start: < 500ms
- Frame render: < 16ms (60fps) ou < 8ms (120fps)
- ANR rate: < 0.47% (Play Console limite)
- Crash rate: < 1%

### 6. Play Store e Distribuição

**Build e publicação:**
```kotlin
// build.gradle.kts (app)
android {
    namespace = "br.com.empresa.app"
    compileSdk = 35

    defaultConfig {
        applicationId = "br.com.empresa.app"
        minSdk = 24
        targetSdk = 35
        versionCode = gitCommitCount()
        versionName = "1.2.3"
    }

    signingConfigs {
        create("release") {
            storeFile = file(System.getenv("KEYSTORE_PATH") ?: "release.keystore")
            storePassword = System.getenv("KEYSTORE_PASSWORD")
            keyAlias = System.getenv("KEY_ALIAS")
            keyPassword = System.getenv("KEY_PASSWORD")
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            signingConfig = signingConfigs.getByName("release")
        }
    }
}
```

**Play Console:**
- Rollout progressivo (5% → 20% → 50% → 100%)
- Pre-launch report (Firebase Test Lab automático)
- Crash & ANR monitoring (Play Vitals)
- Android Vitals: Bad Behavior (ANRs, crashes, slow frames, excessive wake-ups)

### 7. Kotlin Multiplatform (KMP)

**Quando usar:**
- Lógica de negócio duplicada entre iOS + Android
- Time com expertise em Kotlin
- Networking, validação, state machines

**Quando não usar:**
- UI (cada plataforma tem sua UI nativa — SwiftUI + Compose)
- Feature específica de uma plataforma
- Time pequeno sem banda para aprender KMP

```kotlin
// shared/src/commonMain
expect class HttpClientProvider() {
    fun provide(): HttpClient
}

// shared/src/androidMain
actual class HttpClientProvider {
    actual fun provide(): HttpClient = HttpClient(OkHttp) { ... }
}

// shared/src/iosMain
actual class HttpClientProvider {
    actual fun provide(): HttpClient = HttpClient(Darwin) { ... }
}
```

## Erros Comuns

- `LiveData` em projeto novo (use `StateFlow`)
- `View` (XML) em projeto novo sem necessidade
- Retrofit + RxJava (use Flow)
- `AsyncTask` (deprecated)
- `findViewById` em Compose
- Ignorar `configChanges` em Manifest (app perde state em rotate)

## Veja Também

- `../senior-frontend/` — padrões de UI compartilhados
- `../tdd-guide/` — TDD em Kotlin
- `../../engineering/ci-cd-pipeline-builder/` — pipelines
- `../../engineering/docker-development/` — CI em containers
