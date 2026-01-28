import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/core/utils/validators.dart';
import 'package:exam_flutter/core/widgets/custom_button.dart';
import 'package:exam_flutter/core/widgets/custom_text_field.dart';
import 'package:exam_flutter/features/authentication/providers/auth_provider.dart';
import 'package:exam_flutter/features/authentication/widgets/auth_header.dart';

/// Sign In screen
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      
      final success = await authProvider.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (success && mounted) {
        // Navigate to home screen
        Navigator.of(context).pushReplacementNamed('/home');
      } else if (mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Login failed'),
            backgroundColor: AppConstants.errorRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacing24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.spacing40),
                
                // Header
                FadeInDown(
                  child: const AuthHeader(
                    title: 'Welcome Back!',
                    subtitle: 'Sign in to order your favorite meals',
                    icon: Icons.restaurant_menu_rounded,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing48),
                
                // Email field
                FadeInLeft(
                  delay: const Duration(milliseconds: 100),
                  child: CustomTextField(
                    label: 'Email',
                    hint: 'votre@email.com',
                    prefixIcon: Icons.email_outlined,
                    controller: _emailController,
                    validator: Validators.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing16),
                
                // Password field
                FadeInRight(
                  delay: const Duration(milliseconds: 200),
                  child: CustomTextField(
                    label: 'Mot de passe',
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le mot de passe est requis';
                      }
                      return null;
                    },
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing8),
                
                // Forgot password link
                FadeInRight(
                  delay: const Duration(milliseconds: 300),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/forgot-password');
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing32),
                
                // Sign in button
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return CustomButton(
                        text: 'Sign In',
                        onPressed: _handleSignIn,
                        isLoading: authProvider.isLoading,
                        icon: Icons.login,
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing24),
                
                // Sign up link
                FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          color: AppConstants.lightText,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/signup');
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
