@echo off
REM Inicia un servidor local para Rannota-tor (Windows).
REM Doble clic en este archivo y deja la ventana abierta. Luego usa:
REM   http://localhost:5500/index.html?nt=open
REM   http://localhost:5500/index.html?nt=capture
cd /d "%~dp0"
echo Rannota-tor disponible en: http://localhost:5500/index.html
echo Notetaker:  http://localhost:5500/index.html?nt=open
echo Captura:    http://localhost:5500/index.html?nt=capture
echo (Cierra esta ventana para detener)
python -m http.server 5500
pause
