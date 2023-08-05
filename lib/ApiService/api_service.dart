import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:dio/adapter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class URLS {

  static const String adBaseUrl = "https://test1.elred.io";

  static const String postUserInformation = "$adBaseUrl/postUserInformation";

}

class ApiService {
  static final ApiService _api = ApiService._internal();

  factory ApiService() {
    return _api;
  }

  ApiService._internal();

  static Future postApiCallArgs({required String url, var apiRequest}) async {
    var client = http.Client();
    try {
      print("called ----->  $url");
      debugPrint("apiRequest  $apiRequest");

      final uriResponse = await client.post(Uri.parse(url),
          body: json.encode(apiRequest),headers: {'Content-type': 'application/json'});

      debugPrint("apiStatusCode  ${uriResponse.statusCode}");

      if (uriResponse.statusCode == 200) {
        debugPrint("apiResponse : ${jsonDecode(uriResponse.body)}");
        return jsonDecode(uriResponse.body);
      } else if (uriResponse.statusCode == 400) {
        // showToast("${jsonDecode(uriResponse.body)["message"]}");
        return null;
      } else {
        // showToast("Something went wrong");
        return null;
      }
    } catch (e) {
      if (e is SocketException) {
        //showToast("please check your internet connection");
      } else if (e is TimeoutException) {
        //showToast("Timeout exception: ${e.toString()}");
      }
      return null;
    }
  }

  static Future getApiCallDio({required String url}) async {

    if(!kIsWeb) {
      (dio.Dio().httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    try {
      //debugPrint("called ----->  $url");

      var uriResponse = await dio.Dio()
          .get(url)
          .timeout(const Duration(seconds: 15));

      //debugPrint("apiStatusCode  ${uriResponse.statusCode}");

      if (uriResponse.statusCode == 200) {
        //debugPrint("apiResponse : ${uriResponse.data}");
        return uriResponse.data;
      } else if (uriResponse.statusCode == 400) {
        // showToast("${jsonDecode(uriResponse.body)["message"]}");
        return null;
      } else {
        // showToast("Something went wrong");
        return null;
      }
    } catch (e) {
      //debugPrint("apiError  ${e.toString()}");
      if (e is SocketException) {
        //comment
        //showToast("please check your internet connection");
      } else if (e is TimeoutException) {
        //comment
        //showToast("Timeout exception: ${e.toString()}");
      }
      return null;
    }
  }

}