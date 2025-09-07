import 'package:flutter/material.dart';
import 'profile_setup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _googleSignIn() {
    // TODO: Implement Google Sign In
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
    );
  }

  void _linkedinSignIn() {
    // TODO: Implement LinkedIn Sign In
  }

  void _githubSignIn() {
    // TODO: Implement GitHub Sign In
  }

  void _phoneSignIn() {
    // TODO: Implement Phone Number Sign In
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF3A5A), Color(0xFFFF7539)], // Tinder-like gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const Icon(Icons.local_fire_department,
                  size: 80, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                "MyApp",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildSignInButton(
                      onPressed: _googleSignIn,
                      icon: Icons.g_mobiledata,
                      label: "Continue with Google",
                    ),
                    const SizedBox(height: 12),
                    _buildSignInButton(
                      onPressed: _linkedinSignIn,
                      icon: Icons.link,
                      label: "Continue with LinkedIn",
                    ),
                    const SizedBox(height: 12),
                    _buildSignInButton(
                      onPressed: _githubSignIn,
                      icon: Icons.code,
                      label: "Continue with GitHub",
                    ),
                    const SizedBox(height: 12),
                    _buildSignInButton(
                      onPressed: _phoneSignIn,
                      icon: Icons.phone,
                      label: "Continue with Phone number",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Terms text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "By tapping 'Sign in', you agree to our Terms. Learn how we process your data in our Privacy Policy and Cookies Policy.",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  // TODO: Navigate to password reset/help
                },
                child: const Text(
                  "Trouble signing in?",
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
