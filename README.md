# DevConnect - Aplicativo Social Media Flutter# dev_connect



Um aplicativo Flutter moderno para rede social com suporte a criação, edição e exclusão de posts, integração com câmera/galeria, gerenciamento de estado reativo e persistência local.



## 📱 Visão Geral## Getting Started



**DevConnect** é um aplicativo mobile desenvolvido em Flutter que simula uma rede social completa, com foco em:

- ✅ Arquitetura limpa e escalável

- ✅ Gerenciamento de estado reativo com MobXA

- ✅ Captura e manipulação de imagens em bytes

- ✅ Persistência local com Hive- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)

- ✅ Integração HTTP com Dio- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

- ✅ Navegação moderna com GoRouter

- ✅ Design responsivo e acessível

[online documentation](https://docs.flutter.dev/), which offers tutorials,


## 🏗️ Arquitetura

O projeto segue **Clean Architecture** com separação clara de responsabilidades:

```
lib/
├── core/
│   ├── db/                          # Persistência local (Hive)
│   ├── di/                          # Injeção de dependências (GetIt)
│   ├── formatters/                  # Formatadores de dados
│   │   └── date_formatter.dart      # Formatação de datas relativas
│   ├── mixins/                      # Mixins reutilizáveis
│   │   └── image_picker_mixin.dart  # Seleção de imagens (galeria/câmera)
│   ├── network/                     # Configuração HTTP
│   │   └── api_client.dart          # Cliente Dio com interceptors
│   ├── routes/                      # Roteamento
│   │   └── app_routes.dart          # Definição de rotas (GoRouter)
│   └── ui/
│       ├── components/              # Componentes reutilizáveis
│       │   ├── dc_button.dart       # Botão customizado
│       │   ├── dc_circular_avatar.dart # Avatar circular com bytes
│       │   ├── dc_text_form_field.dart # Campo de texto
│       │   └── post/                # Componentes de post
│       │       ├── post_header.dart     # Cabeçalho do post (autor + data)
│       │       ├── post_card.dart       # Card principal do post
│       │       ├── post_actions.dart    # Botões de ação
│       │       └── post_timestamp.dart  # Exibição de data relativa
│       ├── dialog/                  # Diálogos
│       │   └── delete_confirmation_dialog.dart # Confirmar delete
│       │   └── image_source_picker_dialog.dart # Escolher galeria/câmera
│       ├── helpers/                 # Helpers e utilities
│       │   └── snackbar_helper.dart # Notificações
│       └── loading/                 # Componentes de carregamento
│           └── dc_loading.dart      # Spinner customizado
├── features/
│   ├── auth/                        # Feature de autenticação
│   │   └── login_page.dart          # Tela de login
│   ├── feed/                        # Feature de feed
│   │   ├── controller/
│   │   │   └── feed_controller.dart # Lógica do feed
│   │   ├── store/
│   │   │   └── feed_store.dart      # Estado reativo (MobX)
│   │   └── feed_page.dart           # Tela do feed
│   ├── post/                        # Feature de posts (genérica)
│   │   └── post_detail_page.dart    # Detalhes do post
│   ├── post_detail/                 # Feature de detalhes
│   │   ├── controller/
│   │   │   └── post_detail_controller.dart
│   │   ├── store/
│   │   │   └── post_detail_store.dart
│   │   ├── post_detail_page.dart
│   └── upsert/                      # Feature de criar/editar posts
│       ├── controller/
│       │   └── upsert_post_controller.dart
│       ├── store/
│       │   └── upsert_post_store.dart
│       ├── upsert_post_page.dart
├── models/                          # Modelos de dados
│   ├── post_model.dart              # Post com serialização JSON
├── repositories/                    # Padrão Repository
│   ├── post_repository.dart         # Interface
│   └── post_repository_impl.dart    # Implementação
├── services/                        # Serviços de negócio
│   ├── post_service.dart            # Interface
│   └── post_service_impl.dart       # Implementação
└── main.dart                        # Entry point
```

---

## 🔑 Padrões de Arquitetura

### **1. Repository Pattern**
Abstração entre dados e lógica de negócio:
```dart
abstract class PostRepository {
  Future<List<Post>> fetchPosts();
  Future<Post?> createPost(Post post);
  Future<Post?> updatePost(Post post);
  Future<bool> deletePost(String id);
}

class PostRepositoryImpl implements PostRepository {
  // Implementação com Dio
}
```

### **2. Service Pattern**
Lógica de negócio centralizada:
```dart
abstract class PostService {
  Future<List<Post>> getPosts();
  Future<Post?> createPost(Post post);
  // ... outros métodos
}

class PostServiceImpl implements PostService {
  final PostRepository _repository;
  // Lógica de negócio
}
```

### **3. Controller Pattern**
Orquestração entre UI, Store e Services:
```dart
class FeedController {
  late FeedStore store;
  final PostService _service;

  Future<void> init() async {
    store.setLoading(true);
    final posts = await _service.getPosts();
    store.setPosts(posts);
  }
}
```

### **4. Store Pattern (MobX)**
Estado reativo e observável:
```dart
class FeedStore = _FeedStore with _$FeedStore;

abstract class _FeedStore with Store {
  @observable
  List<Post> posts = [];

  @action
  void setPosts(List<Post> value) {
    posts = value;
  }
}
```

---

## 📦 Dependências Principais

### **State Management**
- **mobx** (^3.4.0): Gerenciamento reativo de estado
- **flutter_mobx** (^2.1.0): Integração MobX com Flutter (Observer, etc)

### **HTTP & Networking**
- **dio** (^5.3.0): Cliente HTTP com interceptors, retry, timeout
- **flutter_dotenv** (^5.1.0): Carregamento de variáveis de ambiente (.env)

### **Persistência Local**
- **hive** (^2.2.0): Database local NoSQL type-safe
- **hive_flutter** (^1.1.0): Integração Hive com Flutter

### **Injeção de Dependências**
- **get_it** (^7.5.0): Service Locator para DI

### **Navegação**
- **go_router** (^12.0.0): Roteamento declarativo e moderno com deep linking

### **Serialização**
- **json_annotation** (^4.8.0): Anotações para JSON
- **json_serializable** (^6.7.0): Gerador de código para serialização

### **Imagens & Mídia**
- **image_picker** (^1.0.0): Seleção de imagens (câmera/galeria)
- **google_fonts** (^5.1.0): Fontes Google customizadas

### **Formatação & Internacionalização**
- **intl** (^0.19.0): Formatação de datas, números e internacionalização
- **validatorless** (^1.2.0): Validação de formulários sem dependências

### **Qualidade de Código**
- **flutter_lints** (^2.0.0): Regras de lint recomendadas pelo Flutter
- **build_runner** (^2.4.0): Gerador de código (rodar: `flutter pub run build_runner`)
- **mobx_codegen** (^2.4.0): Gerador de código MobX

### **Desenvolvimento & UX**
- **flutter_launcher_icons** (^0.13.0): Gerador automático de ícones
- **flutter_native_splash** (^2.3.0): Tela de splash nativa (Android/iOS)

---

## 🔄 Fluxo de Dados

### **Exemplo: Fetch Posts**

```
UI (FeedPage)
    ↓
Observer (reação a mudanças com MobX)
    ↓
FeedController.init()
    ↓
FeedStore.setLoading(true)  [notifica observers]
    ↓
PostService.getPosts()
    ↓
PostRepository.fetchPosts()
    ↓
ApiClient (Dio)
    ↓
Backend (Node.js + MongoDB)
    ↓
FeedStore.setPosts(posts)  [notifica observers]
    ↓
Observer recompila UI com novos posts
```

---

## 🖼️ Modelo de Post

```dart
@HiveType(typeId: 1)
class Post extends HiveObject {
  @HiveField(0)
  late String id;                    // ID no MongoDB
  
  @HiveField(1)
  late String author;                // Nome do autor
  
  @HiveField(2)
  late Uint8List authorImageBytes;   // Imagem em bytes (base64 no JSON)
  
  @HiveField(3)
  late String content;               // Conteúdo do post
  
  @HiveField(4)
  late int likes;                    // Contagem de curtidas
  
  @HiveField(5)
  late bool isLiked;                 // Se o usuário curtiu
  
  @HiveField(6)
  late DateTime? createdAt;          // Data de criação (relativo: "há 5m")
  
  @HiveField(7)
  late DateTime? updatedAt;          // Data de atualização
}
```

### **Serialização JSON**
- **fromJson**: Converte base64 (String) → `Uint8List`
- **toJson**: Converte `Uint8List` → base64 (String)
- Conversor customizado: `_base64ToUint8List` e `_uint8ListToBase64`

---

## 📱 Integração com Câmera/Galeria

### **Mixin: ImagePickerMixin**
Encapsula a lógica de seleção de imagens:
```dart
mixin ImagePickerMixin {
  Future<Uint8List?> pickImageFromGallery({
    double maxWidth = 1920,
    double maxHeight = 1080,
    int imageQuality = 85,
  })

  Future<Uint8List?> pickImageFromCamera({
    double maxWidth = 1920,
    double maxHeight = 1080,
    int imageQuality = 85,
  })
}
```

### **Dialog de Seleção**
```
Usuário toca em "Selecionar Imagem"
         ↓
ImageSourcePickerDialog mostra 2 opções
         ↓
Usuário escolhe Galeria ou Câmera
         ↓
ImagePicker.pickImage() captura imagem
         ↓
Imagem redimensionada (max 1920x1080, 85% qualidade)
         ↓
Convertida para Uint8List com XFile.readAsBytes()
         ↓
Armazenada em UpsertPostStore.selectedImageBytes (MobX)
         ↓
Observer recompila DCCircularAvatar com novos bytes
```

---

## 💾 Persistência Local (Hive)

### **Configuração**
- **Post** é armazenado como `HiveObject` com typeId: 1
- Cache automático em `~/.hive_cache/posts.hive`
- Sincronização com backend ao iniciar app

### **Fluxo**
1. Fetch posts do backend via API
2. Salva em Hive local (cache persistente)
3. Carrega do Hive no próximo app launch (offline-first)
4. Sincroniza com backend (verifica updates com `shouldUpdate()`)

---

## 🌐 API Endpoints

### **Backend**: Node.js + MongoDB
**Repositório**: https://github.com/CarlosYanBezerraVieira/bd_dev_connect

### **Endpoints Implementados**

```
GET    /posts/getAll              # Buscar todos os posts
GET    /posts/:id                 # Buscar post específico
GET    /posts/shouldUpdate/:lastSync  # Verificar atualizações desde lastSync
POST   /posts                      # Criar novo post
PUT    /posts/:id                 # Atualizar post existente
DELETE /posts/:id                 # Deletar post
PATCH  /posts/:id/like            # Toggle like no post
```

### **Formato de Requisição**
```json
{
  "author": "João Silva",
  "authorImageBytes": "base64_encoded_image",
  "content": "Conteúdo do post",
}
```

### **Formato de Resposta**
```json
{
  "id": "507f1f77bcf86cd799439011",
  "author": "João Silva",
  "authorImageBytes": "base64_encoded_image",
  "content": "Conteúdo do post",
  "likes": 42,
  "isLiked": false,
  "createdAt": "2025-10-30T15:30:00Z",
  "updatedAt": "2025-10-30T15:30:00Z"
}
```

---

## 🔐 Segurança

- **Validação de Entrada**: `validatorless` package
- **Sanitização**: Inputs validados antes de enviar
- **Base64 para Imagens**: Evita paths de arquivo expostos

---

## 🧪 Validações

### **Formulários**
- **Autor**: Obrigatório, não vazio
- **Conteúdo**: Obrigatório, mínimo 5 caracteres
- **Imagem**: Opcional (fallback: ícone pessoa)

### **Datas**
- Formatação relativa automática: "há 5m", "há 3h", "30/10/2025"
- Classe: `DateFormatter` em `lib/core/formatters/date_formatter.dart`

---

## 📋 Convenções de Código

### **Linguagem & Nomes**
- **Código**: Inglês (classes, métodos, variáveis)
- **Comentários**: Português para clareza na avaliação
- **Commits**: Conventional Commits em inglês
  ```
  feat(feed): add post timestamp display
  fix(upsert): clear image after successful post
  refactor(core): extract date formatting logic
  ```

### **Padrão de Nomenclatura**
- Classes: `UpperCamelCase` (ex: `FeedController`, `PostModel`)
- Métodos/Variáveis: `lowerCamelCase` (ex: `fetchPosts()`, `selectedImageBytes`)
- Constantes: `camelCase` (ex: `primaryColor`, `maxImageWidth`)
- Privadas: prefixo `_` (ex: `_repository`, `_handlePickImage()`)
- Arquivos: `snake_case` (ex: `feed_page.dart`, `post_service.dart`)

### **Formatação**
- Automática: `dart format lib/` (aplicado pré-commit)
- Lints: `flutter_lints` + regras customizadas em `analysis_options.yaml`
- Build Runner: `flutter pub run build_runner build --delete-conflicting-outputs`

---

## 🚀 Como Executar

### **Pré-requisitos**
- Flutter 3.0+ (https://flutter.dev/docs/get-started/install)
- Dart 3.0+ (incluído no Flutter)
- Node.js (backend separado)

### **Setup Inicial**

```bash
# 1. Clone o repositório
git clone https://github.com/CarlosYanBezerraVieira/dev_connect.git
cd dev_connect

# 2. Instale dependências Flutter
flutter pub get

# 3. Configure variáveis de ambiente
# Crie arquivo .env na raiz do projeto:
# API_BASE_URL=http://localhost:3000

# 4. Regenere código gerado (MobX, JSON, etc)
flutter pub run build_runner build --delete-conflicting-outputs

# 5. Execute a app
flutter run

```

### **Variáveis de Ambiente (.env)**
```
# API base URL
API_BASE_URL=https://example.com/api

# Hive box name for posts
POSTS_BOX_NAME=posts

# Default credentials for login
DEFAULT_EMAIL=admin@admin.com
DEFAULT_PASSWORD=admin
---

## 🎯 Próximas Melhorias

- [ ] Testes unitários (unit tests)
- [ ] Testes de widget (widget tests)
- [ ] Testes de integração (integration tests)
- [ ] Autenticação com biometria (fingerprint, face)
- [ ] Compartilhamento de posts (share)
- [ ] Comentários em posts (nested replies)
- [ ] Sistema de mensagens diretas (DM)
- [ ] Notificações push (Firebase Cloud Messaging)
- [ ] Internacionalização (i18n) para múltiplos idiomas
- [ ] Upload de imagens para CDN (AWS S3, etc)
- [ ] Search e filtros avançados

---

## 📝 Licença

Este projeto é parte de uma avaliação técnica para **ESIG Group** (vaga Mobile Flutter).

---

## 👤 Autor

**Carlos Yan Bezerra Vieira**

Contato: [GitHub](https://github.com/CarlosYanBezerraVieira)

---

**Desenvolvido com ❤️ usando Flutter e Dart**

*Última atualização: 30/10/2025*
