# Implementation Guide

## Context

Aplicación Flutter de calculadora de cambio de divisas (FIAT ↔ CRYPTO).

## Documentos de Referencia

- `docs/PRD.md` - Requisitos del producto y UI specs
- `docs/TECHNICAL_SPEC.md` - Especificaciones técnicas

## Orden de Implementación

### Phase 1: Setup

1. Ejecutar `flutter create .`
2. Configurar pubspec.yaml (ver TECHNICAL_SPEC.md sección 1.2)
3. Crear analysis_options.yaml (ver TECHNICAL_SPEC.md sección 5.1)
4. Crear estructura de carpetas (ver TECHNICAL_SPEC.md sección 3)
5. Configurar lefthook.yml (ver TECHNICAL_SPEC.md sección 6.3)
6. Crear .gitignore

### Phase 2: Core

1. Setup DI (GetIt + Injectable)
2. Crear constantes del API
3. Configurar Dio client
4. Configurar GoRouter
5. Crear theme (colors, text styles)

### Phase 3: Data Layer

1. Crear models con Freezed
2. Crear API client con Retrofit
3. Implementar datasources
4. Implementar repositories

### Phase 4: Domain Layer

1. Crear entities
2. Crear repository interfaces
3. Crear use cases

### Phase 5: Presentation Layer

1. Crear states con Freezed
2. Crear providers con Riverpod
3. Crear widgets (según PRD.md sección 13)
4. Crear página principal
5. Crear bottom sheets

### Phase 6: Testing

1. Unit tests para use cases
2. Unit tests para repositories
3. Widget tests
4. Integration tests

## Validaciones por Fase

- Ejecutar `flutter analyze` (0 issues)
- Ejecutar `flutter test`
- Verificar naming conventions

## UI Reference

Seguir specs de PRD.md sección 13 para:

- Colores (#FDB022, #E8F5F7, etc.)
- Spacing (16px, 24px, etc.)
- Border radius (12px, 16px, 28px)
- Font sizes y weights
