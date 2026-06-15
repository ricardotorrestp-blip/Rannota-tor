#!/bin/bash
# Inicia un servidor local para Rannota-tor (macOS/Linux).
# Doble clic en este archivo (o `bash iniciar-servidor.command`) y deja la
# ventana abierta. Luego abre/usa:
#   http://localhost:5500/index.html?nt=open
#   http://localhost:5500/index.html?nt=capture
cd "$(dirname "$0")"
echo "Rannota-tor disponible en: http://localhost:5500/index.html"
echo "Notetaker:  http://localhost:5500/index.html?nt=open"
echo "Captura:    http://localhost:5500/index.html?nt=capture"
echo "(Ctrl+C para detener)"
python3 -m http.server 5500
