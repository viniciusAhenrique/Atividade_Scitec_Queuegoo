#!/usr/bin/env bash
set -euo pipefail
if [[ "${CODESPACES:-}" != "true" ]]; then
  echo "Este script é exclusivo do GitHub Codespaces. Para execução local, siga o README da atividade." >&2
  exit 1
fi
PROJECT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
for tool in python3 node npm; do
  command -v "$tool" >/dev/null || { echo "Ferramenta ausente: $tool. Reconstrua o devcontainer." >&2; exit 1; }
done
found=0
for activity in starter starter2 final; do
  project="$PROJECT_ROOT/$activity"
  if [[ ! -d "$project" ]]; then
    echo "$activity ausente; ignorando (a solução pode estar no arquivo protegido)."
    continue
  fi
  [[ -f "$project/backend/requirements.txt" && -f "$project/frontend/package-lock.json" ]] || {
    echo "Estrutura incompleta em $activity: requirements.txt ou package-lock.json ausente." >&2; exit 1;
  }
  echo "Preparando $activity..."
  if [[ ! -x "$project/backend/.venv/bin/python" ]]; then
    if [[ -d "$project/backend/.venv" ]]; then
      echo "Ambiente virtual incompatível em $activity. Não envie .venv do Windows ao Codespaces." >&2; exit 1
    fi
    python3 -m venv "$project/backend/.venv"
  fi
  "$project/backend/.venv/bin/python" -m pip install -r "$project/backend/requirements.txt"
  (cd -- "$project/frontend" && npm ci --no-audit --no-fund)
  found=$((found + 1))
done
[[ "$found" -gt 0 ]] || { echo "Nenhuma atividade encontrada." >&2; exit 1; }
echo "Preparação concluída. Execute: bash scripts/start-codespace.sh starter"
