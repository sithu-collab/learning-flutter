import 'dart:convert';

import 'package:f02_pos/model/api/api-config.dart';
import 'package:f02_pos/model/dto/product.dart';
import 'package:http/http.dart' as http;

const API = "$BASE_API/products";

class ProductApi {
  Future<List<Product>> search({int category, String name = ""}) async {
    var uri = Uri.http(BASE_HOST, "/products",
        {'category': category?.toString(), 'name': name});
    var response = await http.get(uri);
    return productFromJson(response.body);
  }

  Future<int> count() async {
    var value = await http.get("$API/count");
    return json.decode(value.body);
  }

  Future<Product> findById(int id) async {
    var response = await http.get("$API/$id");
    return Product.fromJson(json.decode(response.body));
  }

  Future<Product> save(Product p) async {
    return p.id == null ? _create(p) : _update(p);
  }

  Future<Product> _create(Product p) async {
    var response =
        await http.post(API, body: json.encode(p.toJson()), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return Product.fromJson(json.decode(response.body));
  }

  Future<Product> _update(Product p) async {
    var response =
        await http.post(API, body: json.encode(p.toJson()), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return Product.fromJson(json.decode(response.body));
  }
}
