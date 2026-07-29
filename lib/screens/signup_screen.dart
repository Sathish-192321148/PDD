import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../services/user_data.dart';
import '../services/supabase_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  bool isLoading = false;

  Future<void> registerUser() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        addressController.text.isEmpty ||
        districtController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await SupabaseService.supabase.from('users').insert({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'password': passwordController.text.trim(),
        'address': addressController.text.trim(),
        'district': districtController.text.trim(),
      });

      // Save locally also
      UserData.name = nameController.text.trim();
      UserData.phone = phoneController.text.trim();
      UserData.address = addressController.text.trim();
      UserData.district = districtController.text.trim();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration Successful'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration Failed: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        // Uses global appBarTheme colors
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create your account',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'It takes less than a minute',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: districtController,
                decoration: const InputDecoration(labelText: 'District'),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading ? null : registerUser,
                  child: isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

