# ATIVIDADE PRÁTICA 1
## Conectando frontend e backend

Objetivo: fazer o React Native consumir os restaurantes fornecidos pelo FastAPI.
Use `starter/` e consulte a apresentação. Os comandos estão em [starter/README.md](starter/README.md).

### Backend

1. Inicie Uvicorn.
2. Acesse http://127.0.0.1:8000/docs.
3. Execute GET /restaurants e observe `[]`.
4. Complete TODO 1.
5. Teste novamente: confira os três restaurantes no Swagger.

### Frontend

1. Inicie Expo Web e observe que a interface ainda não recebe restaurantes.
2. Localize `carregarRestaurantes()`.
3. Complete TODO 2 e TODO 3 escrevendo o fluxo de comunicação apresentado na aula.
4. Salve e confirme os três restaurantes na tela.

### Teste

1. No Network, ative uma conexão lenta e recarregue a página para observar loading; depois restaure a conexão normal.
2. Desligue o backend com Ctrl+C no terminal do Uvicorn.
3. Recarregue a página para provocar uma nova requisição e observe o erro. Dados já carregados não desaparecem automaticamente quando o servidor para.
4. Ligue o backend novamente.
5. Clique em **Tentar novamente** e observe o sucesso.

### Ao final, tente responder

- Quem é o cliente? Quem é o servidor?
- Qual rota foi utilizada? O que o servidor devolveu?
- Para que serve fetch? Para que serve response.json()?
- O que setRestaurantes(data) provoca?
