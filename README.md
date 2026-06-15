# Rannota-tor

Herramienta web (single-page, sin instalación) para generar minutas, mapas mentales y
seguimiento de pendientes a partir de transcripciones de reuniones y llamadas, usando
la API de Anthropic (Claude).

## 🎙️ Meeting Notetaker (Beta · 100% navegador)

Adaptación del SPEC "AI Meeting Notetaker – Desktop MVP" a una versión que corre
completamente en el navegador, sin instalar nada en el equipo:

| Módulo del SPEC original | Adaptación en el navegador |
|---|---|
| `calendar-sync` (OAuth Google/Outlook) | Google Calendar API vía OAuth (Google Identity Services), detecta eventos de hoy con enlaces de Zoom/Meet/Teams/Webex |
| `audio-watcher` (CoreAudio/WASAPI) | No requiere detección de procesos del sistema: el navegador no tiene ese permiso |
| `orchestrator` | Compara la hora actual contra los eventos del calendario y muestra un banner "Reunión detectada – ¿Iniciar notas?" |
| `capture-engine` (loopback de audio) | `getDisplayMedia({audio:true})` — el usuario comparte la pestaña/ventana de su reunión con audio, grabado en chunks de 5s |
| `transcription` (Whisper.cpp / API) | API de OpenAI Whisper (chunks) o Web Speech API del navegador |
| `summarizer` (LLM → JSON Schema) | Claude API (misma key del header) u Ollama local, con salida JSON fija: `resumen`, `transcripcion`, `action_items`, `decisiones`, `participantes` |
| `notion-sync` | Notion API (crea página con bloques Transcripción/Resumen/Action Items/Decisiones/Participantes), con respaldo "Copiar Markdown" si el navegador bloquea la llamada por CORS |

Todo se abre desde el botón **🎙️ Notetaker** del header. La configuración
(Google Client ID, OpenAI key, Notion token/DB) se guarda solo en `localStorage`
del navegador, igual que la API Key de Anthropic.

Los "Action Items" detectados se agregan automáticamente al panel de
**🗂 Pendientes** existente.

### Integración con control surfaces (Logitech / Loupedeck Creative Console, Stream Deck, etc.)

No hay SDK nativo, pero puedes mapear botones/dial a:

- **Acción "Abrir sitio web" (recomendado)** → no depende de atajos de teclado, así
  que no choca con combinaciones del sistema (p. ej. split view). Primero ejecuta
  `iniciar-servidor.command` (macOS/Linux) o `iniciar-servidor.bat` (Windows) — deja
  la ventana abierta — y luego usa estas URLs en los botones:
  - **Notetaker**: `http://localhost:5500/index.html?nt=open`
  - **Iniciar captura**: `http://localhost:5500/index.html?nt=capture`
- **Acción de teclado** → atajos globales de la página (pueden chocar con atajos del
  sistema operativo o del navegador en algunos equipos):
  - `Alt+Shift+N` — abrir/cerrar el Notetaker
  - `Alt+Shift+C` — iniciar/detener captura (abre el panel automáticamente si está cerrado)
  - `Alt+Shift+P` — abrir/cerrar Pendientes
