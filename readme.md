# Análisis de Cuidado Infantil en Estados Unidos (2007-2018)

Este proyecto realiza un análisis detallado del cuidado infantil en Estados Unidos entre los años 2007 y 2018. El análisis se lleva a cabo en Quadro, y se basa en datos extraídos de un archivo CSV. Estos datos son posteriormente almacenados en una instancia de Microsoft SQL Server para su consulta y procesamiento.

## Objetivo

El propósito principal de este proyecto es explorar el dataset junto con las tendencias y patrones del cuidado infantil en EE.UU. durante el periodo mencionado, mediante la utilización de herramientas de análisis de datos y visualización.

## Instalación

Sigue los pasos a continuación para configurar y ejecutar el proyecto:

### 1. Clonar el Repositorio

Para obtener una copia local del proyecto, clona este repositorio en tu máquina local.

### 2. Crear una Instancia de SQL Server

Se recomienda utilizar Docker para instalar y ejecutar una instancia de SQL Server. Aquí tienes los pasos básicos para hacerlo:

``` bash
# Descargar y ejecutar una imagen de SQL Server en Docker
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=PASSWORD" -p 1433:1433 --name sqlserver -d mcr.microsoft.com/mssql/server:2019-latest

# Verifica que el contenedor esté ejecutándose
docker ps -a

# (Nota) Es necesario instalar los paquetes unixODBC y FreeTDS para algunas configuraciones de SO
# La función odbcListDrivers() mostrará los drivers disponibles.
# Para ejecutar SQL Server, usa el siguiente comando:
docker start sqlserver
```

### 3. Procesamiento de Datos

Ejecuta el script get_and_save_data.R para procesar y almacenar los datos en la base de datos SQL Server.

### 4. Analisis en Quadro

Abre el archivo index.qmd en Quadro y ejecútalo para visualizar y analizar los resultados.

### Licencia

Este proyecto es de código abierto y está disponible bajo la Licencia MIT.
