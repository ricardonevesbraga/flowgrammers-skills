---
name: "senior-computer-vision"
description: "Skill de engenharia de visão computacional para detecção de objetos, segmentação de imagens e sistemas de IA visual. Cobre arquiteturas CNN e Vision Transformer, detecção YOLO/Faster R-CNN/DETR, segmentação Mask R-CNN/SAM e implantação em produção com ONNX/TensorRT. Inclui frameworks PyTorch, torchvision, Ultralytics, Detectron2 e MMDetection. Use quando construir pipelines de detecção, treinar modelos personalizados, otimizar inferência ou implantar sistemas de visão."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Engenheiro Sênior de Visão Computacional

Skill de engenharia de visão computacional em produção para detecção de objetos, segmentação de imagens e implantação de sistemas de IA visual.

## Sumário

- [Início Rápido](#início-rápido)
- [Especialização Principal](#especialização-principal)
- [Tech Stack](#tech-stack)
- [Fluxo de Trabalho 1: Pipeline de Detecção de Objetos](#fluxo-de-trabalho-1-pipeline-de-detecção-de-objetos)
- [Fluxo de Trabalho 2: Otimização e Implantação de Modelo](#fluxo-de-trabalho-2-otimização-e-implantação-de-modelo)
- [Fluxo de Trabalho 3: Preparação de Dataset Personalizado](#fluxo-de-trabalho-3-preparação-de-dataset-personalizado)
- [Guia de Seleção de Arquitetura](#guia-de-seleção-de-arquitetura)
- [Documentação de Referência](#documentação-de-referência)
- [Comandos Comuns](#comandos-comuns)

## Início Rápido

```bash
# Gerar configuração de treinamento para YOLO ou Faster R-CNN
python scripts/vision_model_trainer.py models/ --task detection --arch yolov8

# Analisar modelo para oportunidades de otimização (quantização, pruning)
python scripts/inference_optimizer.py model.pt --target onnx --benchmark

# Construir pipeline de dataset com augmentações
python scripts/dataset_pipeline_builder.py images/ --format coco --augment
```

## Especialização Principal

Esta skill fornece orientação sobre:

- **Detecção de Objetos**: Família YOLO (v5-v11), Faster R-CNN, DETR, RT-DETR
- **Segmentação de Instâncias**: Mask R-CNN, YOLACT, SOLOv2
- **Segmentação Semântica**: DeepLabV3+, SegFormer, SAM (Segment Anything)
- **Classificação de Imagens**: ResNet, EfficientNet, Vision Transformers (ViT, DeiT)
- **Análise de Vídeo**: Rastreamento de objetos (ByteTrack, SORT), reconhecimento de ação
- **Visão 3D**: Estimativa de profundidade, processamento de nuvem de pontos, NeRF
- **Implantação em Produção**: ONNX, TensorRT, OpenVINO, CoreML

## Tech Stack

| Categoria | Tecnologias |
|----------|--------------|
| Frameworks | PyTorch, torchvision, timm |
| Detecção | Ultralytics (YOLO), Detectron2, MMDetection |
| Segmentação | segment-anything, mmsegmentation |
| Otimização | ONNX, TensorRT, OpenVINO, torch.compile |
| Processamento de Imagem | OpenCV, Pillow, albumentations |
| Anotação | CVAT, Label Studio, Roboflow |
| Rastreamento de Experimentos | MLflow, Weights & Biases |
| Serving | Triton Inference Server, TorchServe |

## Fluxo de Trabalho 1: Pipeline de Detecção de Objetos

Use este fluxo de trabalho ao construir um sistema de detecção de objetos do zero.

### Passo 1: Definir Requisitos de Detecção

Analisar os requisitos da tarefa de detecção:

```
Análise de Requisitos de Detecção:
- Objetos-alvo: [listar classes específicas a detectar]
- Requisito de tempo real: [sim/não, FPS alvo]
- Prioridade de acurácia: [trade-off velocidade vs acurácia]
- Alvo de implantação: [GPU cloud, dispositivo edge, mobile]
- Tamanho do dataset: [número de imagens, anotações por classe]
```

### Passo 2: Selecionar Arquitetura de Detecção

Escolher arquitetura com base nos requisitos:

| Requisito | Arquitetura Recomendada | Por que |
|-------------|-------------------------|-----|
| Tempo real (>30 FPS) | YOLOv8/v11, RT-DETR | Single-stage, otimizado para velocidade |
| Alta acurácia | Faster R-CNN, DINO | Two-stage, melhor localização |
| Objetos pequenos | YOLO + SAHI, Faster R-CNN + FPN | Detecção multi-escala |
| Implantação edge | YOLOv8n, MobileNetV3-SSD | Arquiteturas leves |
| Baseado em Transformer | DETR, DINO, RT-DETR | End-to-end, sem NMS necessário |

### Passo 3: Preparar Dataset

Converter anotações para o formato necessário:

```bash
# Formato COCO (recomendado)
python scripts/dataset_pipeline_builder.py data/images/ \
    --annotations data/labels/ \
    --format coco \
    --split 0.8 0.1 0.1 \
    --output data/coco/

# Verificar dataset
python -c "from pycocotools.coco import COCO; coco = COCO('data/coco/train.json'); print(f'Imagens: {len(coco.imgs)}, Categorias: {len(coco.cats)}')"
```

### Passo 4: Configurar Treinamento

Gerar configuração de treinamento:

```bash
# Para Ultralytics YOLO
python scripts/vision_model_trainer.py data/coco/ \
    --task detection \
    --arch yolov8m \
    --epochs 100 \
    --batch 16 \
    --imgsz 640 \
    --output configs/

# Para Detectron2
python scripts/vision_model_trainer.py data/coco/ \
    --task detection \
    --arch faster_rcnn_R_50_FPN \
    --framework detectron2 \
    --output configs/
```

### Passo 5: Treinar e Validar

```bash
# Treinamento Ultralytics
yolo detect train data=data.yaml model=yolov8m.pt epochs=100 imgsz=640

# Treinamento Detectron2
python train_net.py --config-file configs/faster_rcnn.yaml --num-gpus 1

# Validar no conjunto de teste
yolo detect val model=runs/detect/train/weights/best.pt data=data.yaml
```

### Passo 6: Avaliar Resultados

Métricas principais a analisar:

| Métrica | Meta | Descrição |
|--------|--------|-------------|
| mAP@50 | >0.7 | Mean Average Precision com IoU 0.5 |
| mAP@50:95 | >0.5 | Métrica primária COCO |
| Precisão | >0.8 | Poucos falsos positivos |
| Recall | >0.8 | Poucas detecções perdidas |
| Tempo de inferência | <33ms | Para 30 FPS em tempo real |

## Fluxo de Trabalho 2: Otimização e Implantação de Modelo

Use este fluxo de trabalho ao preparar um modelo treinado para implantação em produção.

### Passo 1: Avaliar Desempenho de Baseline

```bash
# Medir desempenho atual do modelo
python scripts/inference_optimizer.py model.pt \
    --benchmark \
    --input-size 640 640 \
    --batch-sizes 1 4 8 16 \
    --warmup 10 \
    --iterations 100
```

Saída esperada:

```
Desempenho Baseline (PyTorch FP32):
- Batch 1: 45.2ms (22.1 FPS)
- Batch 4: 89.4ms (44.7 FPS)
- Batch 8: 165.3ms (48.4 FPS)
- Memória: 2.1 GB
- Parâmetros: 25.9M
```

### Passo 2: Selecionar Estratégia de Otimização

| Meta de Implantação | Caminho de Otimização |
|-------------------|-------------------|
| GPU NVIDIA (cloud) | PyTorch → ONNX → TensorRT FP16 |
| GPU NVIDIA (edge) | PyTorch → TensorRT INT8 |
| CPU Intel | PyTorch → ONNX → OpenVINO |
| Apple Silicon | PyTorch → CoreML |
| CPU genérico | PyTorch → ONNX Runtime |
| Mobile | PyTorch → TFLite ou ONNX Mobile |

### Passo 3: Exportar para ONNX

```bash
# Exportar com tamanho de batch dinâmico
python scripts/inference_optimizer.py model.pt \
    --export onnx \
    --input-size 640 640 \
    --dynamic-batch \
    --simplify \
    --output model.onnx

# Verificar modelo ONNX
python -c "import onnx; model = onnx.load('model.onnx'); onnx.checker.check_model(model); print('Modelo ONNX válido')"
```

### Passo 4: Aplicar Quantização (Opcional)

Para quantização INT8 com calibração:

```bash
# Gerar dataset de calibração
python scripts/inference_optimizer.py model.onnx \
    --quantize int8 \
    --calibration-data data/calibration/ \
    --calibration-samples 500 \
    --output model_int8.onnx
```

Análise do impacto da quantização:

| Precisão | Tamanho | Velocidade | Queda de Acurácia |
|-----------|------|-------|---------------|
| FP32 | 100% | 1x | 0% |
| FP16 | 50% | 1.5-2x | <0.5% |
| INT8 | 25% | 2-4x | 1-3% |

### Passo 5: Converter para Runtime Alvo

```bash
# TensorRT (GPU NVIDIA)
trtexec --onnx=model.onnx --saveEngine=model.engine --fp16

# OpenVINO (Intel)
mo --input_model model.onnx --output_dir openvino/

# CoreML (Apple)
python -c "import coremltools as ct; model = ct.convert('model.onnx'); model.save('model.mlpackage')"
```

### Passo 6: Avaliar Desempenho do Modelo Otimizado

```bash
python scripts/inference_optimizer.py model.engine \
    --benchmark \
    --runtime tensorrt \
    --compare model.pt
```

Speedup esperado:

```
Resultados de Otimização:
- Original (PyTorch FP32): 45.2ms
- Otimizado (TensorRT FP16): 12.8ms
- Speedup: 3.5x
- Mudança de acurácia: -0.3% mAP
```

## Fluxo de Trabalho 3: Preparação de Dataset Personalizado

Use este fluxo de trabalho ao preparar um dataset de visão computacional para treinamento.

### Passo 1: Auditar Dados Brutos

```bash
# Analisar dataset de imagens
python scripts/dataset_pipeline_builder.py data/raw/ \
    --analyze \
    --output analysis/
```

O relatório de análise inclui:

```
Análise do Dataset:
- Total de imagens: 5.234
- Tamanhos de imagem: 640x480 a 4096x3072 (variável)
- Formatos: JPEG (4.891), PNG (343)
- Corrompidos: 12 arquivos
- Duplicatas: 45 pares

Análise de Anotações:
- Formato detectado: Pascal VOC XML
- Total de anotações: 28.456
- Classes: 5 (carro, pessoa, bicicleta, cachorro, gato)
- Distribuição: carro (12.340), pessoa (8.234), bicicleta (3.456), cachorro (2.890), gato (1.536)
- Imagens vazias: 234
```

### Passo 2: Limpar e Validar

```bash
# Remover imagens corrompidas e duplicadas
python scripts/dataset_pipeline_builder.py data/raw/ \
    --clean \
    --remove-corrupted \
    --remove-duplicates \
    --output data/cleaned/
```

### Passo 3: Converter Formato de Anotação

```bash
# Converter VOC para formato COCO
python scripts/dataset_pipeline_builder.py data/cleaned/ \
    --annotations data/annotations/ \
    --input-format voc \
    --output-format coco \
    --output data/coco/
```

Conversões de formato suportadas:

| De | Para |
|------|-----|
| Pascal VOC XML | COCO JSON |
| YOLO TXT | COCO JSON |
| COCO JSON | YOLO TXT |
| LabelMe JSON | COCO JSON |
| CVAT XML | COCO JSON |

### Passo 4: Aplicar Augmentações

```bash
# Gerar configuração de augmentação
python scripts/dataset_pipeline_builder.py data/coco/ \
    --augment \
    --aug-config configs/augmentation.yaml \
    --output data/augmented/
```

Augmentações recomendadas para detecção:

```yaml
# configs/augmentation.yaml
augmentations:
  geometric:
    - horizontal_flip: { p: 0.5 }
    - vertical_flip: { p: 0.1 }  # Apenas se invariante à orientação
    - rotate: { limit: 15, p: 0.3 }
    - scale: { scale_limit: 0.2, p: 0.5 }

  color:
    - brightness_contrast: { brightness_limit: 0.2, contrast_limit: 0.2, p: 0.5 }
    - hue_saturation: { hue_shift_limit: 20, sat_shift_limit: 30, p: 0.3 }
    - blur: { blur_limit: 3, p: 0.1 }

  advanced:
    - mosaic: { p: 0.5 }  # Mosaico estilo YOLO
    - mixup: { p: 0.1 }   # Mistura de imagens
    - cutout: { num_holes: 8, max_h_size: 32, max_w_size: 32, p: 0.3 }
```

### Passo 5: Criar Divisões Treino/Val/Teste

```bash
python scripts/dataset_pipeline_builder.py data/augmented/ \
    --split 0.8 0.1 0.1 \
    --stratify \
    --seed 42 \
    --output data/final/
```

Diretrizes de estratégia de divisão:

| Tamanho do Dataset | Treino | Val | Teste |
|--------------|-------|-----|------|
| <1.000 imagens | 70% | 15% | 15% |
| 1.000-10.000 | 80% | 10% | 10% |
| >10.000 | 90% | 5% | 5% |

### Passo 6: Gerar Configuração do Dataset

```bash
# Para Ultralytics YOLO
python scripts/dataset_pipeline_builder.py data/final/ \
    --generate-config yolo \
    --output data.yaml

# Para Detectron2
python scripts/dataset_pipeline_builder.py data/final/ \
    --generate-config detectron2 \
    --output detectron2_config.py
```

## Guia de Seleção de Arquitetura

### Arquiteturas de Detecção de Objetos

| Arquitetura | Velocidade | Acurácia | Melhor Para |
|--------------|-------|----------|----------|
| YOLOv8n | 1.2ms | 37.3 mAP | Edge, mobile, tempo real |
| YOLOv8s | 2.1ms | 44.9 mAP | Velocidade/acurácia balanceados |
| YOLOv8m | 4.2ms | 50.2 mAP | Uso geral |
| YOLOv8l | 6.8ms | 52.9 mAP | Alta acurácia |
| YOLOv8x | 10.1ms | 53.9 mAP | Acurácia máxima |
| RT-DETR-L | 5.3ms | 53.0 mAP | Transformer, sem NMS |
| Faster R-CNN R50 | 46ms | 40.2 mAP | Two-stage, alta qualidade |
| DINO-4scale | 85ms | 49.0 mAP | SOTA transformer |

### Arquiteturas de Segmentação

| Arquitetura | Tipo | Velocidade | Melhor Para |
|--------------|------|-------|----------|
| YOLOv8-seg | Instância | 4.5ms | Segmentação de instância em tempo real |
| Mask R-CNN | Instância | 67ms | Máscaras de alta qualidade |
| SAM | Guiado | 50ms | Segmentação zero-shot |
| DeepLabV3+ | Semântica | 25ms | Análise de cena |
| SegFormer | Semântica | 15ms | Segmentação semântica eficiente |

### Trade-offs CNN vs Vision Transformer

| Aspecto | CNN (YOLO, R-CNN) | ViT (DETR, DINO) |
|--------|-------------------|------------------|
| Dados de treinamento necessários | 1K-10K imagens | 10K-100K+ imagens |
| Tempo de treinamento | Rápido | Lento (precisa de mais épocas) |
| Velocidade de inferência | Mais rápido | Mais lento |
| Objetos pequenos | Bom com FPN | Precisa multi-escala |
| Contexto global | Limitado | Excelente |
| Codificação posicional | Implícita | Explícita |

## Documentação de Referência
→ Veja references/reference-docs-and-commands.md para detalhes

## Metas de Desempenho

| Métrica | Tempo Real | Alta Acurácia | Edge |
|--------|-----------|---------------|------|
| FPS | >30 | >10 | >15 |
| mAP@50 | >0.6 | >0.8 | >0.5 |
| Latência P99 | <50ms | <150ms | <100ms |
| Memória GPU | <4GB | <8GB | <2GB |
| Tamanho do Modelo | <50MB | <200MB | <20MB |

## Recursos

- **Guia de Arquitetura**: `references/computer_vision_architectures.md`
- **Guia de Otimização**: `references/object_detection_optimization.md`
- **Guia de Implantação**: `references/production_vision_systems.md`
- **Scripts**: diretório `scripts/` para ferramentas de automação
