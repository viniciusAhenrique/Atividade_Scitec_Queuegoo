#!/usr/bin/env bash
set -euo pipefail
set +m
if [[ "${CODESPACES:-}" != "true" ]]; then
  echo "Este script é exclusivo do GitHub Codespaces. Use os comandos locais do README." >&2
  exit 1
fi
if [[ $# -ne 1 ]] || [[ "$1" != "starter" && "$1" != "starter2" && "$1" != "final" ]]; then
  echo "Uso: bash scripts/start-codespace.sh {starter|starter2|final}" >&2
  exit 1
fi
: "${CODESPACE_NAME:?Variável CODESPACE_NAME ausente. Abra um terminal no Codespaces.}"
: "${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN:?Domínio de encaminhamento do Codespaces ausente.}"
PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
activity="$1"
project="$PROJECT_ROOT/$activity"
python_bin="$project/backend/.venv/bin/python"
[[ -f "$project/backend/main.py" && -f "$project/frontend/package.json" ]] || {
  echo "Pasta $activity indisponível. Para final, disponibilize a solução autorizada e repita o setup." >&2; exit 1;
}
[[ -x "$python_bin" && -f "$project/frontend/node_modules/expo/bin/cli" ]] || {
  echo "Execute primeiro: bash scripts/setup-codespace.sh" >&2; exit 1;
}
for tool in setsid timeout node; do
  command -v "$tool" >/dev/null || { echo "Ferramenta ausente: $tool. Reconstrua o devcontainer." >&2; exit 1; }
done
# Recusar conflito evita que o Expo escolha silenciosamente outra porta.
"$python_bin" - <<'PY'
import socket
for port in (8000, 8081):
    with socket.socket() as sock:
        try:
            sock.bind(("0.0.0.0", port))
        except OSError:
            raise SystemExit(f"Porta {port} ocupada. Encerre a atividade anterior com Ctrl+C.")
PY
api_url="https://${CODESPACE_NAME}-8000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
frontend_url="https://${CODESPACE_NAME}-8081.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}"
"$python_bin" - "$project/frontend/.env.local" "$api_url" <<'PY'
from pathlib import Path
import re
import sys
path = Path(sys.argv[1])
lines = path.read_text(encoding="utf-8").splitlines() if path.exists() else []
lines = [line for line in lines if not re.match(r"^\s*(?:export\s+)?EXPO_PUBLIC_API_URL\s*=", line)]
lines.append("EXPO_PUBLIC_API_URL=" + sys.argv[2])
path.write_text("\n".join(lines) + "\n", encoding="utf-8")
PY
pids=()
public_port=false
cleanup() {
  status=$?
  trap - EXIT INT TERM HUP
  for pid in "${pids[@]}"; do kill -TERM -- "-$pid" 2>/dev/null || true; done
  # Uvicorn --reload e Metro possuem subprocessos: encerrar o grupo inteiro.
  for attempt in {1..30}; do
    alive=false
    for pid in "${pids[@]}"; do kill -0 -- "-$pid" 2>/dev/null && alive=true; done
    [[ "$alive" == false ]] && break
    sleep 0.1
  done
  for pid in "${pids[@]}"; do
    kill -KILL -- "-$pid" 2>/dev/null || true
    wait "$pid" 2>/dev/null || true
  done
  if [[ "$public_port" == true ]]; then
    timeout 10 gh codespace ports visibility 8000:private -c "$CODESPACE_NAME" >/dev/null 2>&1 ||
      echo "Não foi possível restaurar a visibilidade. Na aba PORTAS, altere 8000 para Privado."
  fi
  echo "Servidores encerrados. Se alterou a visibilidade manualmente, volte a porta 8000 para Privado."
  exit "$status"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM HUP
(cd -- "$project/backend" && exec setsid "$python_bin" -m uvicorn main:app --reload --host 0.0.0.0 --port 8000) &
pids+=("$!")
# Usar a CLI instalada equivale a npx expo, sem baixar pacotes implicitamente.
(cd -- "$project/frontend" && exec setsid env CI=1 BROWSER=none EXPO_PUBLIC_API_URL="$api_url" node node_modules/expo/bin/cli start --web --host lan --port 8081) &
pids+=("$!")
printf '\n========================================\nQueueGOO — Ambiente Codespaces\n========================================\nAtividade: %s\nBackend: %s\nSwagger: %s/docs\nFrontend (porta 8081): %s\nCtrl+C encerra os dois servidores.\n========================================\n' "$activity" "$api_url" "$api_url" "$frontend_url"
if command -v gh >/dev/null && timeout 10 gh auth status >/dev/null 2>&1 &&
   timeout 15 gh codespace ports visibility 8000:public -c "$CODESPACE_NAME"; then
  public_port=true
  echo "Porta 8000 pública durante a sessão para acessar os dados simulados. Porta 8081 não foi alterada."
else
  echo "Abra a aba PORTAS do Codespaces."
  echo "Localize a porta 8000. Clique com o botão direito."
  echo "Visibilidade da porta -> Público. Mantenha 8081 privada."
fi
# Se um servidor falhar, a saída também encerra o outro.
set +e
wait -n "${pids[@]}"
status=$?
set -e
echo "Um dos servidores terminou; encerrando a atividade."
exit "$status"
