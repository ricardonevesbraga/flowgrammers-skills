---
name: "senior-mobile-ios"
description: "Engenheiro iOS sênior especializado em Swift 6, SwiftUI, UIKit, Combine, async/await, arquitetura modular (MVVM, TCA, Clean), testes (XCTest, Swift Testing), CI/CD (Fastlane, Xcode Cloud), distribuição (App Store Connect, TestFlight) e integração com HIG da Apple. Use ao desenvolver apps iOS nativos, revisar código Swift, otimizar performance de UI, implementar Live Activities/Widgets/App Clips, integrar SDKs, preparar submissão à App Store ou quando o usuário mencionar iOS, Swift, SwiftUI, UIKit, Xcode, App Store ou TestFlight."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: engineering-team
  domain: mobile-ios
  updated: 2026-04-23
agents:
  - claude-code
---

# Engenheiro iOS Sênior

Desenvolvimento iOS nativo de nível mundial com Swift 6, SwiftUI, arquitetura modular, testes rigorosos e entrega contínua.

## Palavras-chave
iOS, Swift, Swift 6, SwiftUI, UIKit, Combine, async/await, actor, concurrency, Xcode, XCTest, Swift Testing, Fastlane, Xcode Cloud, App Store Connect, TestFlight, HIG, Human Interface Guidelines, CoreData, SwiftData, MVVM, TCA, Clean Architecture

## Fluxos Principais

### 1. Arquitetura Recomendada (MVVM + Modularização)

```swift
// Feature module: Features/Checkout
import SwiftUI
import Observation

@Observable
final class CheckoutViewModel {
    private(set) var state: State = .idle
    private let service: CheckoutService

    enum State: Equatable {
        case idle
        case loading
        case loaded(Order)
        case error(String)
    }

    init(service: CheckoutService) {
        self.service = service
    }

    func load(orderID: String) async {
        state = .loading
        do {
            let order = try await service.fetchOrder(id: orderID)
            state = .loaded(order)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}

struct CheckoutView: View {
    @State private var viewModel: CheckoutViewModel

    init(viewModel: CheckoutViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
        case .loaded(let order):
            OrderDetailsView(order: order)
        case .error(let message):
            ErrorView(message: message) {
                Task { await viewModel.load(orderID: order.id) }
            }
        }
    }
}
```

**Princípios:**
- Use `@Observable` (Swift 5.9+) no lugar de `ObservableObject`/`@Published`
- Estado exposto como `private(set)` — mutações apenas pela ViewModel
- Errors tipados; evite `Error` genérico em APIs públicas
- Modularize por feature com Swift Package Manager local

### 2. Concorrência Moderna (Swift Concurrency)

```swift
// Evite: DispatchQueue, completion handlers em novo código
// Prefira: async/await + actors

actor ImageCache {
    private var cache: [URL: UIImage] = [:]

    func image(for url: URL) async throws -> UIImage {
        if let cached = cache[url] { return cached }
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw ImageError.decodingFailed
        }
        cache[url] = image
        return image
    }
}

@MainActor
final class ProductsViewModel {
    private(set) var products: [Product] = []

    func loadAll() async throws {
        products = try await withThrowingTaskGroup(of: Product.self) { group in
            for id in ["A", "B", "C"] {
                group.addTask { try await self.fetch(id: id) }
            }
            var results: [Product] = []
            for try await product in group { results.append(product) }
            return results
        }
    }
}
```

**Regras:**
- `@MainActor` em ViewModels que atualizam UI
- `Sendable` conformance em models compartilhados cross-actor
- Strict concurrency checking habilitado (Swift 6 default)
- Evite `Task { @MainActor in ... }` dentro de contextos síncronos sem necessidade

### 3. Testes

```swift
// Swift Testing (Swift 5.10+) — prefira sobre XCTest em projetos novos
import Testing
@testable import MyApp

@Suite("CheckoutViewModel")
struct CheckoutViewModelTests {
    @Test("Load order with success")
    func loadSuccess() async throws {
        let service = MockCheckoutService(result: .success(.mock))
        let viewModel = CheckoutViewModel(service: service)

        await viewModel.load(orderID: "123")

        #expect(viewModel.state == .loaded(.mock))
    }

    @Test("Load order with error")
    func loadError() async throws {
        let service = MockCheckoutService(result: .failure(NetworkError.timeout))
        let viewModel = CheckoutViewModel(service: service)

        await viewModel.load(orderID: "123")

        #expect(viewModel.state == .error("Timeout"))
    }
}
```

**Pirâmide:**
- 70% unitários (ViewModels, services, parsers)
- 20% integração (networking real ou mocks locais)
- 10% UI (XCUITest para fluxos críticos de conversão)

### 4. Performance de UI

**Checklist de SwiftUI performático:**
- Use `LazyVStack`/`LazyVGrid` em listas grandes
- `@ViewBuilder` para composição declarativa sem `AnyView`
- Instruments: SwiftUI Template + Time Profiler
- Image caching (Nuke, SDWebImage ou implementação própria com actor)
- Evite cálculos pesados em `body` — mova para ViewModel ou `.task`
- Animations: `.animation(_:value:)` específico, não global

**Problemas comuns e fix:**

| Sintoma | Causa provável | Fix |
|---------|----------------|-----|
| Jank ao rolar | Image loading síncrono | `AsyncImage` com placeholder + cache |
| CPU alto em idle | `Timer` sem invalidate | `.task` scope correto |
| Memória crescendo | Retain cycle em closures | `[weak self]` em Combine/Task longas |
| Re-renders excessivos | `@State` em pai com muitos filhos | Split views, `Equatable` em modelos |

### 5. Integração com Capabilities Avançadas

**Live Activities & Widgets:**
```swift
// WidgetBundle
@main
struct AppWidgets: WidgetBundle {
    var body: some Widget {
        OrderStatusWidget()
        OrderLiveActivity()  // iOS 16.1+
    }
}
```

**App Clips:** < 10MB, fluxo de 1 tela crítica
**Push Notifications:** APNs + Notification Service Extension para payloads ricos
**CloudKit:** sync cross-device sem backend próprio

### 6. CI/CD e Distribuição

**Fastlane (fastlane/Fastfile):**
```ruby
default_platform(:ios)

platform :ios do
  desc "Build e submit para TestFlight"
  lane :beta do
    setup_ci if ENV['CI']
    match(type: "appstore", readonly: true)
    increment_build_number(xcodeproj: "MyApp.xcodeproj")
    build_app(scheme: "MyApp", configuration: "Release")
    upload_to_testflight(skip_waiting_for_build_processing: true)
  end

  desc "Release na App Store"
  lane :release do
    beta
    deliver(
      submit_for_review: true,
      automatic_release: false,
      force: true
    )
  end
end
```

**Xcode Cloud:**
- Workflows por branch (main → release, PR → tests)
- Arquivos de configuração em `.xcodeproj/project.xcworkspace/xcshareddata/xcschemes/`
- Signing gerenciado pela Apple (sem necessidade de match)

### 7. App Store: Submissão e Review

**Checklist pré-submissão:**
- Screenshots em todos os tamanhos exigidos (6.7", 6.5", 5.5")
- Privacy labels preenchidos (Apple Privacy Nutrition)
- Export compliance (criptografia)
- Review notes: credenciais demo, fluxo passo-a-passo
- In-App Purchases aprovados separadamente

**Motivos comuns de rejeição:**
- Guideline 2.1 (bugs)
- Guideline 5.1.1 (privacidade)
- Guideline 4.3 (spam / copycat)
- Guideline 3.1.1 (IAP para conteúdo digital)

## Métricas do Engenheiro iOS

- **Crash-free users**: > 99.8% (App Store Connect + Firebase Crashlytics)
- **App launch time**: < 400ms (cold), < 100ms (warm)
- **Frame rate**: 60fps em listas (Instruments)
- **Binary size**: < 50MB (App Store download size)
- **Cobertura de testes**: > 70% nas camadas críticas

## Erros Comuns que o CLO Jr Comete

- Usar `UIKit` novo em 2026 sem razão técnica forte
- `ObservableObject`/`@Published` em código Swift 6 (use `@Observable`)
- Ignorar sendable warnings — elas vão virar errors
- Armazenar dados sensíveis em `UserDefaults` (use Keychain)
- Ignorar localizável com `NSLocalizedString` (use `String(localized:)`)

## Veja Também

- `../senior-frontend/` — padrões de UI compartilhados
- `../tdd-guide/` — TDD em Swift
- `../../product-team/apple-hig-expert/` — Human Interface Guidelines
- `../../engineering/ci-cd-pipeline-builder/` — pipelines
