import 'dart:async';

import 'package:acousticsapp/home.dart';
import 'package:acousticsapp/shared/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class Sms extends StatefulWidget {
  const Sms({super.key, required this.number});
  final String number;

  @override
  State<Sms> createState() => _SmsState();
}

class _SmsState extends State<Sms> {
  final TextEditingController _codeController = TextEditingController();
  final _key = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();

  bool isLoading = false;
  int _secondsRemaining = 30;
  late Timer _timer;
  bool _isResendButtonVisible = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(bytes, filePicker: (files) {
      return files.firstWhere(
          (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
    });
  }

  void _startTimer() {
    _secondsRemaining = 30;
    _isResendButtonVisible = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isResendButtonVisible = true;
          timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 95, 171, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(0, 123, 255, 1);
    final size = MediaQuery.of(context).size;
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.orange,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor, width: 2),
      ),
    );

    final errorPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.red,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor, width: 2),
      ),
    );

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
                    'Введите код отправленный на номер ${widget.number}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const SizedBox(height: 20),
                  Pinput(
                      controller: _codeController,
                      autofocus: true,
                      focusNode: focusNode,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) async {
                        if (_key.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await Future.delayed(const Duration(seconds: 2));
                          setState(() {
                            isLoading = false;
                          });
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                              (Route<dynamic> route) => false,
                            );
                          }
                        }
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 2,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: focusedBorderColor, width: 2),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(19),
                          border:
                              Border.all(color: focusedBorderColor, width: 2),
                        ),
                      ),
                      errorPinTheme: errorPinTheme),
                  const SizedBox(height: 13),
                  isLoading
                      ? Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Loader()
                          ],
                        )
                      : _isResendButtonVisible
                          ? TextButton(
                              onPressed: () {
                                _startTimer();
                              },
                              child: const Text(
                                'Отправить заново',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  'Отправить заново через $_secondsRemaining сек.',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 60,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ],
      ),
    );
  }
}
