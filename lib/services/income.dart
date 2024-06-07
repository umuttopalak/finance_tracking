import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<String>> checkPayments(BuildContext context) async {
  final url =
      Uri.parse('https://umuttopalak.pythonanywhere.com/financial_items/');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    _showMessage(context, response.body);
    return data.map((item) => item['description'].toString()).toList();
  } else {
    throw Exception('Failed to load payments');
  }
}

void _showMessage(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payments'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
