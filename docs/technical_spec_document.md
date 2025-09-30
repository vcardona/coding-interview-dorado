# Documento de Especificaciones Técnicas
## Currency Exchange Calculator - Flutter

---

## 1. Stack Tecnológico

### 1.1 Versiones Requeridas
- **Flutter SDK**: >= 3.16.0
- **Dart SDK**: >= 3.0.0 < 4.0.0

### 1.2 Dependencias del Proyecto

#### State Management
- **flutter_riverpod**: ^2.4.9
- **riverpod_annotation**: ^2.3.3
- **riverpod_generator**: ^2.3.9 (dev)

#### Navegación
- **go_router**: ^13.0.0

#### Dependency Injection
- **get_it**: ^7.6.4
- **injectable**: ^2.3.2
- **injectable_generator**: ^2.4.1 (dev)

#### Networking
- **dio**: ^5.4.0
- **retrofit**: ^4.0.3
- **retrofit_generator**: ^8.0.6 (dev)
- **pretty_dio_logger**: ^1.3.1

#### Utilities
- **freezed_annotation**: ^2.4.1
- **freezed**: ^2.4.6 (dev)
- **json_annotation**: ^4.8.1
- **json_serializable**: ^6.7.1 (dev)
- **equatable**: ^2.0.5

#### Responsive & Adaptive
- **responsive_framework**: ^1.1.1

#### Testing
- **mockito**: ^5.4.4 (dev)
- **flutter_test**: sdk (dev)
- **integration_test**: sdk (dev)

#### Linting
- **very_good_analysis**: ^5.1.0 (dev)
- **flutter_lints**: ^3.0.1 (dev)

#### Code Generation
- **build_runner**: ^2.4.7 (dev)

---

## 2. Arquitectura del Proyecto

### 2.1 Patrón Arquitectónico
**Clean Architecture + Feature-First Structure (Hybrid Approach)**

### 2.2 Capas de la Arquitectura

#### Capa de Presentación (Presentation Layer)
- **Responsabilidad**: UI, widgets, páginas, state management
- **Tecnología**: Flutter widgets, Riverpod providers
- **Subcapas**:
  - `pages/`: Pantallas completas de la aplicación
  - `widgets/`: Componentes reutilizables de UI
  - `providers/`: Gestores de estado con Riverpod
  - `state/`: Definiciones de estados con Freezed

#### Capa de Dominio (Domain Layer)
- **Responsabilidad**: Lógica de negocio, reglas de la aplicación
- **Independiente**: No depende de frameworks externos
- **Subcapas**:
  - `entities/`: Objetos de negocio puros
  - `repositories/`: Interfaces (contratos) de repositorios
  - `usecases/`: Casos de uso específicos (Single Responsibility)

#### Capa de Datos (Data Layer)
- **Responsabilidad**: Acceso a datos, implementación de repositorios
- **Subcapas**:
  - `models/`: Modelos de datos con serialización JSON
  - `datasources/`: Fuentes de datos (remote, local)
  - `repositories/`: Implementaciones de interfaces del dominio

#### Capa Core
- **Responsabilidad**: Funcionalidades compartidas, configuraciones
- **Componentes**:
  - `config/`: Configuraciones de la app
  - `constants/`: Constantes globales
  - `di/`: Inyección de dependencias
  - `errors/`: Manejo de errores y excepciones
  - `network/`: Configuración de red
  - `routes/`: Configuración de navegación
  - `utils/`: Utilidades y helpers

#### Capa Shared
- **Responsabilidad**: Elementos compartidos entre features
- **Componentes**:
  - `widgets/`: Widgets reutilizables globales
  - `theme/`: Temas, colores, estilos

---

## 3. Estructura de Carpetas

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── config/
│   ├── constants/
│   ├── di/
│   ├── errors/
│   ├── network/
│   ├── routes/
│   └── utils/
├── features/
│   └── currency_exchange/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── pages/
│           ├── widgets/
│           ├── providers/
│           └── state/
└── shared/
    ├── widgets/
    └── theme/

test/
├── unit/
├── widget/
└── integration/

integration_test/
```

---

## 4. Convenciones de Código

### 4.1 Nomenclatura de Archivos
- **Formato**: `snake_case.dart`
- **Sufijos descriptivos**:
  - `_page.dart` para páginas
  - `_widget.dart` para widgets
  - `_model.dart` para modelos de datos
  - `_entity.dart` para entidades de dominio
  - `_repository.dart` para repositorios
  - `_repository_impl.dart` para implementaciones
  - `_datasource.dart` para fuentes de datos
  - `_usecase.dart` para casos de uso
  - `_provider.dart` para providers de Riverpod
  - `_state.dart` para estados

**Ejemplos**:
- `currency_exchange_page.dart`
- `currency_selector_widget.dart`
- `exchange_rate_model.dart`
- `currency_repository_impl.dart`

### 4.2 Nomenclatura de Clases
- **Formato**: `PascalCase`
- **Descriptivo y específico**

**Ejemplos**:
- `CurrencyExchangePage`
- `CurrencySelectorWidget`
- `GetExchangeRateUseCase`
- `CurrencyRepositoryImpl`

### 4.3 Nomenclatura de Variables y Métodos
- **Variables**: `lowerCamelCase`
- **Métodos**: `lowerCamelCase` (verbo + sustantivo)
- **Constantes**: `lowerCamelCase` o `UPPER_SNAKE_CASE`

**Ejemplos**:
```dart
// Variables
selectedCurrency
exchangeRateValue
isLoading

// Métodos
fetchExchangeRate()
calculateConversion()
validateAmount()

// Constantes
const apiBaseUrl = '...';
const double minAmount = 0.01;
static const String API_KEY = '...';
```

### 4.4 Nomenclatura de Providers
**Formato**: `descriptiveNameProvider`

**Ejemplos**:
- `currencyExchangeProvider`
- `exchangeRateProvider`
- `selectedCurrencyProvider`

---

## 5. Configuración de Linting

### 5.1 Archivo analysis_options.yaml

**Configuración requerida**:
- Base: `very_good_analysis`
- Excluir archivos generados: `*.g.dart`, `*.freezed.dart`, `*.config.dart`
- Reglas personalizadas:
  - `prefer_single_quotes: true`
  - `always_use_package_imports: true`
  - `avoid_print: true`
  - `lines_longer_than_80_chars: false`
  - `public_member_api_docs: false`

### 5.2 Configuración de VSCode

**settings.json requerido**:
- `formatOnSave: true`
- `organizeImports: true`
- `dart.lineLength: 80`

---

## 6. Control de Versiones (Git)

### 6.1 Estrategia de Branching: GitFlow

**Branches principales**:
- `main`: Código en producción
- `develop`: Rama de desarrollo

**Branches de trabajo**:
- `feature/*`: Nuevas funcionalidades
- `bugfix/*`: Corrección de bugs
- `hotfix/*`: Correcciones urgentes en producción
- `release/*`: Preparación de releases

### 6.2 Conventional Commits

**Formato**: `<type>(<scope>): <subject>`

**Types permitidos**:
- `feat`: Nueva funcionalidad
- `fix`: Corrección de bug
- `docs`: Documentación
- `style`: Formato (no afecta código)
- `refactor`: Refactorización
- `test`: Tests
- `chore`: Mantenimiento

**Ejemplos**:
```
feat(exchange): add currency selector widget
fix(api): handle network timeout errors
test(exchange): add unit tests for conversion logic
docs(readme): update setup instructions
```

### 6.3 Pre-commit Hooks

**Herramienta**: Lefthook

**Validaciones automáticas**:
1. Formateo de código (`dart format`)
2. Análisis estático (`flutter analyze`)
3. Ejecución de tests (`flutter test`)

---

## 7. State Management

### 7.1 Solución: Riverpod

**Justificación**:
- Type-safe
- Compile-time safety
- Testeable
- Sin BuildContext
- Code generation support

### 7.2 Tipos de Providers a Utilizar

**StateNotifierProvider**:
- Para estados mutables complejos
- Uso principal en la feature de currency exchange

**FutureProvider**:
- Para llamadas asíncronas
- Uso en fetching de datos del API

**StreamProvider** (opcional):
- Para streams de datos
- Uso si se requiere actualización en tiempo real

### 7.3 Estado con Freezed

**Patrón**: Union types para diferentes estados
- `initial`: Estado inicial
- `loading`: Cargando datos
- `success`: Operación exitosa con datos
- `error`: Error con mensaje

---

## 8. Dependency Injection

### 8.1 Solución: GetIt + Injectable

**GetIt**: Service locator
**Injectable**: Code generation para registro automático

### 8.2 Tipos de Registro

**LazySingleton**:
- Instancia única creada cuando se necesita
- Uso: Repositories, DataSources, Services

**Singleton**:
- Instancia única creada al inicio
- Uso: Configuraciones globales

**Factory**:
- Nueva instancia cada vez
- Uso: UseCases

---

## 9. Networking

### 9.1 Cliente HTTP: Dio

**Configuración requerida**:
- Base URL del API
- Timeouts (30 segundos)
- Headers por defecto
- Logging con PrettyDioLogger

### 9.2 API Client: Retrofit

**Características**:
- Type-safe API calls
- Code generation
- Integración con Dio
- Manejo de query parameters

### 9.3 Especificaciones del API

**Endpoint**: `/orderbook/public/recommendations`
**Base URL**: `https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage`

**Query Parameters**:
- `type`: 0 (CRYPTO→FIAT) o 1 (FIAT→CRYPTO)
- `cryptoCurrencyId`: ID de la crypto
- `fiatCurrencyId`: ID de la fiat
- `amount`: Cantidad a convertir
- `amountCurrencyId`: Moneda del input

**Response**: Extraer `data.byPrice.fiatToCryptoExchangeRate`

---

## 10. Testing

### 10.1 Estrategia de Testing

**Objetivo**: Coverage > 80% (ideal 100%)

### 10.2 Tipos de Tests

#### Unit Tests
- **Qué testear**: UseCases, Repositories, Business Logic
- **Herramienta**: Mockito para mocks
- **Ubicación**: `test/unit/`

#### Widget Tests
- **Qué testear**: Widgets individuales, comportamiento UI
- **Herramienta**: flutter_test
- **Ubicación**: `test/widget/`

#### Integration Tests
- **Qué testear**: Flujos completos de la aplicación
- **Herramienta**: integration_test
- **Ubicación**: `integration_test/`

### 10.3 Configuración de Coverage

**Excluir de coverage**:
- Archivos generados (*.g.dart, *.freezed.dart, *.config.dart)
- main.dart
- injection.config.dart

---

## 11. Responsive Design

### 11.1 Solución: Responsive Framework

### 11.2 Breakpoints Definidos

- **Mobile**: 0 - 450px
- **Tablet**: 451 - 800px
- **Desktop**: 801 - 1920px
- **4K**: 1921px+

### 11.3 Estrategia

- Diseño mobile-first
- Adaptación de spacing y font sizes
- Layouts diferentes para desktop si es necesario

---

## 12. Navegación

### 12.1 Solución: GoRouter

**Características**:
- Declarative routing
- Deep linking support
- Type-safe navigation
- URL-based routing

### 12.2 Estructura de Rutas

- Rutas definidas en `core/routes/app_router.dart`
- Nombres de rutas en constantes (`core/routes/route_names.dart`)
- Integración con Riverpod para state-aware routing

---

## 13. Manejo de Errores

### 13.1 Tipos de Excepciones

**ServerException**: Errores del servidor API
**NetworkException**: Problemas de conexión
**ValidationException**: Errores de validación de inputs
**CacheException**: Errores de caché (si aplica)

### 13.2 Failures

Conversión de excepciones a failures en la capa de dominio:
- **ServerFailure**
- **NetworkFailure**
- **ValidationFailure**

---

## 14. Theme y Estilos

### 14.1 Paleta de Colores

**Colores Primarios**:
- Primary: #FDB022 (Amarillo/Naranja)
- Primary Light: #FFE082
- Primary Dark: #F57C00

**Backgrounds**:
- Background Light: #E8F5F7 (Cyan claro)
- Card Background: #FAF8F6 (Beige claro)
- White: #FFFFFF

**Texto**:
- Text Primary: #212121
- Text Secondary: #757575
- Text Hint: #BDBDBD

**Bordes**:
- Border: #E0E0E0
- Border Focused: #FDB022

**Estados**:
- Error: #F44336
- Success: #4CAF50

### 14.2 Sistema de Tipografía

**Tamaños**:
- Display: 32px
- Headline: 20-24px
- Body: 14-16px
- Label: 12-14px
- Currency Code: 16-18px
- Amount: 20-24px
- Button: 18px

**Pesos**:
- Bold: 700
- Semi-bold: 600
- Regular: 400

### 14.3 Sistema de Espaciado

- xs: 4px
- sm: 8px
- md: 12px
- base: 16px
- lg: 24px
- xl: 32px
- xxl: 48px

### 14.4 Border Radius

- Small: 8px (íconos, elementos pequeños)
- Medium: 12px (inputs, buttons, cards)
- Large: 16px (bottom sheets, card principal)
- Pill: 28px (selector row)
- Circle: 50% (swap button)

---

## 15. Assets

### 15.1 Ubicación

```
assets/
├── fiat/
│   ├── ves_icon.png
│   ├── cop_icon.png
│   ├── ars_icon.png
│   ├── pen_icon.png
│   ├── brl_icon.png
│   └── bob_icon.png
└── crypto/
    ├── usdt_icon.png
    └── usdc_icon.png
```

### 15.2 Configuración en pubspec.yaml

Registrar todos los assets en la sección `flutter.assets`

### 15.3 Convención de Nombres

Formato: `{currencyId}_icon.{extension}`
- El ID debe coincidir con el usado en el API
- Extraer IDs de los nombres de archivos de assets

---

## 16. Modelos de Datos

### 16.1 Serialización

**Herramienta**: json_serializable + Freezed

**Características**:
- Immutability con Freezed
- JSON serialization automática
- CopyWith methods
- Equality comparisons

### 16.2 Modelos vs Entities

**Models (Data Layer)**:
- Con anotaciones de serialización
- Mapeo directo con API response
- Incluye `fromJson` y `toJson`

**Entities (Domain Layer)**:
- Sin dependencias externas
- Lógica de negocio pura
- Sin serialización

---

## 17. Code Generation

### 17.1 Comandos

**Build completo**:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Watch mode (desarrollo)**:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### 17.2 Archivos Generados

- `*.g.dart`: JSON serialization
- `*.freezed.dart`: Freezed classes
- `*.config.dart`: Injectable DI

---

## 18. Comandos de Desarrollo

### 18.1 Análisis y Formato

```bash
# Análisis estático
flutter analyze

# Formatear código
dart format lib/ test/

# Fix automático
dart fix --apply
```

### 18.2 Testing

```bash
# Todos los tests
flutter test

# Con coverage
flutter test --coverage

# Tests específicos
flutter test test/unit/

# Integration tests
flutter test integration_test/
```

### 18.3 Ejecución

```bash
# Debug
flutter run

# Release
flutter run --release

# Device específico
flutter run -d <device_id>
```

---

## 19. Documentación Requerida

### 19.1 README.md

**Debe incluir**:
- Descripción del proyecto
- Requisitos previos
- Instrucciones de instalación
- Comandos para ejecutar
- Estructura del proyecto
- Convenciones de código
- Cómo ejecutar tests
- Cómo contribuir

### 19.2 CODING_STYLE.md

**Debe incluir**:
- Razones de las reglas de estilo
- Cómo nombrar archivos
- Cuándo escribir comentarios
- Ejemplos de good/bad practices

---

## 20. CI/CD (Opcional pero Recomendado)

### 20.1 Pipeline Básico

**Stages**:
1. Install dependencies
2. Code generation
3. Static analysis
4. Run tests
5. Generate coverage report

### 20.2 Validaciones

- `flutter analyze` debe pasar sin warnings
- `flutter test` debe pasar al 100%
- Coverage debe ser > 80%

---

## 21. Performance y Optimización

### 21.1 Mejores Prácticas

- Uso de `const` constructors donde sea posible
- Evitar rebuilds innecesarios con Riverpod
- Lazy loading de imágenes
- Debouncing en inputs de texto
- Caching de responses del API (opcional)

### 21.2 Métricas

- Tiempo de respuesta de UI < 16ms (60 FPS)
- Tiempo de llamada al API < 2 segundos
- Tamaño de APK optimizado

---

## 22. Security

### 22.1 Configuración de Entornos

- No hardcodear API keys
- Usar variables de entorno
- Diferentes configs para dev/prod

### 22.2 Validación de Inputs

- Validar todos los inputs del usuario
- Sanitizar datos antes de enviar al API
- Manejo seguro de errores (no exponer detalles internos)

---

## 23. Accessibility

### 23.1 Requerimientos

- Semantic labels en widgets
- Contrast ratio adecuado (WCAG AA)
- Touch targets mínimo 48x48dp
- Screen reader support

---

## 24. Entregables Técnicos

### 24.1 Código
- Repositorio con código fuente completo
- Estructura de carpetas según especificación
- Commits siguiendo conventional commits

### 24.2 Tests
- Unit tests con > 80% coverage
- Widget tests para componentes principales
- Al menos 1 integration test

### 24.3 Documentación
- README.md completo
- CODING_STYLE.md
- Comentarios en código complejo

### 24.4 Configuración
- analysis_options.yaml configurado
- lefthook.yml para pre-commit hooks
- .gitignore completo

---

**Documento preparado para**: Prueba técnica Flutter Developer  
**Fecha**: Septiembre 30, 2025  
**Versión**: 1.0