import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_system/components/pickImage.dart';

import '../constants.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker(
      {super.key,required this.onPress});

  final VoidCallback onPress;

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}
class _ProfileImagePickerState extends State<ProfileImagePicker> {
  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Stack(
        children: [
          _image != null ?
          CircleAvatar(
            minRadius: 50.0,
            maxRadius: 50.0,
            backgroundImage: MemoryImage(_image!),
          )
              :
          const CircleAvatar(
            minRadius: 50.0,
            maxRadius: 50.0,
            backgroundColor: kSecondaryColor,
            //backgroundImage: AssetImage(picAddress),
            backgroundImage: NetworkImage(
                'https://cdn.iconscout.com/icon/free/png-256/free-avatar-370-456322.png?f=webp'),
          ),
          Positioned(
            bottom: -10,
            left: 60,
            child: IconButton(
              onPressed: selectImage,
              icon: const Icon(Icons.add_a_photo_outlined),
            ),
          )
        ],
      ),
    );
  }
}