import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sheger_ride/controllers/auth_providers.dart';
import 'package:sheger_ride/views/dashboard_view.dart';
import 'package:sheger_ride/widgets/app_button.dart';

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
  String? fullPhoneNumber;
  String? countryCode;

  void _signup() async {
    if (!_formKey.currentState!.validate()) return;

    final authController = ref.read(authControllerProvider.notifier);

    await authController.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      fullName: _nameController.text.trim(),
      phone: fullPhoneNumber ?? '',
      countryCode: countryCode ?? '+251',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        color: colorScheme.background,
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
                Text(
                  "Create Account 🚀",
                  style: textTheme.headlineMedium?.copyWith(
                    color: colorScheme.onBackground,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  "Sign up to start your ride",
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onBackground.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: colorScheme.surface.withOpacity(0.95),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Name
                          _buildTextField(
                            context: context,
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
                            context: context,
                            controller: _emailController,
                            hint: 'Email',
                            icon: Icons.email,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Enter your email";
                              }
                              final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                              if (!regex.hasMatch(v)) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          IntlPhoneField(
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: colorScheme.onBackground.withOpacity(0.7),
                              ),
                              hintStyle: textTheme.bodySmall?.copyWith(color: colorScheme.onBackground.withOpacity(0.5)),
                              filled: true,
                              fillColor: colorScheme.surface.withOpacity(0.7),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16,
                              ),
                            ),
                            initialCountryCode: 'ET',
                            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground),
                            dropdownIcon: Icon(
                              Icons.arrow_drop_down,
                              color: colorScheme.onBackground.withOpacity(0.7),
                            ),
                            onChanged: (phone) {
                              fullPhoneNumber = phone.completeNumber;
                              countryCode = phone.countryCode;
                            },
                          ),

                          const SizedBox(height: 16),

                          _buildTextField(
                            context: context,
                            controller: _passwordController,
                            hint: 'Password',
                            icon: Icons.lock,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: colorScheme.onBackground.withOpacity(0.7),
                              ),
                              onPressed: () {
                                setState(
                                  () => _obscurePassword = !_obscurePassword,
                                );
                              },
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Enter a password";
                              }
                              if (v.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          _buildTextField(
                            context: context,
                            controller: _confirmPasswordController,
                            hint: 'Confirm Password',
                            icon: Icons.lock_outline,
                            obscureText: true,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Confirm your password";
                              }
                              if (v != _passwordController.text) {
                                return "Passwords do not match";
                              }
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

                                  return AppButton(
                                    label: "Sign Up",
                                    isLoading: authState.isLoading,
                                    onPressed: authState.isLoading
                                        ? () {}
                                        : _signup,
                                  );
                                },
                                loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                error: (e, _) => Column(
                                  children: [
                                    Text(
                                      e.toString(),
                                      style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
                                    ),
                                    SizedBox(
                                      width: double.infinity,

                                      child: ElevatedButton(
                                        onPressed: () => _signup(),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          backgroundColor: colorScheme.secondary,
                                          foregroundColor: colorScheme.onSecondary,
                                          elevation: 5,
                                          shadowColor: colorScheme.secondary.withOpacity(0.5),
                                          textStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        child: const Text("Sign Up"),
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
                  child: Text(
                    "Already have an account? Login",
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onBackground.withOpacity(0.7),
                      fontSize: 15,
                    ),
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
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return TextFormField(
      controller: controller,
      style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground),
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: colorScheme.onBackground.withOpacity(0.7)),
        filled: true,
        fillColor: colorScheme.surface.withOpacity(0.7),
        hintText: hint,
        hintStyle: textTheme.bodySmall?.copyWith(color: colorScheme.onBackground.withOpacity(0.5)),
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
