import '../models/product.dart';

class AppData {
  static List<Product> products = [];

  // Items placed into cart/basket.
  // Each entry structure is:
  // {"product": Product, "qty": int}
  static List<Map<String, dynamic>> cart = [];

  // Keeping existing basket reference for compatibility.
  // Current code sometimes uses basket instead of cart.
  static List<Map<String, dynamic>> get basket => cart;
}

