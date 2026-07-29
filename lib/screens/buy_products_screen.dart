import 'package:flutter/material.dart';
import 'category_products_screen.dart';

class BuyProductsScreen extends StatefulWidget {
  const BuyProductsScreen({super.key});

  @override
  State<BuyProductsScreen> createState() => _BuyProductsScreenState();
}

class _BuyProductsScreenState extends State<BuyProductsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Fruits',
      'icon': Icons.apple,
      'description': 'Fresh fruits directly from farmers',
      'emoji': '🍎',
    },
    {
      'name': 'Vegetables',
      'icon': Icons.eco,
      'description': 'Organic vegetables from farms',
      'emoji': '🥕',
    },
    {
      'name': 'Grains',
      'icon': Icons.agriculture,
      'description': 'Rice, wheat and grains',
      'emoji': '🌾',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy Products"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // 2. Welcome Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Fresh From Farmers",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Buy directly from verified farmers at the best prices.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 3. Category Cards
            const Text(
              "Shop by Category",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ..._categories.map(
              (cat) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildCategoryCard(
                  context,
                  cat['name'] as String,
                  cat['icon'] as IconData,
                  cat['description'] as String,
                  cat['emoji'] as String,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 4. Why Buy From FarmConnect
            const Text(
              "Why Buy From FarmConnect",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _buildWhyBuyCard(
              Icons.verified,
              Colors.green,
              "Verified Farmers",
              "Every product is uploaded directly by farmers.",
            ),

            const SizedBox(height: 10),

            _buildWhyBuyCard(
              Icons.local_shipping,
              Colors.orange,
              "Direct Purchase",
              "No middlemen. Better price for buyers and farmers.",
            ),

            const SizedBox(height: 10),

            _buildWhyBuyCard(
              Icons.eco,
              Colors.green,
              "Fresh Harvest",
              "Freshly harvested fruits, vegetables and grains.",
            ),

            const SizedBox(height: 20),

            // 5. Buying Tips
            Card(
              color: Colors.green.shade50,
              child: const ListTile(
                leading: Icon(
                  Icons.lightbulb,
                  color: Colors.green,
                ),
                title: Text("Buying Tip"),
                subtitle: Text(
                  "Compare prices from different farmers before selecting the best option.",
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 6. Customer Benefits
            const Text(
              "Customer Benefits",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildBenefitItem(
                    Icons.eco,
                    "Fresh\nProducts",
                  ),
                ),
                Expanded(
                  child: _buildBenefitItem(
                    Icons.currency_rupee,
                    "Best\nPrice",
                  ),
                ),
                Expanded(
                  child: _buildBenefitItem(
                    Icons.call,
                    "Direct\nContact",
                  ),
                ),
                Expanded(
                  child: _buildBenefitItem(
                    Icons.thumb_up,
                    "Secure\nBuying",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 7. Bottom Information Card
            Card(
              color: Colors.orange.shade50,
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Icon(
                      Icons.info,
                      size: 40,
                      color: Colors.orange,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Select a category to view all available products uploaded by farmers.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String category,
    IconData icon,
    String description,
    String emoji,
  ) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.green.shade50,
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        title: Text(
          category,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryProductsScreen(
                category: category,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWhyBuyCard(
    IconData icon,
    Color color,
    String title,
    String subtitle,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _buildBenefitItem(
    IconData icon,
    String label,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.green,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

