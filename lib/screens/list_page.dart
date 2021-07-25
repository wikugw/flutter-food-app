import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toko_app/providers/product_provider.dart';
import 'package:toko_app/routes/route_names.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool init = true;
  @override
  void didChangeDependencies() {
    if (init) {
      init = false;
      Provider.of<ProductProvider>(context).getProducts();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ProductProvider>(
        builder: (context, data, child) => ListView.builder(
          itemCount: productProvider.products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  RouteNames.detailPage,
                  arguments: productProvider.products[index].id),
              child: Container(
                height: 180,
                child: Card(
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          height: 160,
                          width: 160,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hero(
                              tag: productProvider.products[index].id,
                              child: Image.network(
                                productProvider.products[index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          width: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                productProvider.products[index].name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              Text(
                                productProvider.products[index].description,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                  'Rp. ${productProvider.products[index].price}'),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.pushNamed(
                                          context, RouteNames.editPage,
                                          arguments: productProvider
                                              .products[index].id),
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.green,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text('Yakin'),
                                          content: Text('Temenan'),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: Text('Cancel')),
                                            TextButton(
                                                onPressed: () => productProvider
                                                        .deleteProduct(
                                                            productProvider
                                                                .products[index]
                                                                .id)
                                                        .then((value) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  'Berhasil dihapus')));
                                                    }),
                                                child: Text('gas'))
                                          ],
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(RouteNames.createPage),
        child: Icon(Icons.add),
      ),
    );
  }
}
