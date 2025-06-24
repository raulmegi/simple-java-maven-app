@echo off
setlocal enabledelayedexpansion

REM Ruta absoluta a Maven
set MAVEN=C:\apache-maven-3.9.10\bin\mvn

echo Instalando artefacto en el repositorio local de Maven...
call "%MAVEN%" install

REM Inicializar variables
set NAME=
set VERSION=

REM Extraer <name> desde pom.xml
for /f "tokens=1,* delims=>" %%A in ('findstr "<name>" pom.xml') do (
    if not defined NAME (
        for /f "tokens=1 delims=<" %%C in ("%%B") do set NAME=%%C
    )
)

REM Extraer la PRIMERA <version> (la del proyecto, no la del plugin)
set FOUND_VERSION_LINE=0
for /f "tokens=1,* delims=>" %%A in ('findstr "<version>" pom.xml') do (
    if !FOUND_VERSION_LINE! == 0 (
        for /f "tokens=1 delims=<" %%C in ("%%B") do (
            set VERSION=%%C
            set FOUND_VERSION_LINE=1
        )
    )
)

echo Nombre del proyecto: !NAME!
echo Versión del proyecto: !VERSION!

REM Ejecutar el JAR generado
set JAR=target\!NAME!-!VERSION!.jar
echo Ejecutando JAR: !JAR!

IF EXIST !JAR! (
    java -jar !JAR!
) ELSE (
    echo ❌ El archivo !JAR! no existe.
    exit /b 1
)