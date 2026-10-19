# Recordatorio de Medicamentos - Docker

## Descripción
Aplicación web del proyecto Recordatorio de Medicamentos, ejecutada mediante Docker.

## Requisitos
- Docker Desktop instalado y funcionando.
- Acceso a Internet para descargar las imágenes necesarias.

## Cómo ejecutar el proyecto

1. Descargar el proyecto desde GitHub.
2. Abrir PowerShell dentro de la carpeta donde se encuentra el archivo Dockerfile.
3. Construir la imagen:

   docker build -t recordatorio-medicamentos .

4. Crear y ejecutar el contenedor:

   docker run -d --name recordatorio-web -p 8080:80 recordatorio-medicamentos

5. Abrir el navegador en:

   http://localhost:8080

## Comprobar que funciona

Ejecutar:

   docker ps

El contenedor recordatorio-web debe aparecer en ejecución.

## Detener la aplicación

   docker stop recordatorio-web

## Nota
Si el contenedor recordatorio-web ya existe, debe detenerse y eliminarse antes de volver a crearlo con el mismo nombre.

Para eliminarlo después de detenerlo:

   docker rm recordatorio-web