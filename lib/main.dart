import 'package:flutter/material.dart';
import 'package:toko_app/providers/product_provider.dart';
import 'package:toko_app/routes/route_names.dart';
import 'package:toko_app/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        // home: ListPage(),
        initialRoute: RouteNames.homePage,
        routes: Routes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
