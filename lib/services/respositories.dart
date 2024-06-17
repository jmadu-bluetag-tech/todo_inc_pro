import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/task.dart';

class TodoRepository {
  Future<List<Task>> fetchTask() async {
    final url = 'https://api.nstack.in/v1/todos?page=1&limit=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // final json = jsonDecode(response.body) as Map;
      // final result = json['items'] as List;
      final List result = jsonDecode(response.body)['items'];
      return result.map(((json) => Task.fromJson(json))).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  // Function to create a new todo
  Future<Task> createTask(String title, String description) async {
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final body = {
      "title": title,
      "description": description,
    };

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> parsedResponse = jsonDecode(response.body);
      final Map<String, dynamic> todoData = parsedResponse['data'];
      return Task.fromJson(todoData);
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<Task> fetchTodoById(String id) async {
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Task.fromJson(json['data']);
    } else {
      throw Exception('Failed to load todo with ID: $id');
    }
  }
}
