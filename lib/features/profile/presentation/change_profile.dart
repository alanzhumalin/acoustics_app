import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final TextEditingController _nameController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  XFile? image;

  Future<void> pickPhoto() async {
    final photo = await imagePicker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        image = photo;
      });
    }
    Navigator.pop(context);
  }

  Future<void> pickImage() async {
    final photo = await imagePicker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        image = photo;
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final containerColor = Theme.of(context).colorScheme.primaryContainer;
    final backgroundcolor = Theme.of(context).colorScheme.secondaryContainer;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundcolor,
        appBar: AppBar(
          title: Text(
            'Ваши данные',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          forceMaterialTransparency: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Center(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            image != null ? FileImage(File(image!.path)) : null,
                        child: image == null
                            ? Icon(Icons.person, size: 80, color: Colors.grey)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: backgroundcolor,
                                      title: Text(
                                        'Выберите одну опцию',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            leading: Icon(
                                              Icons.camera,
                                              color: Colors.blue,
                                              size: 23,
                                            ),
                                            title: Text(
                                              'Камера',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            onTap: pickPhoto,
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.image,
                                              color: Colors.blue,
                                              size: 23,
                                            ),
                                            title: Text(
                                              'Галерея',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            onTap: pickImage,
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(Icons.add_a_photo_outlined,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autocorrect: false,
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Напишите корректно';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: containerColor,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      hintText: 'Новое имя',
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.2,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          'Подтвердить',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
