import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_app/providers/product_provider.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.getById(id);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              child: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(5),
              child: ListView(
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rp. ${product.price}',
                    style: TextStyle(fontSize: 24, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Deskripsi:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    product.description,
                    style: TextStyle(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
