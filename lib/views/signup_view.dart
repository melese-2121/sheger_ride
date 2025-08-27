import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheger_ride/controllers/auth_controller.dart';
import 'package:sheger_ride/views/dashboard_view.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;

  void _signup() async {
    if (!_formKey.currentState!.validate()) return;

    final authController = ref.read(authControllerProvider.notifier);

    await authController.signUp(
      _emailController.text,
      _passwordController.text,
      _nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF001922), Color(0xFF003344)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: "appLogo",
                  child: Image.asset('assets/icons/app_icon.png', width: 140),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Create Account 🚀",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                const Text(
                  "Sign up to start your ride",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white.withOpacity(0.1),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Name
                          _buildTextField(
                            controller: _nameController,
                            hint: 'Full Name',
                            icon: Icons.person,
                            validator: (v) => v == null || v.isEmpty
                                ? "Enter your name"
                                : null,
                          ),
                          const SizedBox(height: 16),

                          // Email
                          _buildTextField(
                            controller: _emailController,
                            hint: 'Email',
                            icon: Icons.email,
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return "Enter your email";
                              final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                              if (!regex.hasMatch(v))
                                return "Enter a valid email";
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          _buildTextField(
                            controller: _passwordController,
                            hint: 'Password',
                            icon: Icons.lock,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white70,
                              ),
                              onPressed: () {
                                setState(
                                  () => _obscurePassword = !_obscurePassword,
                                );
                              },
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return "Enter a password";
                              if (v.length < 6)
                                return "Password must be at least 6 characters";
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          _buildTextField(
                            controller: _confirmPasswordController,
                            hint: 'Confirm Password',
                            icon: Icons.lock_outline,
                            obscureText: true,
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return "Confirm your password";
                              if (v != _passwordController.text)
                                return "Passwords do not match";
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),

                          Consumer(
                            builder: (context, ref, _) {
                              final authState = ref.watch(
                                authControllerProvider,
                              );

                              return authState.when(
                                data: (user) {
                                  if (user != null) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                          if (mounted) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const DashboardPage(),
                                              ),
                                            );
                                          }
                                        });
                                  }

                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        backgroundColor: Colors.tealAccent[400],
                                        foregroundColor: Colors.black,
                                        elevation: 5,
                                        shadowColor: Colors.tealAccent[200],
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: authState.isLoading
                                          ? null
                                          : _signup,
                                      child: authState.isLoading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.black,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text("Sign Up"),
                                    ),
                                  );
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (e, _) => Column(
                                  children: [
                                    Text(
                                      e.toString(),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                    SizedBox(
                                      width: double.infinity,

                                      child: ElevatedButton(
                                        onPressed: () => _signup(),
                                        child: const Text("Sign Up"),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          backgroundColor:
                                              Colors.tealAccent[400],
                                          foregroundColor: Colors.black,
                                          elevation: 5,
                                          shadowColor: Colors.tealAccent[200],
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
