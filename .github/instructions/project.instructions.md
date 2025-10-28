# ⚙️ Projeto Flutter - Configurações de Estilo e Linguagem

## 🌍 Idioma
- Linguagem principal: **Português (pt-BR)**
- Comentários no código e nomes de variáveis devem estar em **inglês**.
- Commits devem seguir o padrão **Conventional Commits** em inglês.

## 💡 Objetivo
Aplicativo Flutter moderno, limpo e performático, com foco em **usabilidade e design consistente**.

## 🧱 Arquitetura
- Utilizar **Clean Architecture**.
- Gerenciamento de estado: `Riverpod` ou `Bloc` (dependendo da complexidade futura).
- Requisições HTTP: `Dio` (com interceptors e logging configurado).
- Navegação: `GoRouter`.

## 🎨 UI/UX
- Tema principal: azul (#2563EB), cinza-escuro (#333333) e fundo claro (#F4F1E8).

- Paleta de apoio: azul-claro (#60A5FA), cinza-médio (#666666), cinza-claro (#D6D3CE), verde-sucesso (#3BAA78) e vermelho-erro (#E05656).

- Estilo: design limpo, moderno e acessível — azul usado para ações e destaques.

- Tipografia: Inter ou Poppins, com foco em legibilidade.

- Componentes: priorizar clareza, contraste e espaçamento equilibrado.

## 🧰 Convenções de Código
- Formatação automática com `dart format`.
- Lints configurados com `flutter_lints` + regras personalizadas.
- Nomes de classes e métodos em `UpperCamelCase`.
- Variáveis e parâmetros em `lowerCamelCase`.

## 🧑‍💻 Padrão de Branches
- `main` → versão estável.
- `dev` → desenvolvimento ativo.
- `feature/*` → novas funcionalidades.
- `fix/*` → correções.

# 📱 Projeto Flutter - Atividade Técnica ESIG Group

## 🧭 Contexto
Este projeto foi desenvolvido como parte do processo seletivo da **ESIG Group** (vaga Mobile Flutter).  
O objetivo é demonstrar domínio em **desenvolvimento mobile com Flutter**, boas práticas de **organização de código**, **gerenciamento de estado**, **integração com recursos nativos** e **consumo de APIs**.

---

## 🎯 Objetivo do App
Desenvolver um aplicativo mobile que simula o **feed de uma rede social**, permitindo visualizar, criar, editar e excluir posts.

---

## 🧱 Funcionalidades Principais

1. **Tela de Login**
   - Campos de usuário e senha.
   - Credenciais validadas internamente (função separada no app).
   - Persistência local opcional.

2. **Feed de Posts**
   - Exibição em formato de **cards**.
   - Atualização dinâmica (MobX observables).
   - Navegação para detalhes do post.

3. **CRUD de Posts**
   - Criar novos posts.
   - Editar posts existentes.
   - Excluir posts.

4. **Tela de Detalhes**
   - Exibe o conteúdo completo do post.
   - Permite edição e exclusão a partir dela.

5. **Integração Nativa**
   - Utilizar pelo menos **um recurso nativo**, como:
     - 📷 Câmera
     - 📍 Localização
     - 🔒 Biometria

6. **Persistência**
   - Opção 1: Dados salvos localmente (armazenamento local).
   - Opção 2: Backend próprio (preferencialmente **Spring Boot** ou linguagem à escolha).

---

## ⚙️ Requisitos Técnicos

| Categoria | Requisito |
|------------|------------|
| **Organização do Código** | Uso de boas práticas e padrões de projeto para garantir manutenibilidade e escalabilidade. |
| **Gerenciamento de Estado** | Utilizar a biblioteca **MobX**. |
| **Consumo de API** | Utilizar **Dio** para requisições HTTP (se houver backend). |
| **Recurso Nativo** | Implementar ao menos um recurso do dispositivo. |
| **Layout** | Livre, com foco em clareza e boa UX. |

---

## 🧩 Padrões de Desenvolvimento

### Linguagem e Estilo
- **Código em inglês** (variáveis, classes e métodos).  
- **Comentários e documentação em português**, para clareza na avaliação.  
- **Commits em inglês**, seguindo o padrão *Conventional Commits*.
