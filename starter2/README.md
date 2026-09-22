# QueueGOO — Atividade Prática 2 — Incidente QG-002

Abra dois terminais PowerShell na raiz do workspace. Execute apenas uma versão por vez; encerre os servidores da anterior com Ctrl+C para não confundir portas.

## Backend — terminal 1

```powershell
cd starter2/backend
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
.\.venv\Scripts\python.exe -m uvicorn main:app --reload --host 127.0.0.1 --port 8000
```

Se o ambiente já estiver instalado, execute apenas o último comando.
Swagger: http://127.0.0.1:8000/docs. Saúde: http://127.0.0.1:8000/health.

## Frontend — terminal 2

```powershell
cd starter2/frontend
npm ci
npm run web
```

Se as dependências já estiverem instaladas, execute apenas `npm run web`.
Abra o endereço exibido pelo Expo. O frontend usa a API local em `http://127.0.0.1:8000` e deve rodar no navegador do mesmo computador.

Roteiro: [ATIVIDADE_2.md](../ATIVIDADE_2.md).
