<div align="center">

# QueueGOO

### Do primeiro `fetch` à investigação de um incidente.

Uma oficina prática para conectar **frontend e backend** — e entender o que acontece entre um clique e uma resposta.

![React Native](https://img.shields.io/badge/React_Native-20232A?style=flat-square&logo=react&logoColor=61DAFB)
![Expo Web](https://img.shields.io/badge/Expo_Web-000020?style=flat-square&logo=expo&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)

**[Começar a Atividade 1](ATIVIDADE_1.md)** · **[Investigar o incidente](ATIVIDADE_2.md)** · **[Executar pelo navegador](CODESPACES.md)**

</div>

---

## Bem-vindo à equipe 👋

O **QueueGOO** é um aplicativo de consulta a restaurantes. Durante a oficina, você vai conectar sua interface a uma API, acompanhar as requisições e investigar o comportamento de uma funcionalidade.

A proposta é aprender fazendo: primeiro, com a orientação dos mediadores; depois, colocando em prática sua capacidade de investigar e resolver problemas.

> **Nosso percurso:** construir a integração → observar o resultado → investigar um incidente.

## Duas atividades, um mesmo projeto

| | Atividade 1 · Integração guiada | Atividade 2 · Incidente QG-002 |
| :--- | :--- | :--- |
| **Seu desafio** | Conectar a lista de restaurantes à API. | Investigar a funcionalidade de detalhes. |
| **Como vamos trabalhar** | Passo a passo, com a apresentação e os mediadores. | Em equipe, reproduzindo, investigando e validando. |
| **Pasta de trabalho** | `starter/` | `starter2/` |
| **Roteiro** | [Abrir Atividade 1 →](ATIVIDADE_1.md) | [Abrir Atividade 2 →](ATIVIDADE_2.md) |

A segunda atividade acontece depois da primeira e tem **30 minutos** de investigação. Swagger, Console, Network, apresentação, documentação, internet e IA fazem parte das ferramentas disponíveis.

## O que você vai praticar

- Entender os papéis do cliente e do servidor.
- Consultar uma API HTTP e interpretar respostas em JSON.
- Usar `fetch`, atualizar o estado e mostrar dados na interface.
- Reconhecer os estados de **carregamento, erro e sucesso**.
- Investigar problemas por camadas e comprovar uma correção.

```text
Interface → fetch → FastAPI → dados locais
    ↑                              │
    └──── estado ← resposta JSON ──┘
```

Usamos dados simulados em memória para concentrar a prática na integração. Não é necessário configurar um banco de dados.

## Vamos começar 🚀

### 1. Prepare os arquivos

Se recebeu `QueueGOO-alunos.zip`, salve-o no computador e escolha **Extrair para** no WinRAR. O pacote dos alunos não tem senha. Trabalhe na pasta extraída.

Se está usando o repositório, abra sua cópia local do projeto.

### 2. Confira o ambiente

O modo recomendado da oficina é **local**, com Python 3, Node.js e npm. Abra um terminal na pasta principal e execute:

**Windows · PowerShell**

```powershell
.\scripts\check-environment.ps1
```

**Linux, macOS ou Git Bash**

```bash
bash scripts/check-environment.sh
```

Essa verificação não instala nada. Com o ambiente disponível, siga para a atividade.

### 3. Execute a Atividade 1

Abra as [instruções de execução de starter](starter/README.md). Elas mostram os comandos para iniciar o **backend em um terminal** e o **frontend em outro**.

Depois, siga o [roteiro da Atividade 1](ATIVIDADE_1.md), começando pelo backend e pelo Swagger.

### 4. Continue para o incidente

Ao concluir a primeira prática, encerre os servidores com **Ctrl+C**. Abra as [instruções de execução de starter2](starter2/README.md) e siga o [incidente QG-002](ATIVIDADE_2.md).

> Execute **uma atividade por vez** para evitar conflitos de portas.

## Problemas com o ambiente local?

Você também pode executar as mesmas atividades inteiramente pelo navegador, usando **GitHub Codespaces**.

**[Abrir o passo a passo do Codespaces →](CODESPACES.md)**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/SEU_USUARIO/SEU_REPOSITORIO?quickstart=1)

> **Badge aguardando configuração:** os mediadores devem substituir `SEU_USUARIO/SEU_REPOSITORIO` pelo repositório real. Enquanto isso, abra pelo menu **Code → Codespaces** no GitHub.

| Plano | Quando usar | Próximo passo |
| :--- | :--- | :--- |
| **A · Local** | Computador com ambiente disponível. | Seguir o README da atividade. |
| **B · Navegador** | Problemas de instalação ou configuração local. | Seguir [CODESPACES.md](CODESPACES.md). |
| **C · Em dupla** | Sem ambiente local e sem Codespaces ou internet. | Trabalhar em uma máquina já preparada. |

## Encontre seu material

```text
QueueGOO/
├── starter/                   Atividade 1: integração guiada
├── starter2/                  Atividade 2: investigação do incidente
├── apoio/                     Espaço para materiais de apoio
├── scripts/                   Verificação e execução do ambiente
├── .devcontainer/             Configuração do Codespaces
├── ATIVIDADE_1.md              Roteiro da primeira prática
├── ATIVIDADE_2.md              Descrição do incidente QG-002
├── CODESPACES.md               Passo a passo pelo navegador
└── final.zip                  Solução e gabaritos protegidos
```

A pasta `apoio/` pode não aparecer no repositório enquanto estiver vazia.

## Solução ao final da oficina 🔓

O arquivo **`final.zip`** reúne a implementação corrigida e os gabaritos. A senha será fornecida pelos mediadores **ao final do curso**.

Depois da liberação, extraia o arquivo na pasta principal do projeto e siga `final/README.md`. A aplicação final permite alternar entre as duas atividades.

---

<div align="center">

**Observe a requisição. Entenda a resposta. Valide o resultado.**

QueueGOO · Oficina prática de integração frontend e backend

</div>
