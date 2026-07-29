import 'package:flutter/material.dart';
import '../services/supabase_service.dart';
import 'available_farmers_screen.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  const CategoryProductsScreen({
    super.key,
    required this.category,
  });

  Future<List<dynamic>> getProducts() async {
    return await SupabaseService.supabase
        .from('products')
        .select()
        .eq('category', category);
  }

  String _getEmojiForCategory() {
    switch (category.toLowerCase()) {
      case 'fruits':
        return '🍎';
      case 'vegetables':
        return '🥕';
      case 'grains':
        return '🌾';
      default:
        return '📦';
    }
  }

  IconData _getProductEmoji(String productName) {
    const fruitEmojis = {
      'apple': '🍎',
      'banana': '🍌',
      'orange': '🍊',
      'mango': '🥭',
      'grapes': '🍇',
      'watermelon': '🍉',
      'strawberry': '🍓',
      'pineapple': '🍍',
      'pomegranate': '🫐',
      'papaya': '🥝',
      'guava': '🫒',
      'coconut': '🥥',
    };

    // Check if product name matches any known fruit
    final lowerName = productName.toLowerCase();
    for (final entry in fruitEmojis.entries) {
      if (lowerName.contains(entry.key)) {
        // Return a relevant icon based on category
        if (category.toLowerCase() == 'fruits') return Icons.apple;
        if (category.toLowerCase() == 'vegetables') return Icons.eco;
        if (category.toLowerCase() == 'grains') return Icons.agriculture;
      }
    }

    // Default icons by category
    switch (category.toLowerCase()) {
      case 'fruits':
        return Icons.apple;
      case 'vegetables':
        return Icons.eco;
      case 'grains':
        return Icons.agriculture;
      default:
        return Icons.shopping_bag;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data as List;

          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getEmojiForCategory(),
                    style: const TextStyle(fontSize: 64),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "No Products Available",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Farmers haven't listed any ${category.toLowerCase()} yet.",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }

          // Group by product name and compute stats
          final productNames = data.map((e) => e['product_name'] as String).toSet().toList();

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: productNames.length,
            itemBuilder: (context, index) {
              final productName = productNames[index];

              // Get all entries for this product
              final productEntries = data.where((p) => p['product_name'] == productName).toList();

              // Compute stats
              final farmerCount = productEntries.length;
              final prices = productEntries.map((p) => (p['price'] as num).toDouble()).toList();
              prices.sort();
              final minPrice = prices.first;
              final maxPrice = prices.last;
              final totalQuantity = productEntries.fold<int>(0, (sum, p) => sum + (p['quantity'] as int));

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      // Product icon circle
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _getProductEmoji(productName),
                          color: Colors.green,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Product details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: 15,
                                  color: Colors.green.shade700,
                                ),
                                Text(
                                  "$minPrice",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                                if (minPrice != maxPrice) ...[
                                  Text(
                                    " - ₹$maxPrice",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.green.shade700,
                                    ),
                                  ),
                                ],
                                Text(
                                  " /kg",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 14,
                                  color: Colors.grey.shade500,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "$farmerCount farmer${farmerCount > 1 ? 's' : ''}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.inventory,
                                  size: 14,
                                  color: Colors.grey.shade500,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "$totalQuantity kg available",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // View options button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AvailableFarmersScreen(
                                productName: productName,
                              ),
                            ),
                          );
                        },
                        child: const Text("View Options"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

