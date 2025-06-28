import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:translife_google_signin/constants.dart';
import 'package:translife_google_signin/models/sql_result_model.dart';
import 'package:translife_google_signin/requestotp/otp_screen.dart';
import 'package:translife_google_signin/utils/api_result_dialog.dart';
import '../utils/api_result.dart';

class Mobilesms extends StatefulWidget {
  const Mobilesms({super.key});

  @override
  State<Mobilesms> createState() => _MobilesmsState();
}

class _MobilesmsState extends State<Mobilesms> {
  final List<TextEditingController> _digitControllers = List.generate(
    10,
        (_) => TextEditingController(),
  );

  String errorMessage = '';
  final apiResult = ApiResult('${apiUrl}/common/SendOTPSMS');

  String getFullMobileNumber() {
    return _digitControllers.map((c) => c.text).join();
  }

  Future<void> handleOtp() async {
    final mobile = getFullMobileNumber();

    if (mobile.length != 10) {
      setState(() {
        errorMessage = "Please enter a 10-digit number";
      });
      return;
    }

    final SQLResultmodel? sqlResultmodel = await apiResult.sendApi(mobile);

    if (sqlResultmodel?.errorNo == 0) {
    await showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Success'),
      content: Text('OTP sent successfully to $mobile'),
      actions: [
        TextButton(
          onPressed:
              ()=>Navigator.of(context).pop(),
          child: const Text('ok'),),
      ],
    ));
    // ApiResultDialog.showInfoDialog(
    //     context: context,
    //     title: 'Success',
    //     description: 'OTP sent successfully to $mobile',
    //   );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(mobile: mobile),
        ),
      );
    } else if (sqlResultmodel != null) {
      ApiResultDialog.showErrorDialog(context: context, model: sqlResultmodel);
    } else {
      ApiResultDialog.showErrorDialog(
          context: context,
          model: SQLResultmodel(id: 0,
          errorNo: 1,
          sqlErrorNumber: 0,
          sqlErrorSeverity: 0,
          sqlErrorState: 0,
          sqlErrorLineNo: 0,
          errorMessage: "Unknown error",
          sqlObjectName: "",
          sqlErrorMessage: "Null model returned from server",
      ),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login with Mobile No.')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter Your Mobile Number: ",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 15),
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
                    decoration: const InputDecoration(
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: handleOtp,
                  child: const Text("REQUEST OTP"),
                ),
                ElevatedButton(
                  onPressed: () {
                    for (var controller in _digitControllers) {
                      controller.clear();
                    }
                  },
                  child: const Text("CANCEL"),
                ),
              ],
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(errorMessage, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
