# Product Requirements Document (PRD)
## Currency Exchange Calculator

---

## 1. Visión General del Producto

### 1.1 Propósito
Desarrollar una aplicación móvil de calculadora de cambio de divisas que permita a los usuarios convertir entre monedas FIAT y CRYPTO en tiempo real, mostrando la cantidad que recibirían al realizar un cambio.

### 1.2 Alcance
Esta es una prueba técnica para demostrar capacidades de desarrollo en Flutter, enfocada en una funcionalidad específica de conversión de divisas con integración a API pública.

### 1.3 Objetivos del Proyecto
- Crear una interfaz intuitiva para conversión de divisas
- Integrar API pública para obtener tasas de cambio en tiempo real
- Demostrar mejores prácticas de desarrollo Flutter
- Implementar arquitectura escalable y mantenible

---

## 2. Requisitos Funcionales

### 2.1 Tipos de Monedas Soportadas
- **FIAT**: Monedas tradicionales (USD, EUR, COP, etc.)
- **CRYPTO**: Criptomonedas (BTC, ETH, etc.)

### 2.2 Funcionalidades Principales

#### RF-001: Selección de Monedas
- El usuario debe poder seleccionar una moneda de origen
- El usuario debe poder seleccionar una moneda de destino
- El sistema debe identificar automáticamente si es FIAT o CRYPTO según la selección

#### RF-002: Ingreso de Cantidad
- El usuario debe poder ingresar la cantidad a convertir
- El sistema debe validar que sea un número válido
- El sistema debe permitir decimales
- La cantidad mínima debe ser mayor a 0

#### RF-003: Cálculo de Conversión
- El sistema debe calcular automáticamente la conversión al cambiar:
  - Moneda de origen
  - Moneda de destino
  - Cantidad ingresada
- El cálculo debe usar la tasa de cambio obtenida del API
- El resultado debe mostrarse en tiempo real

#### RF-004: Visualización de Resultados
- Mostrar la cantidad convertida
- Mostrar la tasa de cambio aplicada
- Mostrar claramente qué moneda es origen y cuál destino

#### RF-005: Intercambio de Monedas
- Botón para intercambiar moneda origen y destino
- Al intercambiar, recalcular automáticamente

---

## 3. Integración con API

### 3.1 Endpoint
```
GET https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations
```

### 3.2 Query Parameters
| Parámetro | Tipo | Descripción | Valores |
|-----------|------|-------------|---------|
| type | int | Dirección de conversión | 0: CRYPTO→FIAT, 1: FIAT→CRYPTO |
| cryptoCurrencyId | string | ID de la criptomoneda | Del nombre del asset |
| fiatCurrencyId | string | ID de la moneda FIAT | Del nombre del asset |
| amount | decimal | Cantidad a convertir | > 0 |
| amountCurrencyId | string | Moneda del input | ID de la moneda origen |

### 3.3 Response
Extraer del response: `data.byPrice.fiatToCryptoExchangeRate`

### 3.4 Lógica de Cálculo
- Multiplicar o dividir según la dirección de conversión
- Aplicar la tasa para mostrar el resultado final

---

## 4. Requisitos No Funcionales

### 4.1 Performance
- Tiempo de respuesta del API < 2 segundos
- La UI debe permanecer responsiva durante las llamadas
- Implementar loading states apropiados

### 4.2 Usabilidad
- Interfaz intuitiva y clara
- Feedback visual inmediato
- Manejo de errores amigable
- Diseño responsive (teléfonos y tablets)

### 4.3 Confiabilidad
- Manejo de errores de red
- Manejo de respuestas inválidas del API
- Validación de inputs del usuario
- Estados de error claramente comunicados

### 4.4 Mantenibilidad
- Código limpio y bien documentado
- Arquitectura clara y escalable
- Coverage de tests al 100% (objetivo)
- Commits siguiendo convenciones establecidas

---

## 5. Experiencia de Usuario

### 5.1 Flujo Principal
1. Usuario abre la aplicación
2. Ve dos selectores de moneda (origen y destino)
3. Ve un campo de input para la cantidad
4. Ingresa una cantidad
5. El sistema calcula y muestra el resultado automáticamente
6. Usuario puede cambiar cualquier parámetro y ver el resultado actualizado

### 5.2 Estados de la Aplicación
- **Inicial**: Valores por defecto, sin cálculo
- **Cargando**: Mientras se obtiene la tasa del API
- **Éxito**: Mostrando resultado del cálculo
- **Error**: Mostrando mensaje de error apropiado

### 5.3 Manejo de Errores
- Error de red: "No se pudo conectar. Verifica tu conexión"
- Error de API: "Servicio temporalmente no disponible"
- Input inválido: "Ingresa una cantidad válida"
- Validación en tiempo real con feedback visual

---

## 6. Assets y Recursos

### 6.1 Assets Proporcionados
Los assets de las monedas están en la carpeta `assets/` del repositorio
- Iconos/imágenes de monedas FIAT
- Iconos/imágenes de monedas CRYPTO
- El ID de cada moneda está en el nombre del archivo del asset

### 6.2 Colores y Tema
- Definir paleta de colores consistente
- Modo claro (requerido)
- Considerar modo oscuro (opcional)

---

## 7. Criterios de Aceptación

### 7.1 Funcionalidad
- ✅ La conversión se calcula correctamente en ambas direcciones
- ✅ La UI responde a cambios en tiempo real
- ✅ Los assets se cargan y muestran correctamente
- ✅ El intercambio de monedas funciona correctamente

### 7.2 Calidad de Código
- ✅ Pasa `flutter analyze` sin warnings
- ✅ Código formateado con `dart format`
- ✅ Cumple con `very_good_analysis` rules
- ✅ Coverage de tests > 80% (objetivo 100%)

### 7.3 Testing
- ✅ Unit tests para lógica de negocio
- ✅ Widget tests para componentes UI
- ✅ Integration tests para flujo completo
- ✅ Mocks apropiados para API calls

### 7.4 Git y Commits
- ✅ Commits siguiendo convenciones establecidas
- ✅ GitFlow implementado correctamente
- ✅ Pre-commit hooks funcionando
- ✅ README completo y actualizado

---

## 8. Fuera de Alcance (Out of Scope)

- Autenticación de usuarios
- Historial de conversiones
- Notificaciones push
- Conversiones offline
- Múltiples idiomas (i18n)
- Gráficos históricos de tasas
- Favoritos o monedas guardadas

---

## 9. Entregables

1. **Código Fuente**
   - Repositorio fork con todo el código
   - Estructura de carpetas según especificación técnica

2. **Documentación**
   - README con instrucciones de setup
   - Documento CODING_STYLE.md
   - Comentarios en código cuando sea necesario

3. **Tests**
   - Suite completa de tests
   - Reporte de coverage

4. **CI/CD**
   - Pipeline configurado
   - Análisis estático automatizado

---

## 10. Timeline y Prioridades

### Prioridad Alta (Must Have)
- Funcionalidad básica de conversión
- Integración con API
- UI funcional y responsive
- Tests unitarios básicos

### Prioridad Media (Should Have)
- Widget tests completos
- Manejo robusto de errores
- UI pulida y animaciones
- Coverage alto de tests

### Prioridad Baja (Nice to Have)
- Integration tests end-to-end
- Optimizaciones de performance
- Documentación extendida
- Analytics y crash reporting

---

## 11. Supuestos y Dependencias

### 11.1 Supuestos
- El API público estará disponible durante el desarrollo y testing
- Los assets proporcionados contienen todas las monedas necesarias
- No se requiere almacenamiento persistente de datos

### 11.2 Dependencias
- Flutter SDK (versión stable más reciente)
- Acceso a internet para llamadas al API
- Assets proporcionados en el repositorio

---

## 12. Métricas de Éxito

- ✅ Aplicación funcional sin crashes
- ✅ Conversiones precisas verificadas
- ✅ Tests passing al 100%
- ✅ Análisis estático sin issues críticos
- ✅ Código siguiendo todas las convenciones establecidas
- ✅ README claro que permita ejecutar el proyecto fácilmente

---

## 13. UI Specifications (Diseño de Referencia)

### 13.1 Main Exchange Screen

**Layout General:**
- Card principal con bordes redondeados (16px)
- Padding interno: 24px
- Background del card: Light beige/cream (#FAF8F6)
- Elevation: 4
- Background de la app: Light blue/cyan (#E8F5F7)

**Componentes Principales:**

#### 1. Currency Selector Row
- Altura: 56px
- Border radius: 28px (pill shape)
- Border: 2px solid amarillo/naranja (#FDB022)
- Background: White
- Dos selectores separados por botón de swap central
- Labels superiores: "TENGO" y "QUIERO" (12px, grey)

**Selector Individual:**
- Icono/Flag de moneda: 32x32px
- Código de moneda: 16px, semi-bold
- Dropdown indicator (chevron down)
- Padding interno: 12px

#### 2. Swap Button (Centro)
- Forma: Circular perfecta
- Background: Amarillo/naranja gradient (#FDB022)
- Icono: Flechas de intercambio (blanco)
- Size: 48x48px
- Position: Centrado verticalmente entre selectores
- Shadow: elevation 2

#### 3. Amount Input Field
- Margin top: 24px desde selectores
- Border radius: 12px
- Border: 2px solid amarillo/naranja (#FDB022)
- Background: White
- Padding: 16px
- Height: 64px

**Input Structure:**
- Prefix text: Código de moneda (USDT, VES, etc.) - 18px, bold, negro
- Input value: 20px, regular, negro
- Placeholder: "0.00"
- Decimal keyboard

#### 4. Results Section
- Margin top: 24px desde input
- Spacing entre items: 16px

**Result Items (3 rows):**
- Label (izquierda): 14px, regular, grey (#757575)
- Value (derecha): 16px, semi-bold, negro (#212121)
- Símbolo "≈" antes de valores estimados

**Items:**
1. "Tasa estimada" → "≈ 25.00 VES"
2. "Recibirás" → "≈ 125.00 VES" (más prominente)
3. "Tiempo estimado" → "≈ 10 Min"

#### 5. Action Button
- Margin top: 32px
- Width: 100% (match parent)
- Height: 56px
- Border radius: 12px
- Background: Amarillo/naranja gradient (#FDB022)
- Text: "Cambiar"
  - Color: White
  - Size: 18px
  - Weight: Semi-bold (600)
  - Centered
- No border
- Shadow: elevation 2

---

### 13.2 Currency Selector Bottom Sheet

**Container:**
- Border radius superior: 16px
- Background: White
- Height: Auto (fit content)
- Max height: 70% viewport
- Handle indicator: Grey bar centrada en top (40x4px)

**Header:**
- Title: "FIAT" o "Cripto"
  - Font: 18px, semi-bold (#212121)
  - Centered
  - Margin top: 8px
  - Margin bottom: 16px
- Divider line debajo (1px, #E0E0E0)

**List Container:**
- Padding: 16px horizontal
- Scrollable verticalmente

**Currency List Items:**
- Height: 72px cada item
- Border radius: 12px
- Padding: 12px
- Margin bottom: 8px
- Tap/Hover state: Light grey background (#F5F5F5)

**Item Structure (Left to Right):**

1. **Icon/Flag Container:**
   - Size: 48x48px
   - Border radius: 8px
   - Border: 1px solid #E0E0E0
   - Background: White
   - Icon/Flag: 40x40px centrado

2. **Currency Info (Flex):**
   - Margin left: 12px
   - Layout: Column
   
   **Currency Code:**
   - Font: 16px, bold (#212121)
   - Examples: "VES", "COP", "USDT"
   
   **Currency Name:**
   - Font: 14px, regular (#757575)
   - Margin top: 4px
   - Examples: "Bolívares (Bs)", "Pesos Colombianos (COL$)"

3. **Selection Indicator (Right):**
   - Radio button o circle
   - Size: 24x24px
   - Unselected: Border 2px #BDBDBD, background white
   - Selected: Border 2px #FDB022, inner circle #FDB022
   - Margin left: auto

---

### 13.3 Monedas Disponibles

#### FIAT Currencies:
```
VES - Bolívares (Bs) - Flag Venezuela
COP - Pesos Colombianos (COL$) - Flag Colombia
ARS - Pesos Argentinos (ARS$) - Flag Argentina
PEN - Soles Peruanos (S/) - Flag Perú
BRL - Real Brasileño (R$) - Flag Brasil
BOB - Boliviano (R$) - Flag Bolivia
```

#### CRYPTO Currencies:
```
USDT - Tether (USDT) - Tether icon (verde)
USDC - USD Coin (USDC) - USDC icon (azul)
```

---

### 13.4 Color Palette

```dart
// Primary Colors
primary: #FDB022 (Amarillo/Naranja)
primaryLight: #FFE082
primaryDark: #F57C00

// Backgrounds
backgroundLight: #E8F5F7 (Light cyan/blue)
cardBackground: #FAF8F6 (Beige claro)
white: #FFFFFF

// Text
textPrimary: #212121
textSecondary: #757575
textHint: #BDBDBD

// Borders
border: #E0E0E0
borderFocused: #FDB022

// Status
error: #F44336
success: #4CAF50
```

---

### 13.5 Typography

```dart
// Headings
headline: 20px, semi-bold (600)
title: 18px, semi-bold (600)

// Body
bodyLarge: 16px, regular (400)
bodyMedium: 14px, regular (400)

// Special
currencyCode: 16-18px, bold (700)
amount: 20px, regular (400)
label: 12-14px, regular (400)
button: 18px, semi-bold (600)
```

---

### 13.6 Spacing System

```dart
xs: 4px
sm: 8px
md: 12px
base: 16px
lg: 24px
xl: 32px
xxl: 48px
```

---

### 13.7 Border Radius

```dart
small: 8px (icons, small elements)
medium: 12px (inputs, buttons, cards)
large: 16px (bottom sheets, main card)
pill: 28px (selector row - half of height)
circle: 50% (swap button)
```

---

### 13.8 Shadows/Elevation

```dart
card: elevation 4
button: elevation 2
bottomSheet: elevation 8
```

---

### 13.9 Responsive Breakpoints

```dart
mobile: 0 - 450px (diseño mostrado)
tablet: 451 - 800px (ajustar padding y sizes)
desktop: 801+ (centrar card, max width 600px)
```

---

### 13.10 Animations y Transitions

**Recomendadas:**
- Bottom sheet slide up: 300ms ease-out
- Currency swap: 200ms rotation
- Input focus: 150ms ease
- Button press: 100ms scale (0.98)
- Loading states: Circular progress indicator

---

### 13.11 Estados Visuales

#### Loading State:
- Mostrar CircularProgressIndicator sobre los resultados
- Deshabilitar botón "Cambiar"
- Opacity 0.6 en results section

#### Error State:
- Mostrar mensaje de error en rojo debajo del input
- Icon de error (⚠️) junto al mensaje
- Mantener último resultado válido si existe

#### Empty State:
- Valores en "---" cuando no hay cálculo
- Botón "Cambiar" deshabilitado

#### Success State:
- Resultados visibles con valores calculados
- Botón "Cambiar" habilitado y destacado

---

**Documento preparado para**: Prueba técnica Flutter Developer  
**Fecha**: Septiembre 30, 2025  
**Versión**: 1.0