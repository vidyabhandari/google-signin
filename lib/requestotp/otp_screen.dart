import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class otpScreen extends StatefulWidget {
  const otpScreen(Future<void> sendOtp, {super.key});

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  final List<TextEditingController> _otpDigitControllers = List.generate(6, (_) => TextEditingController(),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter the 6-Digits OTP',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 35,
                  height: 50,
                  child: TextField(
                    controller: _otpDigitControllers[index],
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
          ],
        ),
        ),
    );
  }
}


