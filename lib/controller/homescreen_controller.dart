import 'package:e_commerce_app/dummy_db.dart';
import 'package:flutter/material.dart';

class HomescreenController with ChangeNotifier {
  List newArrivals = DummyDb.newArrivals;
  List allProducts = DummyDb.products;
}
