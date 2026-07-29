import 'package:flutter/material.dart';
import 'buy_products_screen.dart';
import 'sell_products_screen.dart';
import 'settings_screen.dart';
import '../services/current_user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FarmConnect"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// WELCOME BANNER

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.green,
                    Color(0xFF66BB6A),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    "🌾 FarmConnect",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Connecting Farmers & Buyers Directly",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// USER GREETING CARD

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15),
              ),

              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      "Hello, ${CurrentUser.name}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      CurrentUser.phone,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      CurrentUser.address,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// STATISTICS CARDS

            Row(
              children: [

                Expanded(
                  child: Card(
                    elevation: 4,

                    child: Padding(
                      padding:
                          const EdgeInsets.all(15),

                      child: Column(
                        children: const [

                          Icon(
                            Icons.inventory,
                            color: Colors.green,
                            size: 40,
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Products",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            "100+",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Card(
                    elevation: 4,

                    child: Padding(
                      padding:
                          const EdgeInsets.all(15),

                      child: Column(
                        children: const [

                          Icon(
                            Icons.people,
                            color: Colors.orange,
                            size: 40,
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Farmers",
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            "50+",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            /// BUY PRODUCTS

            Card(
              elevation: 5,

              child: ListTile(
                contentPadding:
                    const EdgeInsets.all(15),

                leading: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ),

                title: const Text(
                  "Buy Products",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  "Purchase fresh products directly from farmers",
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const BuyProductsScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            /// SELL PRODUCTS

            Card(
              elevation: 5,

              child: ListTile(
                contentPadding:
                    const EdgeInsets.all(15),

                leading: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.sell,
                    color: Colors.white,
                  ),
                ),

                title: const Text(
                  "Sell Products",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  "Publish your harvest and reach buyers",
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const SellProductsScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            /// AGRICULTURE TIP

            Card(
              color: Colors.green.shade50,
              elevation: 4,

              child: const ListTile(
                leading: Icon(
                  Icons.lightbulb,
                  color: Colors.green,
                  size: 35,
                ),

                title: Text(
                  "Today's Farming Tip",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text(
                  "Harvest fruits and vegetables during the early morning hours to maintain freshness and reduce moisture loss.",
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}