# Omarchy personalizado para Teilor

Personalización de [OmarchyTV](https://github.com/piermark/omarchytv) v2.15.1, basada en el commit `0365e6b704ebb0f99c03b5c460fd36d5e84fdb9f`. OmarchyTV es obra de Marco Porro y sus colaboradores; este repositorio contiene cambios personales, no es el proyecto oficial. Se conserva su licencia MIT en `LICENSE`.

El rótulo TEILOR usa texto generado con [figlet.js](https://github.com/patorjk/figlet.js), fuente ANSI Shadow (autor no indicado); la licencia de figlet.js está en `FIGLET-LICENSE.txt`.

Incluye dock con nombres, colores y transparencia, logotipo TEILOR con letras de terminal, paneles propios de ajustes y entradas, remapeo del mando, salvapantallas de vídeo y rotación de tres fondos personales aproximadamente cada hora mientras el inicio está visible. Al pulsar Home estando ya en inicio se evita volver a cargarlo. Cada botón abre o cierra su panel; el otro cambia directamente de panel, con una transición breve. Se puede activar o desactivar la rotación en el menú de fondos del tema personalizado.

**Los fondos, el GIF y el vídeo no se distribuyen aquí.** Aporta tus propios archivos y comprueba que tienes derecho a utilizarlos. La clave de firma, los APK y los ajustes concretos de cada televisor también permanecen fuera del repositorio. El respaldo completo de Teilor está guardado por separado en su PC.

## Preparación en Windows

Requisitos: Git, JDK 17 y Android SDK con plataforma 34 y build-tools 34.0.0. Prepara un GIF llamado `eris-panel.gif`, un MP4 llamado `teilor_saver.mp4` y una carpeta con tres JPG: `01-rei.jpg`, `02-roxy.jpg`, `03-zerotwo.jpg` (pueden ser tus imágenes, con esos nombres). Después ejecuta PowerShell:

```powershell
.\preparar.ps1 -Destino C:\tv\omarchytv-teilor -Gif C:\imagenes\eris-panel.gif -Fondos C:\imagenes\fondos -Video C:\imagenes\teilor_saver.mp4
```

El script clona el proyecto original en el commit fijado, aplica `personalizacion.patch` y copia los archivos propios. No modifica el televisor ni el repositorio de origen. Para compilar, entra en la carpeta `launcher` creada y ejecuta `./gradlew.bat assembleDebug`. `config.example.json` sirve como punto de partida para la configuración, pero hay que adaptarlo a las aplicaciones instaladas.

Opcionalmente, se puede colocar una animación WebP propia en `launcher/app/src/main/assets/eris-panel.webp`; el panel la preferirá sobre el GIF. La versión usada en la Hyundai es un WebP de 430 × 430 creado a partir del GIF aportado por el usuario, para evitar una nueva reducción a la paleta limitada de GIF. Ninguno de esos archivos personales está incluido aquí.

## Instalación y compatibilidad

Esta versión se probó en un Hyundai HYLED4326QG con Android/Google TV 14. Los códigos físicos del mando y las actividades de imagen y sonido son específicos del dispositivo Realtek; en otras TV pueden no existir o tener nombres distintos. El selector usa `TvInputManager` y el reproductor de entradas del sistema. No deshabilites el launcher original hasta verificar Home, ajustes, entradas y recuperación en el dispositivo de destino. Guarda antes una copia de ajustes y comprueba que tienes acceso ADB funcional.

Para actualizar una instalación existente, el APK debe firmarse con la misma clave que la instalación; guarda esa clave en privado. Un APK debug con otra firma no actualiza la instalación existente. No desinstales a ciegas, ya que se perderían datos. Las preferencias del temporizador están en `teilor_wallpaper` dentro de los datos privados de la aplicación; no forman parte de `omarchytv.json`.

El remapeo depende del servicio de accesibilidad «Botón Inicio OmarchyTV». Después de actualizar o detener forzosamente la aplicación, comprueba que siga habilitado y que los botones físicos abran los paneles; si no, vuelve a habilitarlo desde Accesibilidad. No basta con abrir los paneles mediante una orden ADB para probar el mando. El GIF personal se puede reducir antes de compilar para ahorrar almacenamiento y memoria; el panel limita además la resolución de decodificación.

La opción de configuración original que rota temas y fondos es independiente y se deja desactivada para usar únicamente los tres fondos personales. No se fuerza una transición mientras se usa otra aplicación o la TV duerme: al volver al inicio se revisa si ya pasó una hora.
