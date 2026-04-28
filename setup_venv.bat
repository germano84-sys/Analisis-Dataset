@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ====================================
echo Búsqueda de Python instalado...
echo ====================================

REM Buscar Python en rutas comunes
set "python_found=0"

REM Buscar en Program Files
for /f "tokens=*" %%A in ('where python 2^>nul') do (
    if not "%%A"=="" (
        set "python_path=%%A"
        set "python_found=1"
        goto found
    )
)

REM Buscar en Program Files manualmente
if exist "C:\Program Files\Python*\python.exe" (
    for /d %%D in ("C:\Program Files\Python*") do (
        if exist "%%D\python.exe" (
            set "python_path=%%D\python.exe"
            set "python_found=1"
            goto found
        )
    )
)

REM Buscar en AppData
if exist "C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python*\python.exe" (
    for /d %%D in ("C:\Users\%USERNAME%\AppData\Local\Programs\Python\Python*") do (
        if exist "%%D\python.exe" (
            set "python_path=%%D\python.exe"
            set "python_found=1"
            goto found
        )
    )
)

:found
if %python_found%==0 (
    echo.
    echo ERROR: No se encontró Python instalado.
    echo.
    echo Soluciones:
    echo 1. Descarga Python desde: https://www.python.org/downloads/
    echo 2. Durante la instalación, marca: "Add Python to PATH"
    echo 3. Reinicia esta ventana de comando después de instalar
    echo.
    pause
    exit /b 1
)

echo Python encontrado en: !python_path!
echo.

REM Crear entorno virtual
echo Creando entorno virtual...
"!python_path!" -m venv venv

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✓ Entorno virtual creado exitosamente
    echo.
    echo Instalando paquetes requeridos...
    call venv\Scripts\activate.bat
    pip install --upgrade pip
    pip install -r requirements.txt
    echo.
    echo ✓ Paquetes instalados
    echo.
    echo Para activar el entorno en el futuro, usa:
    echo   venv\Scripts\activate.bat
    echo.
) else (
    echo ERROR: No se pudo crear el entorno virtual
    pause
    exit /b 1
)

pause
