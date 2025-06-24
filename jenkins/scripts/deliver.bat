echo off
set MAVEN=C:\apache-maven-3.9.10\bin\mvn

echo Instalando artefacto en el repositorio local de Maven...
call "%MAVEN%" install

REM Extraer nombre y versión del POM
FOR /F "tokens=2 delims=><" %%A IN ('findstr "<name>" pom.xml') DO set NAME=%%A
FOR /F "tokens=2 delims=><" %%A IN ('findstr "<version>" pom.xml') DO set VERSION=%%A

echo Nombre del proyecto: %NAME%
echo Versión del proyecto: %VERSION%

REM Ejecutar el JAR generado
set JAR=target\%NAME%-%VERSION%.jar
echo Ejecutando JAR: %JAR%

IF EXIST %JAR% (
    java -jar %JAR%
) ELSE (
    echo ❌ El archivo %JAR% no existe.
    exit /b 1
)