# OmarchyTV personalizado

Una personalización de [OmarchyTV](https://github.com/piermark/omarchytv) para Android TV y Google TV, con una interfaz inspirada en terminales Linux: fondos a pantalla completa, paneles discretos y un dock de aplicaciones con colores y transparencia.

El proyecto se basa en OmarchyTV v2.15.1, commit `0365e6b704ebb0f99c03b5c460fd36d5e84fdb9f`. Es una modificación independiente del proyecto de Marco Porro y sus colaboradores; la licencia original se conserva en `LICENSE`.

## Características

- Inicio con rótulo ASCII, reloj, clima y accesos a aplicaciones.
- Paneles superpuestos de ajustes rápidos y entradas. Cada botón abre o cierra su panel; el otro permite cambiar directamente entre ambos.
- Remapeo de botones del mando y respuesta más rápida al pulsar Home desde el inicio.
- Rotación opcional de tres fondos, aproximadamente cada hora mientras el inicio está visible.
- Salvapantallas de vídeo y compatibilidad con una animación propia en el panel de ajustes.

El rótulo incluido muestra `TEILOR`; para cambiarlo, edita `logoText()` en `launcher/app/src/main/java/com/omarchytv/home/HomeV29.java` después de aplicar el parche. El texto se generó con [figlet.js](https://github.com/patorjk/figlet.js), fuente ANSI Shadow (autor no indicado); la licencia de figlet.js está en `FIGLET-LICENSE.txt`.

## Preparación en Windows

Se necesita Git, JDK 17 y Android SDK con la plataforma 34 y build-tools 34.0.0. Los archivos multimedia no se incluyen en el repositorio. Prepara un GIF, un vídeo MP4 y una carpeta con tres imágenes JPG con los nombres `01-rei.jpg`, `02-roxy.jpg` y `03-zerotwo.jpg`; pueden ser imágenes propias con esos nombres.

```powershell
.\preparar.ps1 -Destino C:\tv\omarchytv-personalizado -Gif C:\imagenes\animacion.gif -Fondos C:\imagenes\fondos -Video C:\imagenes\salvapantallas.mp4
```

El script clona OmarchyTV en el commit fijado, comprueba y aplica `personalizacion.patch` y copia los archivos multimedia. No instala nada en el televisor. Para compilar, entra en la carpeta `launcher` creada y ejecuta:

```powershell
.\gradlew.bat assembleDebug
```

`config.example.json` ofrece una configuración inicial; adapta la lista de aplicaciones y los demás ajustes al dispositivo. Las rutas y nombres internos de algunos recursos conservan identificadores de la configuración original.

También se puede colocar una animación WebP propia en `launcher/app/src/main/assets/eris-panel.webp`; el panel la usa en lugar del GIF si está presente. Reducir sus dimensiones puede ayudar a ahorrar memoria en dispositivos modestos.

## Instalación y compatibilidad

La implementación se ha probado en un Hyundai HYLED4326QG con Android/Google TV 14. Los códigos físicos del mando y las actividades de imagen y sonido corresponden a ese dispositivo Realtek; en otros televisores pueden ser diferentes. El selector usa `TvInputManager` y el reproductor de entradas del sistema.

Antes de cambiar el launcher predeterminado, guarda los ajustes y verifica que Home, entradas, ajustes y el acceso ADB funcionen en el dispositivo. Para actualizar una instalación existente, el APK debe estar firmado con la misma clave. Conserva la clave fuera del repositorio y evita desinstalar la aplicación sin respaldar sus datos.

El remapeo depende del servicio de accesibilidad «Botón Inicio OmarchyTV». Tras instalar o detener la aplicación, comprueba que el servicio siga activo y prueba las teclas físicas. La opción de rotación propia se controla desde el menú de fondos del tema `marlo-anime`; sus preferencias del temporizador se guardan en los datos privados de la aplicación, no en `omarchytv.json`.

La rotación de fondos y temas incluida originalmente en OmarchyTV es independiente. Para limitar la rotación a los tres fondos propios, mantén desactivadas las opciones originales `random_theme` y `random_wallpaper`. El cambio se comprueba al estar en el inicio, sin despertar el televisor.
