import 'dart:io';
import 'package:dio/dio.dart';
import 'package:download_info/data/models/product_model.dart';
import 'package:download_info/data/service/api_client.dart';
import 'package:flutter/cupertino.dart';

class ApiService {
  ApiService({required this.apiClient});
  ApiClient apiClient;

  Future<List<ProductModel>> getProducts() async {
    try {
      Response response = await apiClient.dio.get(
        apiClient.dio.options.baseUrl,
      );
      if (response.statusCode! == HttpStatus.ok) {
        return (response.data['data'] as List?)
                ?.map((e) => ProductModel.fromJson(e))
                .toList() ??
            [];
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
