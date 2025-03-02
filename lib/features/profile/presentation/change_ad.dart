import 'dart:io';

import 'package:acousticsapp/core/utils/phone_formatter.dart';
import 'package:acousticsapp/features/ads/data/ad_model.dart';
import 'package:acousticsapp/features/create_ad/presentation/select_brand.dart';
import 'package:acousticsapp/features/create_ad/presentation/select_category.dart';
import 'package:acousticsapp/features/create_ad/presentation/show_map.dart';
import 'package:acousticsapp/features/create_ad/presentation/show_photo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class ChangeAd extends StatefulWidget {
  const ChangeAd({super.key, required this.ad});
  final AdModel ad;
  @override
  State<ChangeAd> createState() => _ChangeAdState();
}

class _ChangeAdState extends State<ChangeAd> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  final ImagePicker imagePicker = ImagePicker();
  late List<dynamic> images;
  late LatLng location;
  final _key = GlobalKey<FormState>();
  List<String> removedImages = [];
  late String selectedBrand;
  late String selectedCategory;
  late String selectedCity;
  Future<XFile?> _cropImage(XFile file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Редактировать',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        IOSUiSettings(
          title: 'Редактировать',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
          size: const CropperSize(
            width: 520,
            height: 520,
          ),
        ),
      ],
    );
    if (croppedFile != null) {
      return XFile(croppedFile.path);
    }
  }

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
          final newFile = await _cropImage(file);
          if (newFile != null) {
            setState(() {
              images.add(newFile);
            });
          }
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

  void removeImage(int index) {
    setState(() {
      final item = images[index];
      if (item is String) {
        removedImages.add(item);
      }
      images.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController(text: widget.ad.title);
    _descriptionController = TextEditingController(text: widget.ad.description);
    _priceController = TextEditingController(
      text: widget.ad.price,
    );
    _nameController = TextEditingController(text: widget.ad.nameOfCustomer);
    _phoneController = TextEditingController();
    images = List.from(widget.ad.adImages);
    location = LatLng(
        double.parse(widget.ad.latLng[0]), double.parse(widget.ad.latLng[1]));
    selectedBrand = widget.ad.categorySelection.brand;
    selectedCategory = widget.ad.categorySelection.category;
    selectedCity = widget.ad.city;
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
    final colorOfText = Theme.of(context).textTheme.bodySmall!.color;
    final containerColor = Theme.of(context).colorScheme.onSecondary;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(
            'Создать объявление',
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
                      onTap: images.isNotEmpty ? null : pickPhoto,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 30,
                            ),
                            width: double.infinity,
                            height: 228,
                            decoration: BoxDecoration(color: containerColor),
                            child: images.isNotEmpty
                                ? Center(
                                    child: ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 10,
                                            ),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: images.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              onTap: () {
                                                showCupertinoModalPopup(
                                                    context: context,
                                                    builder: (context) {
                                                      return CupertinoActionSheet(
                                                        actions: [
                                                          CupertinoActionSheetAction(
                                                            onPressed: () {
                                                              removeImage(
                                                                  index);
                                                              if (context
                                                                  .mounted) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            child: Text(
                                                              'Удалить фото',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ),
                                                          CupertinoActionSheetAction(
                                                            onPressed:
                                                                () async {
                                                              await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => ShowPhoto(
                                                                            index:
                                                                                index,
                                                                            file:
                                                                                images[index],
                                                                          )));
                                                              if (context
                                                                  .mounted) {
                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            },
                                                            child: Text(
                                                              'Посмотреть фото',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue),
                                                            ),
                                                          ),
                                                        ],
                                                        cancelButton:
                                                            CupertinoActionSheetAction(
                                                          isDefaultAction: true,
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  null),
                                                          child: const Text(
                                                              'Отмена',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blue)),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Center(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: images[index] is String
                                                      ? Container(
                                                          color: Colors.white,
                                                          child:
                                                              CachedNetworkImage(
                                                                  imageUrl:
                                                                      images[
                                                                          index],
                                                                  width: 100,
                                                                  height: 100,
                                                                  fit: BoxFit
                                                                      .cover),
                                                        )
                                                      : Container(
                                                          color: Colors.white,
                                                          child: Image.file(
                                                            File((images[index]
                                                                    as XFile)
                                                                .path),
                                                            width: 100,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return const Icon(
                                                                  Icons
                                                                      .broken_image,
                                                                  size: 50,
                                                                  color: Colors
                                                                      .red);
                                                            },
                                                          ),
                                                        ),
                                                ),
                                              ));
                                        }),
                                  )
                                : Center(
                                    child: Text(
                                      'Выберите фото',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorOfText,
                                          fontSize: 16),
                                    ),
                                  ),
                          )),
                    ),
                    if (images.isNotEmpty)
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          fillColor: containerColor,
                          filled: true,
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none)),
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
                            : const Icon(CupertinoIcons.arrow_down),
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyLarge!.color),
                        hintText: selectedCategory.isNotEmpty
                            ? selectedCategory
                            : 'Выберите категорию',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        fillColor: containerColor,
                        filled: true,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
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
                                  : const Icon(CupertinoIcons.arrow_down),
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color),
                              hintText: selectedBrand.isNotEmpty
                                  ? selectedBrand
                                  : 'Выберите бренд',
                              fillColor: containerColor,
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none),
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
                        fillColor: containerColor,
                        filled: true,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
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
                        fillColor: containerColor,
                        filled: true,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
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
                      padding: EdgeInsets.only(
                        right: 10,
                        left: 10,
                      ),
                      width: double.infinity,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
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
                                          fontSize: 14,
                                          color: theme),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final result = await Navigator.push<
                                        Map<String, dynamic>>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShowMap(),
                                      ),
                                    );

                                    if (result != null) {
                                      setState(() {
                                        selectedCity = result['text'];
                                        final LatLng? locationNew =
                                            result['location'];

                                        if (locationNew != null) {
                                          print(locationNew.latitude);
                                          print(locationNew.longitude);
                                          setState(() {
                                            location = locationNew;
                                          });
                                        }
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Выбрать',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: theme,
                                    ),
                                  ),
                                )
                              ]),
                          SizedBox(
                            height: 200,
                            child: MapLibreMap(
                              key: ValueKey(location),
                              styleString:
                                  "https://api.maptiler.com/maps/76d584d7-2bab-4f56-b07e-b6952e99aa18/style.json?key=BXjwwWbXqov08uZ68gVt",
                              initialCameraPosition: CameraPosition(
                                target: location,
                                zoom: 9.2,
                              ),
                              rotateGesturesEnabled: false,
                              compassEnabled: false,
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
                        fillColor: containerColor,
                        filled: true,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
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
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      autofocus: false,
                      decoration: InputDecoration(
                        fillColor: containerColor,
                        filled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 18, top: 1),
                          child: Text(
                            '+7 ',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                        hintText: '(700) 700 00 00',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value == null ||
                            !value
                                .replaceAll(RegExp(r'[+\(\)\s-]'), '')
                                .startsWith('7') ||
                            value
                                    .replaceAll(RegExp(r'[+\(\)\s-]'), '')
                                    .length <=
                                9) {
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
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
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
                            'Сохранить',
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
