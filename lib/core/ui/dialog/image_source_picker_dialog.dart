import 'package:flutter/material.dart';

class ImageSourcePickerDialog extends StatelessWidget {
  const ImageSourcePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecionar Imagem'),
      content: const Text('Escolha de onde deseja selecionar a imagem:'),
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
          icon: const Icon(Icons.photo_library),
          label: const Text('Galeria'),
        ),
        TextButton.icon(
          onPressed: () => Navigator.pop(context, ImageSource.camera),
          icon: const Icon(Icons.camera_alt),
          label: const Text('Câmera'),
        ),
      ],
    );
  }
}

enum ImageSource { gallery, camera }
