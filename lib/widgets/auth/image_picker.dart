import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  final void Function(File image) getImage;
  PickImage({required this.getImage});
  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? _imageFile;

  void pickImage() async {
    final picker = ImagePicker();
    final imagePath = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(imagePath!.path);
    });
    widget.getImage(_imageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: _imageFile == null
                ? Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    _imageFile!,
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Positioned(
          bottom: -10,
          right: -5,
          child: IconButton(
            onPressed: pickImage,
            icon: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
