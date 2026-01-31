import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/core/utils/validators.dart';
import 'package:exam_flutter/core/widgets/custom_button.dart';
import 'package:exam_flutter/core/widgets/custom_text_field.dart';
import 'package:exam_flutter/features/authentication/providers/auth_provider.dart';
import 'package:exam_flutter/features/authentication/widgets/auth_header.dart';

/// Sign Up screen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _acceptTerms = false;
  int _passwordStrength = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength(String password) {
    setState(() {
      _passwordStrength = Validators.getPasswordStrength(password);
    });
  }

  Color _getPasswordStrengthColor() {
    if (_passwordStrength < 30) return AppConstants.errorRed;
    if (_passwordStrength < 60) return Colors.orange;
    if (_passwordStrength < 80) return AppConstants.successGreen;
    return Colors.green.shade700;
  }

  Future<void> _handleSignUp() async {
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: AppConstants.errorRed,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      
      final success = await authProvider.signUp(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! Please sign in.'),
            backgroundColor: AppConstants.successGreen,
          ),
        );
        
        Navigator.of(context).pushReplacementNamed('/signin');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Registration failed'),
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
                const SizedBox(height: AppConstants.spacing24),
                
                FadeInDown(
                  child: const AuthHeader(
                    title: 'Create Account',
                    subtitle: 'Join us to enjoy our delicious meals',
                    icon: Icons.person_add_rounded,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing40),
                
                FadeInLeft(
                  delay: const Duration(milliseconds: 100),
                  child: CustomTextField(
                    label: 'Full Name',
                    hint: 'John Doe',
                    prefixIcon: Icons.person_outline,
                    controller: _nameController,
                    validator: Validators.validateName,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing16),
                
                FadeInRight(
                  delay: const Duration(milliseconds: 200),
                  child: CustomTextField(
                    label: 'Email',
                    hint: 'your@email.com',
                    prefixIcon: Icons.email_outlined,
                    controller: _emailController,
                    validator: Validators.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing16),
                
                FadeInLeft(
                  delay: const Duration(milliseconds: 300),
                  child: CustomTextField(
                    label: 'Phone',
                    hint: '0612345678',
                    prefixIcon: Icons.phone_outlined,
                    controller: _phoneController,
                    validator: Validators.validatePhone,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing16),
                
                FadeInRight(
                  delay: const Duration(milliseconds: 400),
                  child: CustomTextField(
                    label: 'Password',
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    controller: _passwordController,
                    validator: Validators.validatePassword,
                    isPassword: true,
                    textInputAction: TextInputAction.next,
                    onChanged: _updatePasswordStrength,
                  ),
                ),
                
                if (_passwordController.text.isNotEmpty)
                  FadeIn(
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppConstants.spacing8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LinearProgressIndicator(
                            value: _passwordStrength / 100,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getPasswordStrengthColor(),
                            ),
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          const SizedBox(height: AppConstants.spacing4),
                          Text(
                            'Strength: ${Validators.getPasswordStrengthLabel(_passwordStrength)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: _getPasswordStrengthColor(),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                const SizedBox(height: AppConstants.spacing16),
                
                FadeInLeft(
                  delay: const Duration(milliseconds: 500),
                  child: CustomTextField(
                    label: 'Confirm Password',
                    hint: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    controller: _confirmPasswordController,
                    validator: (value) => Validators.validatePasswordConfirmation(
                      value,
                      _passwordController.text,
                    ),
                    isPassword: true,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing16),
                
                FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                        activeColor: AppConstants.primaryOrange,
                      ),
                      Expanded(
                        child: Text(
                          'I accept the terms and conditions',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppConstants.darkText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing24),
                
                FadeInUp(
                  delay: const Duration(milliseconds: 700),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return CustomButton(
                        text: 'Sign Up',
                        onPressed: _handleSignUp,
                        isLoading: authProvider.isLoading,
                        icon: Icons.how_to_reg,
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing24),
                
                FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: AppConstants.lightText,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        child: const Text(
                          'Sign In',
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
