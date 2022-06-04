import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HTTPService {
  /// シングルトンクラス
  static final instance = HTTPService._();

  HTTPService._();

  Future<http.Response?> get(
      {required String url, required String authorizationHeader}) async {
    try {
      final _response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
        },
      );

      switch (_response.statusCode) {
        case 200:
          return _response;
        default:
          throw Exception("Failed to get Album");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
