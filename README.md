# App de Control de Accesos (SwiftUI)

Aplicación iOS construida en **SwiftUI** para autenticar usuarios (login) y visualizar un **panel de registros de entrada/salida** del personal. El proyecto incluye una **hoja flotante** para registrar nuevas entradas y una navegación basada en **NavigationStack**.

> Marca de ejemplo en la UI: **SERVICIOS INTEGRALES DE ALIMENTOS VITA** (puedes cambiarla por la de tu organización).

---

## 📦 Requisitos

* **Xcode** 15 o superior
* **iOS** 17 o superior (target configurable)
* **Swift** 5.9+

> Ajusta el `Deployment Target` si necesitas compatibilidad con versiones anteriores.

---

## 🧭 Arquitectura y Flujo

* **ContentView**: raíz con `NavigationStack`.

  * Presenta **LoginVista**.
  * Al validar credenciales, navega a **PanelPrincipalVista** mediante `navigationDestination` y un `@State` booleano (`irPanel`).
* **LoginVista**:

  * Campos controlados: **usuario**, **contraseña**.
  * Botones: *Iniciar sesión*, *Olvidé mi contraseña* (alerta), *Registrar nueva entrada* (abre hoja flotante).
  * **RegistroEntradaFlotante**: hoja parcial con instrucciones e imagen, incluye botón para **registro manual** (placeholder para futura lógica).
  * **Validación de credenciales** (demo): `Admin / 1234`.
* **PanelPrincipalVista (Dashboard)**:

  * Lista mock de **registros de empleados** con estado **En planta / Finalizado**.
  * **Cerrar sesión** con `@Environment(\.dismiss)` dentro de `safeAreaInset` (barra inferior fija).
* **Componentes reutilizables**:

  * **CampoTexto** y **CampoSeguro**: encapsulan estilos y validación visual básica.

---

## 🖼️ Recursos/Assets

Asegúrate de agregar al **Asset Catalog** las imágenes referenciadas:

* `logo`
* `logo_vector`

> Si no existen, reemplaza o elimina las referencias para evitar crashes en runtime.

---

## 🚀 Puesta en Marcha

1. **Clona o copia** el proyecto en Xcode.
2. Añade los **assets** requeridos (`logo`, `logo_vector`).
3. Compila y ejecuta en **simulador** o **dispositivo**.
4. Accede con credenciales de demo: **Usuario:** `Admin` — **Contraseña:** `1234`.

---

## 🔐 Notas de Seguridad (importante)

La validación incluida es **solo de demostración**. Para un entorno real:

* Reemplaza `validarCredenciales()` por autenticación segura (API, OAuth2, OpenID Connect o directorio corporativo).
* Usa **Keychain** para guardar tokens/sesiones, **no** valores en texto plano.
* Implementa **Rate Limiting** y **Lockout** tras intentos fallidos.
* Asegura el transporte (**HTTPS/TLS**), certificados válidos y pinning si aplica.
* Deshabilita logs sensibles en producción.

---

## 🧩 Puntos de Extensión

* **API de Registro**: conecta el botón *Registrar entrada manualmente* a tu endpoint (`POST /entradas`).
* **Persistencia**: reemplaza la lista mock por **Core Data**, **SwiftData** o datos de backend.
* **Roles y Permisos**: Admin vs. Operación (oculta/expone controles según perfil).
* **Búsqueda/Filtrado**: por *número de empleado*, *estado* o *rango de horas*.
* **Theming**: extrae colores a un **Design System** (por ejemplo, `Color.orange` → `Brand.primary`).
* **Internacionalización**: `Localizable.strings` para soportar ES/EN.

---

## 🧱 Estructura (referencia)

```
Sources/
├─ ContentView.swift          // NavigationStack + destino
├─ LoginVista.swift           // Login + hoja flotante
├─ PanelPrincipalVista.swift  // Dashboard + cierre de sesión
├─ Componentes/
│  ├─ CampoTexto.swift
│  └─ CampoSeguro.swift
└─ Assets.xcassets/
   ├─ logo.imageset
   └─ logo_vector.imageset
```

---

## 🧪 Pruebas Sugeridas

* **UI**: estados de error en login, presentación/dismiss de la hoja, accesibilidad (VoiceOver, tamaños dinámicos).
* **Navegación**: flujo `Login → Dashboard → Cerrar sesión → Login`.
* **Formato de hora**: formato `HH:mm` y zonas horarias.

---

## ♿ Accesibilidad

* Usa `Text` semánticos y `font(.headline/body)` adecuados.
* Contraste suficiente en botones (ej. sobre `Color.orange`).
* Etiquetas accesibles para campos y botones (VoiceOver).

---

## 🛠️ Configuración Rápida (snippets)

**Cambiar credenciales de demo**

```swift
private func validarCredenciales() {
    // TODO: Reemplazar por autenticación real
    if usuario.lowercased() == "admin" && contrasena == "1234" {
        irPanel = true
    } else {
        mostrarError = true
    }
}
```

**Actualizar branding**

```swift
Text("SERVICIOS INTEGRALES DE ALIMENTOS VITA")
    .font(.system(size: 18, weight: .bold))
// Reemplaza por el nombre de tu empresa
```

---

## 🗺️ Roadmap (propuesto)

* [ ] Integración con **API** (login + registro de entradas).
* [ ] **Persistencia** local (SwiftData) para modo offline.
* [ ] **Filtros** y **búsquedas** en el Dashboard.
* [ ] **Exportación** de reportes (CSV/PDF) y compartido.
* [ ] **Roles** (Admin/Usuario) y auditoría básica.

---

## 🤝 Contribuir

1. Crea una rama: `feat/nueva-funcionalidad`.
2. Abre un PR con descripción clara y capturas.
3. Asegura compatibilidad con iOS target y lint básico.

---

## 📄 Licencia

Este proyecto se distribuye bajo la **licencia MIT** (o
