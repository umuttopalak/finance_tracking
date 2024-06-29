// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<String>> checkPayments(BuildContext context, {String? type}) async {
  final url = Uri.parse('https://umuttopalak.pythonanywhere.com/financial_items/');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // _showMessage(context, response.body);
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> items = responseData['items'];
    
    final List<dynamic> filteredItems = type != null 
        ? items.where((item) => item['type'] == type).toList() 
        : items;

    return filteredItems.map((item) => item['description'].toString()).toList();
  } else {
    throw Exception('Failed to load payments');
  }
}
