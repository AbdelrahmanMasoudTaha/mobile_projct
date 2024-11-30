import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImg extends StatefulWidget {
  const UserImg({super.key, required this.onPickeImage});
  final void Function(File pickedImg) onPickeImage;

  @override
  State<UserImg> createState() => _UserImgState();
}

class _UserImgState extends State<UserImg> {
  File? _pickedImageFile;

  void _pickImage() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 150, imageQuality: 50);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickeImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImageFile == null ? null : FileImage(_pickedImageFile!),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          label: Text(
            'Add Image',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          icon: Icon(
            Icons.image,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }
}
