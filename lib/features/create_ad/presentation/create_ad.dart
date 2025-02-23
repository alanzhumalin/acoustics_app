import 'dart:io';

import 'package:acousticsapp/core/utils/phone_formatter.dart';
import 'package:acousticsapp/features/create_ad/presentation/select_brand.dart';
import 'package:acousticsapp/features/create_ad/presentation/select_category.dart';
import 'package:acousticsapp/features/create_ad/presentation/show_map.dart';
import 'package:acousticsapp/features/create_ad/presentation/show_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

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
  var location = LatLng(43.2452, 76.9345);
  final _key = GlobalKey<FormState>();
  String selectedBrand = '';
  String selectedCategory = '';
  String selectedCity = '';
  int? selectedState;

  bool isTitleError = false;
  bool isCategoryError = false;
  bool isBrandError = false;
  bool isStateError = false;
  bool isDescriptionError = false;
  bool isPriceError = false;
  bool isNameError = false;
  bool isPhoneError = false;

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
              pickedFileList.add(newFile);
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
    final colorOfText = Theme.of(context).textTheme.bodySmall!.color;
    final containerColor = Theme.of(context).colorScheme.primaryContainer;
    final backgroundcolor = Theme.of(context).colorScheme.secondaryContainer;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundcolor,
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
                      onTap: pickedFileList.isNotEmpty ? null : pickPhoto,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 30,
                            ),
                            width: double.infinity,
                            height: 228,
                            decoration: BoxDecoration(color: containerColor),
                            child: pickedFileList.isNotEmpty
                                ? Center(
                                    child: ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                              width: 10,
                                            ),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: pickedFileList.length,
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
                                                              removeFile(index);
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
                                                                                pickedFileList[index],
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
                                                  child: Image.file(
                                                    width: 100,
                                                    height: 100,
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
                      onChanged: (text) {
                        setState(() {
                          isTitleError = false;
                        });
                      },
                      controller: _titleController,
                      decoration: InputDecoration(
                          hintText: 'Например Fender Stratocaster',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          fillColor: containerColor,
                          filled: true,
                          focusedErrorBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          errorBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none)),
                      validator: (value) {
                        if (value == null || value.length < 10) {
                          setState(() {
                            isTitleError = true;
                          });
                          return null;
                        }

                        return null;
                      },
                    ),
                    if (isTitleError)
                      Row(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Название должно быть минимум 10 символов!',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      onChanged: (value) {
                        setState(() {
                          isCategoryError = false;
                        });
                      },
                      decoration: InputDecoration(
                        focusedErrorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        errorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
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
                          setState(() {
                            isCategoryError = true;
                          });
                          return null;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (isCategoryError)
                      Row(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Выберите категорию!',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                            onChanged: (value) {
                              setState(() {
                                isBrandError = false;
                              });
                            },
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
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
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
                                setState(() {
                                  isBrandError = true;
                                });
                                return null;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          if (isBrandError)
                            Row(
                              children: [
                                Icon(Icons.error, color: Colors.red, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  'Выберите категорию!',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Состояние',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.2,
                                backgroundColor: selectedState == 0
                                    ? Colors.blue
                                    : containerColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedState = 0;
                                  isStateError = false;
                                });
                              },
                              child: Text(
                                'Магазин',
                                style: TextStyle(
                                    color: selectedState == 0
                                        ? Colors.white
                                        : colorOfText,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.2,
                                  backgroundColor: selectedState == 1
                                      ? Colors.blue
                                      : containerColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedState = 1;
                                    isStateError = false;
                                  });
                                },
                                child: Text(
                                  'Новый',
                                  style: TextStyle(
                                      color: selectedState == 1
                                          ? Colors.white
                                          : colorOfText,
                                      fontWeight: FontWeight.bold),
                                ))),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.2,
                                  backgroundColor: selectedState == 2
                                      ? Colors.blue
                                      : containerColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedState = 2;
                                    isStateError = false;
                                  });
                                },
                                child: Text(
                                  'Б/у',
                                  style: TextStyle(
                                      color: selectedState == 2
                                          ? Colors.white
                                          : colorOfText,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (isStateError)
                      Row(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Выберите состояние товара!',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
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
                      onChanged: (value) {
                        setState(() {
                          isDescriptionError = false;
                        });
                      },
                      maxLines: 5,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText:
                            'Опишите товар, укажите его состояние и особенности',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        fillColor: containerColor,
                        filled: true,
                        focusedErrorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        errorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 20) {
                          setState(() {
                            isDescriptionError = true;
                          });
                          return null;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (isDescriptionError)
                      Row(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Описание должно быть не меньше 20 символов!',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      onChanged: (value) {
                        setState(() {
                          isPriceError = false;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Введите цену',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        fillColor: containerColor,
                        filled: true,
                        focusedErrorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        errorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          setState(() {
                            isPriceError = true;
                          });
                          return null;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (isPriceError)
                      Row(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Введите цену!',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      onChanged: (value) {
                        setState(() {
                          isNameError = false;
                        });
                      },
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Ваше имя',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        fillColor: containerColor,
                        filled: true,
                        focusedErrorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        errorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          setState(() {
                            isNameError = true;
                          });
                          return null;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (isNameError)
                      Row(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Введите имя!',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      onChanged: (value) {
                        setState(() {
                          isPhoneError = false;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: containerColor,
                        filled: true,
                        focusedErrorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        errorBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
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
                          setState(() {
                            isPhoneError = true;
                          });
                          return null;
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (isPhoneError)
                      Row(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Номер не корректный!',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            if (!isCategoryError &&
                                !isBrandError &&
                                !isDescriptionError &&
                                !isNameError &&
                                !isPhoneError &&
                                !isPriceError &&
                                !isStateError &&
                                !isTitleError &&
                                selectedState != null) {
                              debugPrint('good');
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text('го'),
                                    );
                                  });
                            } else {
                              setState(() {
                                isStateError = true;
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
