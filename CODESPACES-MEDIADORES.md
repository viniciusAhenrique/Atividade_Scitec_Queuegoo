# QueueGOO — Referência dos mediadores

O modo recomendado da oficina é **local**.
Utilize Codespaces apenas se Python, Node, npm ou Expo não estiverem disponíveis ou se o ambiente local apresentar problemas que não possam ser resolvidos rapidamente.
O código e os exercícios são os mesmos nos dois ambientes.

## Pré-requisitos

- Navegador atualizado e conexão com a internet.
- Conta GitHub e disponibilidade de GitHub Codespaces na conta.
- Acesso ao repositório da oficina informado pelos mediadores.

## Plano A — local

Na raiz do projeto, verifique as ferramentas sem instalar nada:

```powershell
# Windows / PowerShell
.\scripts\check-environment.ps1
```

```bash
# Linux, macOS ou Git Bash
bash scripts/check-environment.sh
```

Os scripts verificam se Python 3, Node e npm estão disponíveis e executam; não substituem o teste da aplicação. Se estiver tudo disponível, siga os comandos locais do README de `starter`, `starter2` ou `final`. Os comandos locais existentes continuam válidos. Se o PowerShell bloquear scripts pela política da máquina, peça ajuda ao mediador ou use a alternativa Bash; não é necessário alterar a política para executar a oficina.

## Plano B — Codespaces

1. Abra o repositório da oficina no GitHub.
2. Clique em **Code → Codespaces → Create codespace** (ou **Create codespace on main**). Também pode usar o botão **Open in GitHub Codespaces** do README, depois de o mediador configurar o endereço.
3. Aguarde o VS Code Web abrir e a criação do ambiente terminar.
4. Aguarde o setup automático instalar as dependências. A mensagem final será “Preparação concluída”. Se houver falha de download, repita no terminal:

   ```bash
   bash scripts/setup-codespace.sh
   ```

5. No terminal do Codespaces, na raiz do projeto, execute a atividade desejada:

   ```bash
   # Atividade 1
   bash scripts/start-codespace.sh starter
   ```

   Para trocar de atividade, pressione **Ctrl+C**, aguarde a mensagem de encerramento e execute:

   ```bash
   # Atividade 2
   bash scripts/start-codespace.sh starter2
   ```

   Para a demonstração dos mediadores, com a pasta final disponível:

   ```bash
   bash scripts/start-codespace.sh final
   ```

6. Abra a aba **PORTAS / PORTS** no painel inferior do VS Code Web. Confirme:

   | Porta | Nome | Visibilidade |
   | --- | --- | --- |
   | 8000 | QueueGOO FastAPI | Pública durante a atividade |
   | 8081 | QueueGOO Expo Web | Privada |

7. Se 8000 estiver privada: botão direito na porta **8000 → Visibilidade da porta → Público**. Altere somente essa porta.
8. Na linha **8081**, clique em **Abrir no navegador**. Use o endereço HTTPS encaminhado, não localhost do seu computador.
9. Para abrir o Swagger, use o endereço do backend mostrado pelo script, acrescentando `/docs`.

O Expo roda em modo não interativo; use a aba PORTAS para abrir a aplicação. Não precisa apertar `w` no terminal.

## Por que a porta 8000 fica pública?

O frontend roda no navegador e faz fetch para outra origem, a URL encaminhada do backend. A autenticação de uma porta privada pode bloquear essa chamada ou redirecioná-la para o login do GitHub. O CORS já existente permite a comunicação, mas não remove essa autenticação.

Neste projeto didático, a API contém somente restaurantes simulados, sem credenciais ou dados privados. Por isso, o script tenta publicar **somente a porta 8000**, usando GitHub CLI se estiver disponível e autenticado. Qualquer pessoa com o endereço poderá acessar essa API enquanto a porta estiver pública. **Use essa estratégia somente nesta oficina com dados simulados.**

Se o comando falhar, a aplicação continua iniciando e o terminal mostra as instruções manuais. A organização pode proibir portas públicas; se a opção não estiver disponível, peça ajuda ao mediador e use o Plano A ou C. Não é necessário criar tokens nem colocar credenciais no frontend.

**8081 permanece privada**: o aluno autenticado abre sua própria aplicação. O script não modifica sua visibilidade.

Ao pressionar Ctrl+C, os dois servidores e seus subprocessos são encerrados. Se o script tornou 8000 pública, tenta restaurá-la para privada. Se você fez a alteração manualmente ou a restauração falhou, volte 8000 para **Privado** pela aba PORTAS. Ao terminar, pare o Codespace pelo menu do GitHub para encerrar o uso do ambiente.

## Como a URL é configurada

Localmente, sem `EXPO_PUBLIC_API_URL`, a API continua sendo `http://127.0.0.1:8000`.
No Codespaces, o script usa `CODESPACE_NAME` e `GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN` para gerar:

```text
https://${CODESPACE_NAME}-8000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}
```

O script grava somente essa configuração no `.env.local` do frontend selecionado, preservando outras linhas. O arquivo é ignorado pelo Git. A URL não é segredo; nunca coloque tokens, senhas, API keys ou GITHUB_TOKEN em `EXPO_PUBLIC_*`.

Se copiar os arquivos do Codespaces de volta para o computador, não copie `.env.local`, `.venv` nem `node_modules`. Remova a configuração de `EXPO_PUBLIC_API_URL` do ambiente local para voltar ao endereço padrão. Reinicie o Expo após trocar o ambiente.

## Preparação dos mediadores e Template Repository

O repositório deve conter a estrutura completa na raiz: `.devcontainer/`, `scripts/`, `starter/`, `starter2/`, os enunciados e esta documentação. Não use somente a pasta frontend como repositório.

O pacote `QueueGOO-alunos.zip` já inclui os arquivos de contingência. Extraia seu conteúdo e publique os arquivos no repositório destinado aos alunos, incluindo `.devcontainer`, `.gitignore` e `.gitattributes`. Não publique apenas o ZIP: o Codespaces precisa enxergar os arquivos descompactados.

O pacote dos alunos mantém a solução somente em `final.zip` protegido. Não publique a pasta `final` aberta em um repositório acessível aos alunos antes da liberação. Não inclua a senha no README nem em commits. Para a demonstração, os mediadores podem usar um repositório privado com `final/` disponível. Após a liberação, também podem extrair a solução em um computador e enviar a pasta `final/` pelo explorador do VS Code Web. Então repita `bash scripts/setup-codespace.sh` e inicie `final`. O setup ignora final enquanto a pasta estiver ausente; não pede senha nem tenta abrir o arquivo protegido.

O proprietário pode marcar **Settings → General → Template repository**. Cada participante poderá criar uma cópia e seu Codespace. Os scripts usam a raiz do próprio projeto e as variáveis do próprio Codespace, sem depender de usuário, caminhos da máquina ou secrets do criador.

O badge usa um placeholder até o repositório ser definido. Substitua `SEU_USUARIO/SEU_REPOSITORIO` no README pela identificação real; ao criar uma cópia a partir do template, ajuste o badge da cópia ou abra pelo menu **Code → Codespaces**.

## Problemas comuns

- **Setup interrompido:** execute novamente o setup; ele reutiliza o ambiente Python e reinstala exatamente o lockfile npm, sem atualizar versões ou copiar node_modules.
- **Porta ocupada:** encerre a atividade anterior com Ctrl+C. Não rode duas atividades ao mesmo tempo.
- **Erro de rede no fetch:** abra a URL do backend e `/health`, confira a visibilidade de 8000 e consulte Console/Network.
- **Backend desligado no teste da Atividade 1:** o script mantém os servidores juntos. Para testar desligamento independente, pressione Ctrl+C e use dois terminais, a partir da raiz, após já ter iniciado a atividade uma vez para gerar `.env.local`:

  ```bash
  # Terminal 1 — backend
  cd starter/backend
  .venv/bin/python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
  ```

  ```bash
  # Terminal 2 — frontend
  cd starter/frontend
  npx expo start --web --host lan --port 8081
  ```

  Confirme novamente que 8000 está pública. Agora desligue somente o backend, recarregue a página, religue o backend e use “Tentar novamente”, conforme o enunciado. No final, encerre ambos e restaure 8000 para privada.
- **Sem cota de Codespaces ou sem internet:** use o Plano C.

## Plano C — dupla em máquina preparada

Sem ambiente local e sem Codespaces/internet, forme dupla em uma máquina já preparada. As atividades continuam iguais.

## Referências

- [Variáveis de ambiente do Expo](https://docs.expo.dev/guides/environment-variables/)
- [Encaminhamento e visibilidade de portas no Codespaces](https://docs.github.com/en/codespaces/developing-in-a-codespace/forwarding-ports-in-your-codespace)
- [Comando de visibilidade do GitHub CLI](https://cli.github.com/manual/gh_codespace_ports_visibility)
