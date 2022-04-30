import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput({required this.onSelectImage, Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final image =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (image == null) {
      return;
    }
    setState(() {
      _storedImage = File(image.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final savedImage = await _storedImage!.copy("${appDir.path}/$fileName");
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.grey),
              shape: BoxShape.circle),
          child: _storedImage != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _storedImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
              : const Text(
                  "No Image Taken",
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton.icon(
          onPressed: () {
            _takePicture();
          },
          icon: const Icon(Icons.camera_alt),
          label: const Text("Take Picture", textAlign: TextAlign.center),
        )
      ],
    );
  }
}
