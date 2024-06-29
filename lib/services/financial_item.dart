import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> addFinancialItem(BuildContext context,
    {required String name,
    required double amount,
    required String date,
    required String description,
    required String type,
    required String categoryId}) async {
  final url =
      Uri.parse('https://umuttopalak.pythonanywhere.com/financial_items/');
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({
    'name': name,
    'amount': amount,
    'date': date,
    'description': description,
    'category_id': categoryId,
    'type': type,
  });
  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    // showMessage(context, "Financial Item Added Successfully");
  } else {
    // showMessage(context, "Failed To Add Financial Item");
  }
}
