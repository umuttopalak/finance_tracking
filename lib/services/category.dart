import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> postCategory(BuildContext context, {required String name}) async {
  final url = Uri.parse('https://umuttopalak.pythonanywhere.com/categories/');
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode({'name': name});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 201 || response.statusCode == 200) {
    // showMessage(context, "Category Created Successfully");
  } else {
    // showMessage(context, "Failed To Create Category");
  }
}

Future<List<String>> getCategories(BuildContext context) async {
  final url = Uri.parse('https://umuttopalak.pythonanywhere.com/categories/');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> items = responseData['categories'];

    return items.map((item) => item['name'].toString()).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}

Future<List<Map<String, dynamic>>> getCategoriesData(
    BuildContext context) async {
  final url = Uri.parse('https://umuttopalak.pythonanywhere.com/categories/');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> items = responseData['categories'];

    return List<Map<String, dynamic>>.from(items);
  } else {
    throw Exception('Failed to load categories');
  }
}
