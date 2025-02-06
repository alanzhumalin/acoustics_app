import 'package:acousticsapp/core/utils/phone_formatter.dart';
import 'package:acousticsapp/features/create_ad/presentation/select_brand.dart';
import 'package:acousticsapp/features/create_ad/presentation/select_category.dart';
import 'package:flutter/material.dart';

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
  final _key = GlobalKey<FormState>();
  bool isSelectedCategory = false;
  bool isSelectedBrand = false;
  String selectedBrand = '';
  String selectedCategory = '';

  Future<void> selectCategory() async {
    final result = await Navigator.push<String>(
        context, MaterialPageRoute(builder: (context) => SelectCategory()));

    if (result != null && result.isNotEmpty) {
      setState(() {
        isSelectedCategory = true;
        selectedCategory = result;
        isSelectedBrand = false;
        selectedBrand = '';
      });
    }
  }

  Future<void> selectBrand() async {
    final result = await Navigator.push<String>(
        context, MaterialPageRoute(builder: (context) => SelectBrand()));

    if (result != null && result.isNotEmpty) {
      setState(() {
        isSelectedBrand = true;
        selectedBrand = result;
      });
    }
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.23,
                        padding: EdgeInsets.symmetric(vertical: 70),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 129, 129, 129)),
                        child: Center(
                          child: Text(
                            'Выберите фото',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
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
                    // DropdownMenu(
                    //     width: double.infinity,
                    //     hintText: 'Выберите категорию',
                    //     dropdownMenuEntries: []),
                    TextFormField(
                      readOnly: true,
                      onTap: selectCategory,
                      decoration: InputDecoration(
                        suffixIcon: isSelectedCategory
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
                        hintText: isSelectedCategory
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
                        if (!isSelectedCategory) {
                          return 'Выберите категорию';
                        }
                        return null;
                      },
                    ),

                    if (isSelectedCategory)
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
                              suffixIcon: isSelectedBrand
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
                              hintText: isSelectedBrand
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
                              if (!isSelectedBrand) {
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
                        hintText: 'Ваше имя или псевдоним',
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
