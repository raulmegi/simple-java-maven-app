@echo off
setlocal enabledelayedexpansion

REM Ruta completa a Maven
set MAVEN=C:\apache-maven-3.9.10\bin\mvn

echo Instalando artefacto en el repositorio local de Maven...
call "%MAVEN%" install

REM Extraer name y version desde pom.xml
set NAME=
set VERSION=

for /f "tokens=1,* delims=>" %%A in ('findstr "<name>" pom.xml') do (
    for /f "tokens=1 delims=<" %%C in ("%%B") do set NAME=%%C
)

for /f "tokens=1,* delims=>" %%A in ('findstr "<version>" pom.xml') do (
    for /f "tokens=1 delims=<" %%C in ("%%B") do set VERSION=%%C
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
