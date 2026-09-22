#!/usr/bin/env bash
set -u
printf 'QueueGOO — Verificação de ambiente\n'
failed=0
if command -v python3 >/dev/null && python3 --version 2>/dev/null | grep -q '^Python 3'; then
  echo "[OK] Python encontrado: $(python3 --version)"
elif command -v python >/dev/null && python --version 2>/dev/null | grep -q '^Python 3'; then
  echo "[OK] Python encontrado: $(python --version)"
else
  echo "[ERRO] Python 3 não encontrado ou não executa."
  failed=1
fi
for tool in node npm; do
  if command -v "$tool" >/dev/null && version=$("$tool" --version 2>/dev/null); then
    echo "[OK] $tool encontrado: $version"
  else
    echo "[ERRO] $tool não encontrado ou não executa."
    failed=1
  fi
done
if [[ "$failed" -ne 0 ]]; then
  echo "O ambiente local não está pronto. Utilize outro computador preparado ou consulte CODESPACES.md."
else
  echo "Ferramentas disponíveis. Siga o README da atividade para instalar as dependências e executar."
fi
exit "$failed"
