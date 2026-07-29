import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.green.shade100),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.agriculture,
                      size: 110,
                      color: Color(0xFF2E7D32),
                    ),
                    const SizedBox(height: 14),

                    const Text(
                      'Welcome to FarmConnect',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        height: 1.15,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Buy directly from farmers without mediators',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      'Fresh fruits • Organic vegetables • Local grains',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Image Above Explore Button
              Image.asset(
                'assets/images/welcome.jpg',
                height: 180,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 25),

              FilledButton.icon(
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                ),
                label: const Text('Explore'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 14),

              Text(
                'By continuing you agree to our terms.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}