import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/features/login/presentation/blocs/login_bloc.dart';
import 'package:isoule_ai/features/login/presentation/blocs/login_event.dart';
import 'package:isoule_ai/features/login/presentation/blocs/login_state.dart';
import 'package:isoule_ai/features/otp/presentation/screens/otp_screen.dart';
import 'package:isoule_ai/features/signup/presentation/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _onSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        backgroundColor: kBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 36),

                Text(
                  "Let's get started",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Enter your email to sign up or log in. We\'ll send you a code to verify.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: kGraySubTitle),
                ),

                const SizedBox(height: 32),

                Text(
                  'Email',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 10),

                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)),
                      );
                    }

                    if (state.isSuccess) {
                      // Navigate to OTP screen after a successful 'continue'.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OtpScreen(email: state.email),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => context.read<LoginBloc>().add(
                            EmailChanged(value),
                          ),
                          decoration: InputDecoration(
                            hintText: 'name@example.com',
                            filled: true,
                            fillColor: kComponentBackground,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        if (state.errorMessage != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            state.errorMessage!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        ],

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: state.isSubmitting
                                ? null
                                : () => context.read<LoginBloc>().add(
                                    ContinuePressed(),
                                  ),
                            child: state.isSubmitting
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text('Continue'),
                          ),
                        ),

                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: kGraySubTitle),
                    ),
                    GestureDetector(
                      onTap: _onSignUp,
                      child: Text(
                        'Sign up',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: kButtonColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: kGraySubTitle.withOpacity(0.4),
                        thickness: 1,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'or continue with',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: kGraySubTitle),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Divider(
                        color: kGraySubTitle.withOpacity(0.4),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialLoginButton(
                      icon: Icons.apple,
                      label: 'Apple',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Apple login not implemented'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    _SocialLoginButton(
                      icon: Icons.g_mobiledata,
                      label: 'Google',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Google login not implemented'),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Center(
                    child: Text(
                      'By continuing, you agree to our Terms and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: kGraySubTitle),
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

class _SocialLoginButton extends StatelessWidget {
  const _SocialLoginButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: kComponentBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: kTitleTextColor),
              const SizedBox(width: 10),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
