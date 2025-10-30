import 'package:dev_connect/core/di/service_locator.dart';
import 'package:dev_connect/core/ui/helpers/snackbar_helper.dart';
import 'package:dev_connect/features/upsert/controller/upsert_post_controller.dart';
import 'package:dev_connect/features/upsert/store/upsert_post_store.dart';
import 'package:dev_connect/models/post_model.dart';
import 'package:dev_connect/core/ui/components/dc_text_form_field.dart';
import 'package:dev_connect/core/ui/components/dc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

class UpsertPostPage extends StatefulWidget {
  const UpsertPostPage({super.key, this.postId});

  final String? postId;

  @override
  State<UpsertPostPage> createState() => _UpsertPostPageState();
}

class _UpsertPostPageState extends State<UpsertPostPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _authorImageController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  UpsertPostController get _controller => locator<UpsertPostController>();
  UpsertPostStore get _store => _controller.store;

  bool get _isEditing => (widget.postId != null && widget.postId!.isNotEmpty);

  ReactionDisposer? _errorDisposer;
  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _controller.loadForEdit(widget.postId!).then((_) {
        final Post? p = _store.currentPost;
        if (p != null) {
          _authorController.text = p.author;
          _authorImageController.text = p.authorImageBytes;
          _contentController.text = p.content;
        }
      });
    }
    _errorDisposer = reaction<String?>(
      (_) => _store.errorMessage,
      (String? msg) {
        if (msg != null && msg.isNotEmpty) {
          SnackBarHelper.showError(context, msg);
          _store.clearError();
        }
      },
    );
  }

  @override
  void dispose() {
    _authorController.dispose();
    _authorImageController.dispose();
    _contentController.dispose();
    _errorDisposer?.call();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final String id = _isEditing ? widget.postId! : "";

    final Post post = Post(
      id: id,
      author: _authorController.text.trim(),
      authorImageBytes: _authorImageController.text.trim(),
      content: _contentController.text.trim(),
      likes: _store.currentPost?.likes ?? 0,
      isLiked: _store.currentPost?.isLiked ?? false,
    );
    await _controller.upsertPost(post);

    if (mounted) {
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = _isEditing ? 'Editar Post' : 'Novo Post';
    final String buttonText = _isEditing ? 'Atualizar' : 'Publicar';
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Observer(builder: (_) {
          if (_store.loading && _isEditing) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DCTextFormField(
                    controller: _authorImageController,
                    label: 'URL da imagem do autor (opcional)',
                    keyboardType: TextInputType.url,
                    validator: (String? value) {
                      final String v = value?.trim() ?? '';
                      if (v.isEmpty) return null;
                      final Uri? uri = Uri.tryParse(v);
                      if (uri == null || !uri.hasScheme) {
                        return 'URL inválida';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  DCTextFormField(
                    controller: _authorController,
                    label: 'Autor',
                    validator: Validatorless.required('Informe o autor'),
                  ),
                  const SizedBox(height: 12),
                  DCTextFormField(
                    controller: _contentController,
                    label: 'Conteúdo',
                    minLines: 5,
                    maxLines: 10,
                    validator:
                        Validatorless.multiple(<FormFieldValidator<String>>[
                      Validatorless.required('Informe o conteúdo'),
                      Validatorless.min(5, 'Mínimo de 5 caracteres'),
                    ]),
                  ),
                  const SizedBox(height: 24),
                  Observer(builder: (_) {
                    return DCButton(
                      onPressed: _submit,
                      label: buttonText,
                      loading: _store.submitting,
                      icon: _isEditing ? Icons.save : Icons.send,
                    );
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
