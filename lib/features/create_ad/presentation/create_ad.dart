import 'dart:io';

import 'package:acousticsapp/core/utils/phone_formatter.dart';
import 'package:acousticsapp/features/create_ad/presentation/select_brand.dart';
import 'package:acousticsapp/features/create_ad/presentation/select_category.dart';
import 'package:acousticsapp/features/create_ad/presentation/show_map.dart';
import 'package:acousticsapp/features/create_ad/presentation/show_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateAd extends StatefulWidget {
  const CreateAd({super.key});

  @override
  State<CreateAd> createState() => _CreateAdState();
}

class _CreateAdState extends State<CreateAd> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> pickedFileList = <XFile>[];

  final _key = GlobalKey<FormState>();
  String selectedBrand = '';
  String selectedCategory = '';
  String selectedCity = '';
  Future<void> pickPhoto() async {
    final List<XFile>? pickedFile = await imagePicker.pickMultiImage(
      imageQuality: 80,
    );

    if (pickedFile != null && pickedFile.isNotEmpty) {
      for (var file in pickedFile) {
        File imageFile = File(file.path);
        final decodedImage =
            await decodeImageFromList(imageFile.readAsBytesSync());

        if (decodedImage.width > 0 && decodedImage.height > 0) {
          setState(() {
            pickedFileList.add(file);
          });
        } else {
          debugPrint("Некорректное фото: ${file.path}");
        }
      }
    }
  }

  Future<void> selectCategory() async {
    final result = await Navigator.push<String>(
        context, MaterialPageRoute(builder: (context) => SelectCategory()));

    if (result != null && result.isNotEmpty) {
      setState(() {
        selectedCategory = result;
        selectedBrand = '';
      });
    }
  }

  Future<void> selectBrand() async {
    final result = await Navigator.push<String>(
        context, MaterialPageRoute(builder: (context) => SelectBrand()));

    if (result != null && result.isNotEmpty) {
      setState(() {
        selectedBrand = result;
      });
    }
  }

  void removeFile(int index) {
    setState(() {
      pickedFileList.removeAt(index);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _nameController.dispose();
    _descriptionController.dispose();
    _phoneController.dispose();
    _priceController.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme.bodyLarge!.color;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(
            'Создать обьявления',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: pickedFileList.isNotEmpty ? null : pickPhoto,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            width: double.infinity,
                            height: 228,
                            decoration: BoxDecoration(
                                color:
                                    const Color.fromARGB(255, 129, 129, 129)),
                            child: pickedFileList.isNotEmpty
                                ? Center(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: pickedFileList.length,
                                        itemBuilder: (context, index) {
                                          final num = index + 1;
                                          return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ShowPhoto(
                                                              file:
                                                                  pickedFileList[
                                                                      index],
                                                            )));
                                              },
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Image.file(
                                                    File(pickedFileList[index]
                                                        .path),
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Icon(
                                                          Icons.broken_image,
                                                          size: 50,
                                                          color: Colors.red);
                                                    },
                                                  ),
                                                  Positioned(
                                                    bottom: -10,
                                                    left: 0,
                                                    right: 0,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        removeFile(index);
                                                      },
                                                      icon: const Icon(
                                                        CupertinoIcons.delete,
                                                        size: 20,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 2,
                                                    top: -2,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.black,
                                                      ),
                                                      child: Text(
                                                        num.toString(),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        }),
                                  )
                                : Center(
                                    child: Text(
                                      'Выберите фото',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          )),
                    ),
                    if (pickedFileList.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Align(
                          alignment: Alignment.center,
                          child: TextButton(
                              onPressed: pickPhoto,
                              child: Text(
                                'Добавить фото',
                                style: TextStyle(
                                    color: theme,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                        ),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Название обьявление',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorErrorColor: Colors.blue,
                      cursorColor: Colors.blue,
                      maxLength: 40,
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Например Fender Stratocaster',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 10) {
                          return 'Название должно быть минимум 10 символов';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Категория',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      onTap: selectCategory,
                      decoration: InputDecoration(
                        suffixIcon: selectedCategory.isNotEmpty
                            ? TextButton(
                                onPressed: selectCategory,
                                child: const Text(
                                  'Изменить',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Colors.blue,
                                  ),
                                ),
                              )
                            : const Icon(Icons.arrow_drop_down_outlined),
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyLarge!.color),
                        hintText: selectedCategory.isNotEmpty
                            ? selectedCategory
                            : 'Выберите категорию',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (selectedCategory.isEmpty) {
                          return 'Выберите категорию';
                        }
                        return null;
                      },
                    ),
                    if (selectedCategory.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Бренд',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            readOnly: true,
                            onTap: selectBrand,
                            decoration: InputDecoration(
                              suffixIcon: selectedBrand.isNotEmpty
                                  ? TextButton(
                                      onPressed: selectBrand,
                                      child: const Text(
                                        'Изменить',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    )
                                  : const Icon(Icons.arrow_drop_down_outlined),
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color),
                              hintText: selectedBrand.isNotEmpty
                                  ? selectedBrand
                                  : 'Выберите бренд',
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (selectedBrand.isEmpty) {
                                return 'Выберите бренд';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Описание',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorErrorColor: Colors.blue,
                      cursorColor: Colors.blue,
                      maxLength: 200,
                      maxLines: 5,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText:
                            'Опишите товар, укажите его состояние и особенности',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 20) {
                          return 'Описание должно быть минимум 20 символов';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Цена',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorErrorColor: Colors.blue,
                      cursorColor: Colors.blue,
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Введите цену',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите цену';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Местоположение',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(14)),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(CupertinoIcons.location_solid),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      selectedCity.isEmpty
                                          ? 'Ваше местоположение'
                                          : selectedCity,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ShowMap()));
                                    },
                                    child: Text(
                                      'Выбрать',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: theme),
                                    ))
                              ]),
                          SizedBox(
                            height: 200,
                            child: FlutterMap(
                              options: MapOptions(
                                initialCenter: LatLng(43.2452,
                                    76.9345), // Center the map over London
                                initialZoom: 9.2,
                              ),
                              children: [
                                TileLayer(
                                  // Bring your own tiles
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
                                  userAgentPackageName:
                                      'com.example.app', // Add your app identifier
                                  // And many more recommended properties!
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Ваше имя',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorErrorColor: Colors.blue,
                      cursorColor: Colors.blue,
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Ваше имя',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return 'Введите ваше имя';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Номер телефона',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      inputFormatters: [
                        maskFormatter,
                      ],
                      controller: _phoneController,
                      cursorErrorColor: Colors.blue,
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: '+7 (___) ___ __ __',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value
                                    .replaceAll(RegExp(r'[+\(\)\s-]'), '')
                                    .length <=
                                10) {
                          return 'Номер не корректный';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0.2,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              debugPrint('good');
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text('го'),
                                    );
                                  });
                            }
                          },
                          child: Text(
                            'Опубликовать',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
