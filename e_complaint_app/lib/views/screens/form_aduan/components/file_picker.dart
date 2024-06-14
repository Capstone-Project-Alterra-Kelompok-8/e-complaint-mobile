// file_picker.dart
import 'package:flutter/material.dart';
import 'dart:io';

class FilePickerWidget extends StatelessWidget {
  final List<String?> selectedImagePaths;
  final Function(int) onPickFile;

  const FilePickerWidget({
    Key? key,
    required this.selectedImagePaths,
    required this.onPickFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Dokumentasi',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(selectedImagePaths.length + 1, (index) {
            if (selectedImagePaths.length == 3 &&
                index == selectedImagePaths.length) {
              return SizedBox.shrink();
            }
            return GestureDetector(
              onTap: () => onPickFile(index),
              child: Container(
                width: 115,
                height: 115,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: selectedImagePaths.length > index &&
                          selectedImagePaths[index] != null
                      ? Image.file(
                          File(selectedImagePaths[index]!),
                          fit: BoxFit.cover,
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.image,
                              size: 30,
                            ),
                            SizedBox(height: 10),
                            Text("Tambah Foto"),
                          ],
                        ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
