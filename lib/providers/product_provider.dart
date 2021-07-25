import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:toko_app/models/product_model.dart';
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  late List products = [];

  Future getProducts() async {
    final String url = 'http://10.0.2.2:8000/api/products';

    var request = await http.get(Uri.parse(url));

    var response = json.decode(request.body);
    // print(response['products'].length);
    response['products'].forEach((product) {
      // print(product['id']);

      products.add(Product(
          id: product['id'],
          name: product['name'],
          description: product['description'],
          price: double.parse(product['price']),
          imageUrl: product['image_url']));
    });
    notifyListeners();
  }

  Product getById(id) {
    var product = products.firstWhere((element) => element.id == id);
    return product;
  }

  Future updateProduct(id, name, description, price, imageUrl) async {
    // final formKey = GlobalKey<FormState>();
    final String url = 'http://10.0.2.2:8000/api/products/' + id.toString();

    var body = {
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl
    };

    // print(body);

    // print(json.decode(body));
    var request = await http.put(Uri.parse(url), body: body);
    var response = json.decode(request.body);

    var product = getById(id);
    print(response);
    product.name = response['products']['name'];
    product.description = response['products']['description'];
    product.price = double.parse(response['products']['price']);
    product.imageUrl = response['products']['image_url'];
    notifyListeners();
  }

  Future<void> addProduct(name, description, price, imageUrl) async {
    final String url = 'http://10.0.2.2:8000/api/products';

    var body = {
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl
    };

    try {
      var request = await http.post(Uri.parse(url), body: body);
      var response = json.decode(request.body);
      print(response);

      products.add(Product(
        id: response['products']['id'],
        name: response['products']['name'],
        description: response['products']['description'],
        price: double.parse(response['products']['price']),
        imageUrl: response['products']['image_url'],
      ));
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future deleteProduct(id) async {
    final String url = 'http://10.0.2.2:8000/api/products/' + id.toString();
    await http.delete(Uri.parse(url));

    products.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
