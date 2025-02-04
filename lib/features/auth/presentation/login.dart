import 'package:acousticsapp/core/utils/phone_formatter.dart';
import 'package:acousticsapp/features/auth/presentation/sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
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
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.blue, width: 2)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.blue, width: 2)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      hintText: '+7 (___) ___ __ __',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null ||
                          !value
                              .replaceAll(RegExp(r'[+\(\)\s-]'), '')
                              .startsWith('77') ||
                          value.replaceAll(RegExp(r'[+\(\)\s-]'), '').length <=
                              10) {
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
                          child: Text(
                            'Принимая вы соглашаетесь с правилам',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
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
                                          number: _numberController.text
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
            )));
  }
}
