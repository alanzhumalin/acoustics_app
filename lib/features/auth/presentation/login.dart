import 'package:acousticsapp/core/utils/phone_formatter.dart';
import 'package:acousticsapp/features/auth/presentation/rules.dart';
import 'package:acousticsapp/features/auth/presentation/sms.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _numberController = TextEditingController();
  var isChecked = false;
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _numberController.dispose();
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(bytes, filePicker: (files) {
      return files.firstWhere(
          (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorOfText = Theme.of(context).textTheme.bodySmall!.color;
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.2,
              child: Lottie.asset(
                  width: size.width,
                  height: size.height,
                  decoder: customDecoder,
                  'assets/animation/main.lottie'),
            )),
        Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Здравствуйте! Введите свой номер телефона для входа',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextFormField(
                    inputFormatters: [
                      maskFormatter,
                    ],
                    cursorErrorColor: Colors.blue,
                    cursorColor: Colors.blue,
                    autofocus: true,
                    controller: _numberController,
                    decoration: InputDecoration(
                      prefix: Text(
                        '+7 ',
                        style: TextStyle(
                            color: colorOfText, fontWeight: FontWeight.w500),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.blue, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.blue, width: 2)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      hintText: '(700) 700 00 00',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null ||
                          !value
                              .replaceAll(RegExp(r'[+\(\)\s-]'), '')
                              .startsWith('7') ||
                          value.replaceAll(RegExp(r'[+\(\)\s-]'), '').length <=
                              9) {
                        return 'Номер не корректный';
                      }

                      if (isChecked == false) {
                        return 'Подтвердите соглашение';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Checkbox(
                            activeColor: Colors.blue,
                            value: (isChecked),
                            onChanged: (onChanged) {
                              setState(() {
                                isChecked = onChanged!;
                              });
                            }),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Rules()));
                            },
                            child: Text(
                              'Принимая вы соглашаетесь с правилам',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                        )
                      ],
                    ),
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
                          if (_key.currentState!.validate() &&
                              isChecked == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Sms(
                                          number: '+7${_numberController.text}'
                                              .replaceAll(
                                                  RegExp(r'[(\)\s-]'), ''),
                                        )));
                          }
                        },
                        child: Text(
                          'Далее',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        )),
                  )
                ],
              ),
            )),
      ],
    ));
  }
}
