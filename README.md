## Descripción del proyecto

Recordatorio de Medicamentos es una aplicación desarrollada con Flutter y Dart. La aplicación tiene como finalidad ayudar a las personas a llevar un mejor control de los medicamentos que deben tomar, permitiendo registrar los medicamentos, establecer horarios y fechas, y llevar un seguimiento de los medicamentos que ya fueron tomados.

La aplicación también cuenta con algunas opciones de accesibilidad, como el cambio del tamaño de la letra y los modos claro y oscuro, para facilitar su utilización, especialmente en personas mayores.

## Objetivo

El objetivo principal de este proyecto es desarrollar una aplicación que permita organizar los medicamentos y recordar al usuario los horarios establecidos para su toma.

También se busca que el usuario pueda llevar un registro de los medicamentos tomados y consultar estadísticas para conocer el cumplimiento de sus recordatorios.

## Funcionalidades

La aplicación cuenta con las siguientes funciones:

- Registrar nuevos medicamentos.
- Colocar el nombre del medicamento.
- Establecer la fecha del medicamento.
- Establecer la hora en la que debe tomarse.
- Editar los medicamentos registrados.
- Eliminar medicamentos.
- Marcar un medicamento como tomado.
- Mostrar la cantidad de medicamentos tomados.
- Buscar medicamentos mediante un buscador.
- Mostrar estadísticas sobre los medicamentos registrados y tomados.
- Recibir notificaciones para recordar la hora de tomar un medicamento.
- Aumentar el tamaño de la letra.
- Disminuir el tamaño de la letra.
- Activar el modo claro.
- Activar el modo oscuro.
- Guardar los datos de los medicamentos de forma local.

## Tecnologías utilizadas

Para el desarrollo de la aplicación se utilizaron las siguientes tecnologías:

- Flutter
- Dart
- Hive
- Hive Flutter
- Flutter Local Notifications
- Timezone
- Path Provider
- GitHub

## Dependencias utilizadas

El proyecto utiliza diferentes paquetes de Flutter que permiten agregar las funciones de almacenamiento y notificaciones.

### Hive

Se utiliza para guardar la información de los medicamentos de forma local en el dispositivo.

### Hive Flutter

Permite utilizar Hive dentro de la aplicación Flutter y facilita la inicialización y utilización de la base de datos local.

### Flutter Local Notifications

Se utiliza para crear y programar las notificaciones que sirven como recordatorio para la toma de los medicamentos.

### Timezone

Se utiliza para trabajar correctamente con las fechas y horarios relacionados con las notificaciones.

### Path Provider

Permite obtener las rutas de almacenamiento utilizadas por la aplicación.

## Requisitos para ejecutar el proyecto

Para ejecutar el proyecto se necesita tener instalado un entorno de desarrollo para Flutter.

Los principales requisitos son:

- Un computador con Windows, macOS o Linux.
- Flutter SDK.
- Dart SDK, que viene incluido con Flutter.
- Android Studio o Visual Studio Code.
- Android SDK para ejecutar la aplicación en Android.
- Un dispositivo Android físico o un emulador Android para probar la aplicación.

También se necesita Git si se desea descargar el proyecto directamente mediante comandos desde GitHub.

## Instalación de Flutter

Primero se debe instalar Flutter SDK desde la página oficial de Flutter.

Después de instalar Flutter se debe agregar Flutter a las variables de entorno del sistema para poder utilizar sus comandos desde la terminal.

Para comprobar que Flutter está correctamente instalado se debe abrir una terminal y ejecutar:

```bash
flutter --version
Si Flutter está instalado correctamente, se mostrará la versión instalada.
También se puede comprobar la configuración completa del entorno mediante:
flutter doctor
Este comando permite verificar si existen problemas con Flutter, Android Studio, Android SDK u otras herramientas necesarias.
Instalación de Android Studio
Android Studio se utiliza para disponer de las herramientas necesarias para ejecutar la aplicación en Android.
Después de instalar Android Studio se debe verificar que estén instalados los componentes necesarios del Android SDK.
También se puede utilizar un dispositivo Android físico conectado mediante USB o crear un emulador desde Android Studio.
Para utilizar un teléfono físico se debe activar la opción de desarrollador y la depuración USB del dispositivo.
Instalación de Visual Studio Code
Visual Studio Code puede utilizarse como editor para abrir y modificar el proyecto.
Se recomienda instalar las extensiones de Flutter y Dart para facilitar el desarrollo y ejecución de la aplicación.
Descargar el proyecto
El proyecto se encuentra almacenado en GitHub.
Para descargarlo mediante Git se debe abrir una terminal y utilizar el comando:
git clone https://github.com/luz-r74/Recordatorio_de_Medicamentos.git
Después de descargar el proyecto se debe ingresar a la carpeta que contiene la aplicación:
cd Recordatorio_de_Medicamentos
Dentro del repositorio existe la carpeta donde se encuentra el proyecto Flutter. Si es necesario, se debe ingresar a ella:
cd recordatorio_medicamentos
Otra opción es descargar el repositorio desde GitHub utilizando la opción de descargar el proyecto como archivo ZIP y posteriormente extraerlo en el computador.
Abrir el proyecto
Después de descargar el proyecto se puede abrir la carpeta del proyecto recordatorio_medicamentos utilizando Visual Studio Code o Android Studio.
Se debe abrir la carpeta donde se encuentra el archivo:
pubspec.yaml
Este archivo contiene la información principal del proyecto y las dependencias que utiliza.
Instalar las dependencias
Una vez abierto el proyecto, se debe abrir una terminal dentro de la carpeta del proyecto y ejecutar:
flutter pub get
Este comando descarga e instala automáticamente las dependencias utilizadas por la aplicación.
No es necesario instalar Hive, Flutter Local Notifications, Timezone o Path Provider de manera individual, ya que están declarados en el archivo pubspec.yaml y se descargan mediante flutter pub get.
Comprobar el proyecto
Después de instalar las dependencias se recomienda ejecutar:
flutter doctor
También se puede comprobar que Flutter reconoce correctamente el dispositivo o emulador mediante:
flutter devices
Este comando muestra los dispositivos disponibles para ejecutar la aplicación.
Ejecutar la aplicación
Para ejecutar la aplicación se debe tener conectado un dispositivo Android o tener iniciado un emulador.
Dentro de la carpeta del proyecto se ejecuta:
flutter run
Flutter mostrará los dispositivos disponibles y ejecutará la aplicación en el dispositivo seleccionado.
También se puede ejecutar el proyecto directamente desde Visual Studio Code o Android Studio seleccionando un dispositivo y utilizando la opción de ejecutar.
Ejecución en Android
La aplicación está preparada principalmente para ser utilizada en dispositivos Android.
Para probar todas las funciones, especialmente las notificaciones, se recomienda ejecutar la aplicación en un teléfono Android o en un emulador Android.
Después de ejecutar la aplicación se pueden registrar medicamentos, establecer fechas y horarios y comprobar el funcionamiento de los recordatorios.
Notificaciones
La aplicación cuenta con un sistema de notificaciones utilizando el paquete Flutter Local Notifications.
Las notificaciones permiten recordar al usuario cuándo debe tomar un medicamento según la fecha y hora establecidas.
La función de notificaciones está preparada para Android.
Al ejecutar la aplicación como una aplicación web, las notificaciones no funcionan de la misma manera que en Android. Por este motivo, para comprobar correctamente esta función se recomienda ejecutar el proyecto en un dispositivo Android o en un emulador Android.
Registro de medicamentos
El usuario puede agregar un medicamento indicando los datos necesarios, incluyendo la fecha y hora en la que debe realizarse la toma.
Los medicamentos registrados se muestran en la aplicación para que el usuario pueda consultar los recordatorios pendientes.
Editar y eliminar medicamentos
Los medicamentos registrados pueden ser modificados cuando sea necesario.
La opción de editar permite cambiar los datos registrados anteriormente.
También existe la opción de eliminar un medicamento cuando ya no sea necesario tenerlo registrado.
Marcar medicamento como tomado
Cuando el usuario realiza la toma de un medicamento puede marcarlo como tomado.
Esto permite llevar un control de los medicamentos que ya fueron realizados y diferenciarlos de los que todavía están pendientes.
Buscador
La aplicación cuenta con un buscador que permite encontrar medicamentos registrados de una manera más rápida.
Esto resulta útil cuando existen varios medicamentos almacenados en la aplicación.
Estadísticas
La aplicación cuenta con una sección de estadísticas.
En esta sección se puede consultar información relacionada con los medicamentos registrados y la cantidad de medicamentos que han sido marcados como tomados.
Las estadísticas permiten tener una idea del seguimiento que se está realizando de los medicamentos.
Accesibilidad
La aplicación incluye opciones para facilitar su utilización.
Una de estas opciones permite aumentar o disminuir el tamaño de la letra.
Esta función fue incluida pensando principalmente en personas que pueden tener dificultad para leer textos pequeños.
También se cuenta con un modo claro y un modo oscuro para que el usuario pueda elegir la apariencia que le resulte más cómoda.
Almacenamiento de información
La aplicación utiliza Hive para almacenar los datos de los medicamentos de forma local.
Esto permite conservar la información dentro del dispositivo y utilizar los datos registrados posteriormente sin tener que ingresar nuevamente toda la información.
Estructura básica del proyecto
El proyecto está desarrollado utilizando la estructura de una aplicación Flutter.
Entre las principales carpetas y archivos se encuentran:
recordatorio_medicamentos/
│
├── android/
├── ios/
├── lib/
├── web/
├── test/
├── pubspec.yaml
└── README.md
La carpeta lib contiene principalmente el código de la aplicación.
La carpeta android contiene la configuración necesaria para ejecutar el proyecto en dispositivos Android.
La carpeta web contiene los archivos necesarios para ejecutar el proyecto como aplicación web.
El archivo pubspec.yaml contiene la información del proyecto y las dependencias utilizadas.
El archivo README.md contiene la información y las instrucciones para utilizar el proyecto.
Comandos principales
Los principales comandos utilizados para trabajar con el proyecto son:
Comprobar la versión de Flutter:
flutter --version
Comprobar la configuración de Flutter:
flutter doctor
Ver los dispositivos disponibles:
flutter devices
Instalar las dependencias:
flutter pub get
Ejecutar la aplicación:
flutter run
Uso básico de la aplicación
Para utilizar la aplicación se deben seguir los siguientes pasos:
Abrir la aplicación.
Registrar un nuevo medicamento.
Colocar el nombre del medicamento.
Seleccionar la fecha correspondiente.
Establecer la hora de la toma.
Guardar el medicamento.
Consultar los medicamentos registrados desde la pantalla principal.
Marcar como tomado el medicamento después de realizar la toma.
Utilizar el buscador cuando sea necesario encontrar un medicamento.
Consultar las estadísticas para revisar el seguimiento.
Modificar el tamaño de letra desde las opciones de accesibilidad si es necesario.
Activar el modo claro u oscuro según la preferencia del usuario.
Consideraciones
La aplicación fue desarrollada principalmente para dispositivos Android.
La función de notificaciones está destinada a funcionar correctamente en Android. La ejecución mediante navegador web puede tener limitaciones en esta función.
Para probar todas las funciones del proyecto se recomienda utilizar Android Studio con un emulador Android o un dispositivo Android físico.
Capturas de pantalla
En esta sección se pueden agregar capturas de las principales pantallas de la aplicación.
Se recomienda incluir capturas de:
Pantalla principal.
Registro de medicamentos.
Edición de medicamentos.
Medicamentos marcados como tomados.
Buscador.
Estadísticas.
Configuración del tamaño de letra.
Modo claro.
Modo oscuro.
Notificaciones.
Autora
Proyecto realizado como parte de la formación académica en Sistemas Informáticos.
Autora: Luz Rios


