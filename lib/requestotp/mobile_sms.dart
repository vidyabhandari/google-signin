import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:translife_google_signin/models/sql_result_model.dart';
import 'package:translife_google_signin/requestotp/otp_screen.dart';
import 'package:translife_google_signin/utils/api_result_dialog.dart';

class Mobilesms extends StatefulWidget {
  const Mobilesms({super.key});

  State<Mobilesms> createState() => _MobilesmsState();
}

class _MobilesmsState extends State<Mobilesms> {
  final List<TextEditingController> _digitControllers = List.generate(
    10,
    (_) => TextEditingController(),
  );

  String getFullMobileNumber() {
    return _digitControllers.map((c) => c.text).join();
  }

  String errorMessage = '';
  late SQLResultmodel sqlResultmodel;

  Future<void> sendOtp(String mobileNumber) async {
    const String apiUrl = 'https://api.translife.pro/api/common/SendOTPSMS';

    final payload = {
      "message": "751251",
      "recipientMobileNo": mobileNumber,
      "smsConfigId": 4,
      "smsPriority": 999,
      "templateId": "1707174184417984511",
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );
      
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        sqlResultmodel = SQLResultmodel.fromJson(jsonData);

        if (sqlResultmodel.errorNo == 0) {
          ApiResultDialog.showInfoDialog(
              context: context,
              title: 'Success',
              description: "OTP sent successfully",
          );

        } else {
          setState(() {
            ApiResultDialog.showErrorDialog(context: context, model: sqlResultmodel);
          });
        }
      } else {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                content: Text("HTTP error"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK"),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      setState(() {
        print("Error: $e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login with Mobile No.')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter Your Mobile Number: ",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(10, (index) {
                return SizedBox(
                  width: 35,
                  height: 50,
                  child: TextField(
                    controller: _digitControllers[index],
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 9) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final mobile = getFullMobileNumber();
                    if (mobile.length == 10) {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => otpScreen(sendOtp(mobile))),
                      );
                    } else {
                      setState(() {
                        errorMessage = 'Please enter a 10-digit mobile number';
                      });
                    }
                  },
                  child: Text("REQUEST OTP"),
                ),
                ElevatedButton(
                  onPressed: () {
                    for (var controller in _digitControllers) {
                      controller.clear();
                    }
                  },
                  child: Text("CANCEL"),
                ),
              ],
            ),

            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(errorMessage, style: TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
