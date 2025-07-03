import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String _baseUrl = "https://api.example.com";

  // GET request with loading
  Future<http.Response> get(BuildContext context, String endpoint, {Map<String, String>? headers}) async {
    _showLoader(context);
    try {
      final response = await http.get(Uri.parse("$_baseUrl$endpoint"), headers: headers);
      _handleResponse(response);
      return response;
    } finally {
      _hideLoader(context);
    }
  }

  // POST request with loading
  Future<http.Response> post(BuildContext context, String endpoint, Map<String, dynamic> data, {Map<String, String>? headers}) async {
    _showLoader(context);
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl$endpoint"),
        headers: _jsonHeaders(headers),
        body: jsonEncode(data),
      );
      _handleResponse(response);
      return response;
    } finally {
      _hideLoader(context);
    }
  }

  // PUT request with loading
  Future<http.Response> put(BuildContext context, String endpoint, Map<String, dynamic> data, {Map<String, String>? headers}) async {
    _showLoader(context);
    try {
      final response = await http.put(
        Uri.parse("$_baseUrl$endpoint"),
        headers: _jsonHeaders(headers),
        body: jsonEncode(data),
      );
      _handleResponse(response);
      return response;
    } finally {
      _hideLoader(context);
    }
  }

  // DELETE request with loading
  Future<http.Response> delete(BuildContext context, String endpoint, {Map<String, String>? headers}) async {
    _showLoader(context);
    try {
      final response = await http.delete(Uri.parse("$_baseUrl$endpoint"), headers: headers);
      _handleResponse(response);
      return response;
    } finally {
      _hideLoader(context);
    }
  }

  // Multipart file upload with loading
  Future<http.StreamedResponse> uploadFile({
    required BuildContext context,
    required String endpoint,
    required File file,
    String fieldName = 'file',
    Map<String, String>? fields,
    Map<String, String>? headers,
  }) async {
    _showLoader(context);
    try {
      final uri = Uri.parse("$_baseUrl$endpoint");
      final request = http.MultipartRequest('POST', uri);

      if (headers != null) request.headers.addAll(headers);
      if (fields != null) request.fields.addAll(fields);
      request.files.add(await http.MultipartFile.fromPath(fieldName, file.path));

      final response = await request.send();
      return response;
    } finally {
      _hideLoader(context);
    }
  }

  // Helper to return JSON headers
  Map<String, String> _jsonHeaders(Map<String, String>? customHeaders) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      ...?customHeaders,
    };
  }

  // Handle API errors
  void _handleResponse(http.Response response) {
    if (response.statusCode >= 400) {
      throw HttpException(
        'Error ${response.statusCode}: ${response.reasonPhrase}',
        uri: response.request?.url,
      );
    }
  }

  // Show loading dialog
  void _showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Container(
        height:100,
        width:100,
        color:Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  // Hide loading dialog
  void _hideLoader(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
