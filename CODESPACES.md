# QueueGOO — Executar pelo Codespaces

Use esta opção se não conseguir executar o projeto no seu computador.
Você precisa de internet, conta GitHub e acesso ao Codespaces.

## 1. Abrir o projeto

1. Abra o repositório da oficina no GitHub.
2. Clique em **Code → Codespaces → Create codespace**.
3. Aguarde o ambiente abrir e aparecer **Preparação concluída** no terminal.

Se a preparação falhar, execute:

```bash
bash scripts/setup-codespace.sh
```

## 2. Iniciar o backend

No terminal, começando na pasta principal do projeto, execute:

```bash
cd starter/backend
.venv/bin/python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

**Deixe esse terminal aberto.** Ele está executando a API.

## 3. Abrir e testar o backend

1. Abra a aba **PORTAS / PORTS**, ao lado do terminal.
2. Encontre a porta **8000**.
3. Clique com o botão direito nela e escolha **Visibilidade da porta → Público**.
4. Clique em **Abrir no navegador** nessa porta.
5. Acrescente `/docs` ao final do endereço que abriu.
6. No Swagger, abra **GET /restaurants → Try it out → Execute**.

Na Atividade 1, a resposta inicial é `[]`. Continue o exercício conforme o enunciado.

A porta 8000 fica pública para o frontend acessar a API. Faça isso somente nesta oficina, que usa dados simulados. Se a opção Público estiver bloqueada, chame o mediador.

## 4. Iniciar o frontend

Abra **outro terminal** pelo menu **Terminal → Novo Terminal**. Comece na pasta principal do projeto.

Copie e execute estes comandos. A linha do meio configura automaticamente o endereço da API do seu Codespace:

```bash
cd starter/frontend
printf 'EXPO_PUBLIC_API_URL=https://%s-8000.%s\n' "$CODESPACE_NAME" "$GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN" > .env.local
npx expo start --web --host lan --port 8081
```

Agora abra **PORTAS → 8081 → Abrir no navegador**.
**Mantenha a porta 8081 privada.** A tela do QueueGOO será aberta.

## 5. Fazer a atividade

Siga [ATIVIDADE_1.md](ATIVIDADE_1.md).
Para testar o erro de conexão, pressione **Ctrl+C somente no terminal do backend** e recarregue a página do aplicativo.
Depois, execute novamente o comando do Uvicorn e clique em **Tentar novamente**.

## 6. Trocar para a Atividade 2

1. Pressione **Ctrl+C nos dois terminais**.
2. Feche esses terminais e abra dois novos na pasta principal.
3. Repita os passos 2 a 4, trocando `starter/backend` por `starter2/backend` e `starter/frontend` por `starter2/frontend`.
4. Siga [ATIVIDADE_2.md](ATIVIDADE_2.md).

Para os mediadores executarem a solução, o mesmo procedimento usa `final/backend` e `final/frontend`, depois de disponibilizar a pasta final e repetir o setup.

## 7. Encerrar

- Pressione **Ctrl+C nos dois terminais**.
- Na aba PORTAS, volte a porta **8000 para Privado**.
- Pare o Codespace pelo GitHub quando terminar.

Se não houver internet ou Codespaces disponível, forme dupla em uma máquina preparada.
