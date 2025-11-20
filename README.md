# Participantes

Any Caroline de Mello Martins - R.A: 178678-2024
Artur Ribeiro Bérgamo - R.A: 169479-2024


# ChatApp - Aplicativo de Mensagens em Tempo Real

Aplicativo mobile de chat desenvolvido em Flutter com backend Supabase, seguindo as especificações do projeto da disciplina de Programação para Dispositivos Móveis.

## Características

- Autenticação com email e senha
- Interface moderna inspirada no WhatsApp
- Chat em tempo real (em desenvolvimento)
- Conversas individuais e em grupo (em desenvolvimento)
- Envio de mensagens de texto e mídia (em desenvolvimento)

## Tecnologias

- **Flutter** - Framework para desenvolvimento mobile
- **Supabase** - Backend as a Service (Auth, Database, Realtime, Storage)
- **Dart** - Linguagem de programação

## Configuração do Projeto

### 1. Pré-requisitos

- Flutter SDK (>=3.0.0)
- Dart SDK
- Conta no Supabase (gratuita)

### 2. Criar Projeto no Supabase

1. Acesse [supabase.com](https://supabase.com) e crie uma conta
2. Clique em "New Project"
3. Preencha os dados:
   - Nome do projeto: `chatapp` (ou nome de sua preferência)
   - Database Password: escolha uma senha forte
   - Region: escolha a região mais próxima
4. Aguarde a criação do projeto (pode levar alguns minutos)

### 3. Obter Credenciais do Supabase

1. No dashboard do seu projeto, vá em **Settings** > **API**
2. Copie as seguintes informações:
   - **Project URL** (algo como: `https://xxxxx.supabase.co`)
   - **anon/public key** (chave pública para uso no app)

### 4. Configurar o Aplicativo

1. Clone ou baixe este projeto
2. Abra o arquivo `lib/main.dart`
3. Substitua as credenciais do Supabase:

\`\`\`dart
await Supabase.initialize(
  url: 'SUA_URL_DO_SUPABASE',  // Cole a Project URL aqui
  anonKey: 'SUA_CHAVE_ANONIMA', // Cole a anon key aqui
);
\`\`\`

### 5. Instalar Dependências

\`\`\`bash
flutter pub get
\`\`\`

### 6. Executar o Aplicativo

\`\`\`bash
flutter run
\`\`\`

## Estrutura do Projeto

\`\`\`
lib/
├── main.dart                 # Ponto de entrada e configuração do Supabase
├── models/
│   └── conversation_model.dart  # Modelo de dados das conversas
├── screens/
│   ├── login_screen.dart     # Tela de login
│   ├── register_screen.dart  # Tela de cadastro
│   └── home_screen.dart      # Tela principal com lista de conversas
├── services/
│   └── auth_service.dart     # Serviço de autenticação
└── widgets/
    └── conversation_item.dart # Widget de item de conversa
\`\`\`

## Funcionalidades Implementadas

- ✅ Tela de login com validação
- ✅ Tela de cadastro de usuários
- ✅ Autenticação com Supabase Auth
- ✅ Logout com confirmação
- ✅ Interface de lista de conversas
- ✅ Verificação automática de sessão


### ⚠️ IMPORTANTE: Executar Scripts SQL no Supabase

**Antes de usar o chat, você DEVE executar os scripts SQL no Supabase:**

1. Acesse seu projeto no [Supabase Dashboard](https://app.supabase.com)
2. No menu lateral, clique em **SQL Editor**
3. Clique em **New Query** (ou "Nova Consulta")
4. Copie e cole o conteúdo de cada script SQL na ordem abaixo:

#### Ordem de Execução dos Scripts:

1. **`scripts/01_create_tables.sql`** - Cria todas as tabelas necessárias
   - Copie todo o conteúdo do arquivo
   - Cole no SQL Editor
   - Clique em **Run** (ou pressione Ctrl+Enter)
   - Aguarde a mensagem de sucesso

2. **`scripts/02_enable_realtime.sql`** - Ativa mensagens em tempo real
   - Copie todo o conteúdo
   - Cole no SQL Editor
   - Execute

3. **`scripts/03_rls_policies.sql`** - Configura segurança das tabelas
   - Copie todo o conteúdo
   - Cole no SQL Editor
   - Execute

4. **`scripts/04_functions.sql`** - Cria funções auxiliares
   - Copie todo o conteúdo
   - Cole no SQL Editor
   - Execute

5. **`scripts/05_storage.sql`** - Configura armazenamento de arquivos
   - Copie todo o conteúdo
   - Cole no SQL Editor
   - Execute

#### Verificar se as Tabelas Foram Criadas:

Após executar os scripts, verifique no menu **Table Editor** se as seguintes tabelas existem:
- profiles
- conversations
- conversation_participants
- messages
- message_reactions
- typing_indicators

Se todas as tabelas aparecerem, o banco está configurado corretamente! 🎉

## Segurança

O projeto utiliza Row Level Security (RLS) do Supabase para garantir que:
- Usuários só acessem suas próprias conversas
- Mensagens sejam visíveis apenas para participantes
- Dados sensíveis sejam protegidos

