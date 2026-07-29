import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import '../services/supabase_service.dart';
import '../services/current_user.dart';
import '../services/user_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> loginUser() async {
    if (phoneController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter Phone and Password'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await SupabaseService.supabase
          .from('users')
          .select()
          .eq(
            'phone',
            phoneController.text.trim(),
          )
          .eq(
            'password',
            passwordController.text.trim(),
          );

      if (result.isNotEmpty) {
        CurrentUser.name = result[0]['name'];
        CurrentUser.phone = result[0]['phone'];
        CurrentUser.address = result[0]['address'];
        CurrentUser.district = result[0]['district'];

        // Keep compatibility with existing screens
        UserData.name = result[0]['name'];
        UserData.phone = result[0]['phone'];
        UserData.address = result[0]['address'];
        UserData.district = result[0]['district'];

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Phone Number or Password'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Error: $e'),
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
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // 1. Welcome Header
              const Center(
                child: Column(
                  children: [
                    Text(
                      '🌾',
                      style: TextStyle(fontSize: 48),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Welcome to FarmConnect',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Buy Fresh • Sell Direct • Grow Together',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 2. Small Description
              Center(
                child: Text(
                  'Login to buy fresh farm products directly from farmers or publish your harvest to reach more customers.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 3. Login Fields
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 22),

              // 4. Login Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading ? null : loginUser,
                  child: isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Login to FarmConnect'),
                ),
              ),
              const SizedBox(height: 12),

              // 5. Signup Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New to FarmConnect?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Create an Account',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // 6. Benefits Section
              const Text(
                'Why Choose FarmConnect?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              _buildBenefitCard(
                Icons.eco,
                Colors.green,
                'Fresh Products',
                'Buy directly from verified farmers.',
              ),
              const SizedBox(height: 8),
              _buildBenefitCard(
                Icons.currency_rupee,
                Colors.orange,
                'Better Prices',
                'No middlemen means fair prices for everyone.',
              ),
              const SizedBox(height: 8),
              _buildBenefitCard(
                Icons.agriculture,
                Colors.brown,
                'Direct Farmer Connection',
                'Contact farmers directly before purchasing.',
              ),
              const SizedBox(height: 8),
              _buildBenefitCard(
                Icons.inventory,
                Colors.teal,
                'Easy Product Management',
                'Publish and manage your products anytime.',
              ),

              const SizedBox(height: 20),

              // 7. Security Card
              Card(
                color: Colors.green.shade50,
                child: const ListTile(
                  leading: Icon(
                    Icons.lock,
                    color: Colors.green,
                    size: 32,
                  ),
                  title: Text(
                    '🔒 Secure Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Your account information is securely stored and protected.',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 8. Small Information Card
              Card(
                color: Colors.orange.shade50,
                child: const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'FarmConnect helps farmers sell directly to consumers while enabling buyers to purchase fresh produce at affordable prices.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 9. Agriculture Quote
              Center(
                child: Column(
                  children: [
                    Text(
                      '"\u201CThe farmer is the backbone of our nation.\u201D"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '— Thank you for supporting local farmers.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitCard(
    IconData icon,
    Color color,
    String title,
    String subtitle,
  ) {
    return Card(
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}

