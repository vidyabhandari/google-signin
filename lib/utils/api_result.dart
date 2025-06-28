import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:translife_google_signin/models/sql_result_model.dart';
import '../constants.dart';
import 'api_result_dialog.dart';

class ApiResult{
  final String apiUrl;
  ApiResult(this.apiUrl);

  get context => null;

  Future<SQLResultmodel?> sendApi(String mobileNumber) async{
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
        return SQLResultmodel.fromJson(jsonData);
      }
    } catch (e) {
      print("Error");
    }

    return null;
  }
}




