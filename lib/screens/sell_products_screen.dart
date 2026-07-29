import 'package:flutter/material.dart';
import '../services/current_user.dart';
import '../services/supabase_service.dart';

class SellProductsScreen extends StatefulWidget {
  const SellProductsScreen({super.key});

  @override
  State<SellProductsScreen> createState() =>
      _SellProductsScreenState();
}

class _SellProductsScreenState
    extends State<SellProductsScreen> {

  String category = "Fruits";
  bool useMyProfile = true;
  bool isLoading = false;

  String get loggedInName =>
      CurrentUser.name;

  String get loggedInPhone =>
      CurrentUser.phone;

  String get loggedInAddress =>
      CurrentUser.address;

  final otherFarmerController =
      TextEditingController();

  final otherPhoneController =
      TextEditingController();

  final otherAddressController =
      TextEditingController();

  final productController =
      TextEditingController();

  final priceController =
      TextEditingController();

  final quantityController =
      TextEditingController();

  Future<void> publishProduct() async {

    if (productController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        quantityController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all product details",
          ),
        ),
      );
      return;
    }

    double? price =
        double.tryParse(priceController.text);

    int? quantity =
        int.tryParse(quantityController.text);

    if (price == null || quantity == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Enter valid price and quantity",
          ),
        ),
      );
      return;
    }

    String farmerName;
    String phone;
    String address;

    if (useMyProfile) {

      farmerName = loggedInName;
      phone = loggedInPhone;
      address = loggedInAddress;

      if (farmerName.isEmpty) {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Please login first",
            ),
          ),
        );

        return;
      }

    } else {

      farmerName =
          otherFarmerController.text.trim();

      phone =
          otherPhoneController.text.trim();

      address =
          otherAddressController.text.trim();

      if (farmerName.isEmpty ||
          phone.isEmpty ||
          address.isEmpty) {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Please fill farmer details",
            ),
          ),
        );

        return;
      }
    }

    try {

      setState(() {
        isLoading = true;
      });

      await SupabaseService.supabase
          .from('products')
          .insert({
        'farmer_name': farmerName,
        'phone': phone,
        'address': address,
        'category': category,
        'product_name':
            productController.text.trim(),
        'price': price,
        'quantity': quantity,
        'uploaded_by': loggedInName,
      });

      productController.clear();
      priceController.clear();
      quantityController.clear();

      otherFarmerController.clear();
      otherPhoneController.clear();
      otherAddressController.clear();

      setState(() {});

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Product Published Successfully",
          ),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            "Error: $e",
          ),
        ),
      );

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sell Products"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Seller Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            RadioListTile(
              title: const Text(
                "Use My Farm Profile",
              ),
              value: true,
              groupValue: useMyProfile,
              onChanged: (value) {
                setState(() {
                  useMyProfile = value!;
                });
              },
            ),

            RadioListTile(
              title: const Text(
                "Selling on Behalf of Another Farmer",
              ),
              value: false,
              groupValue: useMyProfile,
              onChanged: (value) {
                setState(() {
                  useMyProfile = value!;
                });
              },
            ),

            const SizedBox(height: 10),

            if (useMyProfile)
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundColor:
                        Colors.green,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    loggedInName.isEmpty
                        ? "No User Logged In"
                        : loggedInName,
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "$loggedInPhone\n$loggedInAddress",
                  ),
                ),
              ),

            if (!useMyProfile)
              Column(
                children: [

                  TextField(
                    controller:
                        otherFarmerController,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "Farmer Name",
                      border:
                          OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller:
                        otherPhoneController,
                    keyboardType:
                        TextInputType.phone,
                    decoration:
                        const InputDecoration(
                      labelText:
                          "Phone Number",
                      border:
                          OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller:
                        otherAddressController,
                    decoration:
                        const InputDecoration(
                      labelText: "Address",
                      border:
                          OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),
                ],
              ),

            DropdownButtonFormField<String>(
              value: category,
              decoration:
                  const InputDecoration(
                labelText: "Category",
                border:
                    OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Fruits",
                  child: Text("Fruits"),
                ),
                DropdownMenuItem(
                  value: "Vegetables",
                  child: Text("Vegetables"),
                ),
                DropdownMenuItem(
                  value: "Grains",
                  child: Text("Grains"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: productController,
              decoration:
                  const InputDecoration(
                labelText: "Product Name",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: priceController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText: "Price Per Kg",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
                  quantityController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    "Available Quantity (Kg)",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed:
                    isLoading
                        ? null
                        : publishProduct,
                icon: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(),
                      )
                    : const Icon(
                        Icons.publish,
                      ),
                label: Text(
                  isLoading
                      ? "Publishing..."
                      : "Publish Product",
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Divider(),

            const Text(
              "My Published Products",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            FutureBuilder(
              future: SupabaseService
                  .supabase
                  .from('products')
                  .select()
                  .eq(
                    'uploaded_by',
                    CurrentUser.name,
                  )
                  .order('id'),

              builder:
                  (context, snapshot) {

                if (!snapshot.hasData) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                final products =
                    snapshot.data
                        as List<dynamic>;

                if (products.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding:
                          EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "No Products Published Yet",
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  children: products.map(
                    (product) {

                      return Card(
                        elevation: 4,
                        margin:
                            const EdgeInsets.only(
                          bottom: 12,
                        ),

                        child: ListTile(
                          leading:
                              CircleAvatar(
                            backgroundColor:
                                Colors.green,
                            child: Text(
                              product[
                                      'product_name']
                                  .toString()[0]
                                  .toUpperCase(),
                            ),
                          ),

                          title: Text(
                            product[
                                'product_name'],
                          ),

                          subtitle: Text(
                            "Category : ${product['category']}\n"
                            "Price : ₹${product['price']}/kg\n"
                            "Quantity : ${product['quantity']} kg",
                          ),

                          trailing:
                              const Icon(
                            Icons.check_circle,
                            color:
                                Colors.green,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}