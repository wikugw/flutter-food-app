import 'package:toko_app/routes/route_names.dart';
import 'package:toko_app/screens/create_page.dart';
import 'package:toko_app/screens/detail_page.dart';
import 'package:toko_app/screens/edit_page.dart';
import 'package:toko_app/screens/list_page.dart';

class Routes {
  static final routes = {
    RouteNames.homePage: (context) => ListPage(),
    RouteNames.createPage: (context) => CreatePage(),
    RouteNames.editPage: (context) => EditPage(),
    RouteNames.detailPage: (context) => DetailPage(),
  };
}
