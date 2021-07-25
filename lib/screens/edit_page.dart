import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_app/providers/product_provider.dart';

class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    var productProvider = Provider.of<ProductProvider>(context);
    var product = productProvider.getById(args);

    TextEditingController nameController =
        TextEditingController(text: product.name);
    TextEditingController descriptionController =
        TextEditingController(text: product.description);
    TextEditingController priceController =
        TextEditingController(text: product.price.toString());
    TextEditingController imageUrlController =
        TextEditingController(text: product.imageUrl);

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  productProvider
                      .updateProduct(
                          args,
                          nameController.text,
                          descriptionController.text,
                          priceController.text,
                          imageUrlController.text)
                      .then((value) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Berhasil Update product'),
                      ),
                    );
                  });
                },
                child: Text('Update'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
