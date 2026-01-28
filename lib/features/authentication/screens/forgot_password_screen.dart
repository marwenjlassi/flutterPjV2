import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:exam_flutter/core/constants/app_constants.dart';
import 'package:exam_flutter/core/utils/validators.dart';
import 'package:exam_flutter/core/widgets/custom_button.dart';
import 'package:exam_flutter/core/widgets/custom_text_field.dart';
import 'package:exam_flutter/features/authentication/providers/auth_provider.dart';
import 'package:exam_flutter/features/authentication/widgets/auth_header.dart';

/// Forgot Password screen
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _emailVerified = false;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _verifyEmail() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez entrer votre email'),
          backgroundColor: AppConstants.errorRed,
        ),
      );
      return;
    }

    final emailValidation = Validators.validateEmail(_emailController.text);
    if (emailValidation != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailValidation),
          backgroundColor: AppConstants.errorRed,
        ),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final exists = await authProvider.checkEmailExists(_emailController.text);

    if (exists) {
      setState(() {
        _emailVerified = true;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email vérifié ! Veuillez entrer un nouveau mot de passe'),
            backgroundColor: AppConstants.successGreen,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aucun compte trouvé avec cet email'),
            backgroundColor: AppConstants.errorRed,
          ),
        );
      }
    }
  }

  Future<void> _handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      
      final success = await authProvider.resetPassword(
        email: _emailController.text,
        newPassword: _newPasswordController.text,
      );

      if (success && mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mot de passe réinitialisé avec succès !'),
            backgroundColor: AppConstants.successGreen,
            duration: Duration(seconds: 2),
          ),
        );
        
        // Navigate back to sign in after a short delay
        await Future.delayed(const Duration(seconds: 2));
        
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      } else if (mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Échec de la réinitialisation'),
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacing24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.spacing24),
                
                // Header
                FadeInDown(
                  child: const AuthHeader(
                    title: 'Mot de passe oublié ?',
                    subtitle: 'Ne vous inquiétez pas, nous allons vous aider',
                    icon: Icons.lock_reset_rounded,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing48),
                
                if (!_emailVerified) ...[
                  // Email field
                  FadeInLeft(
                    delay: const Duration(milliseconds: 100),
                    child: CustomTextField(
                      label: 'Email',
                      hint: 'votre@email.com',
                      prefixIcon: Icons.email_outlined,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing32),
                  
                  // Verify email button
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return CustomButton(
                          text: 'Vérifier l\'email',
                          onPressed: _verifyEmail,
                          isLoading: authProvider.isLoading,
                          icon: Icons.check_circle_outline,
                        );
                      },
                    ),
                  ),
                ] else ...[
                  // Email verified - show password reset fields
                  FadeInLeft(
                    child: Container(
                      padding: const EdgeInsets.all(AppConstants.spacing16),
                      decoration: BoxDecoration(
                        color: AppConstants.successGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                        border: Border.all(
                          color: AppConstants.successGreen.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppConstants.successGreen,
                          ),
                          const SizedBox(width: AppConstants.spacing12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Email vérifié',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppConstants.successGreen,
                                  ),
                                ),
                                Text(
                                  _emailController.text,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppConstants.darkText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing24),
                  
                  // New password field
                  FadeInRight(
                    delay: const Duration(milliseconds: 100),
                    child: CustomTextField(
                      label: 'Nouveau mot de passe',
                      hint: '••••••••',
                      prefixIcon: Icons.lock_outline,
                      controller: _newPasswordController,
                      validator: Validators.validatePassword,
                      isPassword: true,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing16),
                  
                  // Confirm new password field
                  FadeInLeft(
                    delay: const Duration(milliseconds: 200),
                    child: CustomTextField(
                      label: 'Confirmer le mot de passe',
                      hint: '••••••••',
                      prefixIcon: Icons.lock_outline,
                      controller: _confirmPasswordController,
                      validator: (value) => Validators.validatePasswordConfirmation(
                        value,
                        _newPasswordController.text,
                      ),
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  
                  const SizedBox(height: AppConstants.spacing32),
                  
                  // Reset password button
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return CustomButton(
                          text: 'Réinitialiser le mot de passe',
                          onPressed: _handleResetPassword,
                          isLoading: authProvider.isLoading,
                          icon: Icons.save,
                        );
                      },
                    ),
                  ),
                ],
                
                const SizedBox(height: AppConstants.spacing24),
                
                // Back to sign in link
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: const Text(
                        'Retour à la connexion',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
}
