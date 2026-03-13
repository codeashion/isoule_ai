import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_bloc.dart';
import 'package:isoule_ai/features/dashboard/presentation/blocs/dashboard_event.dart';
import 'package:isoule_ai/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:isoule_ai/features/otp/presentation/blocs/otp_bloc.dart';
import 'package:isoule_ai/features/otp/presentation/blocs/otp_event.dart';
import 'package:isoule_ai/features/otp/presentation/blocs/otp_state.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final TextEditingController _pinController;

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpBloc(),
      child: Scaffold(
        backgroundColor: kBackground,
        appBar: AppBar(
          backgroundColor: kBackground,
          foregroundColor: kTitleTextColor,
          elevation: 0,
          leading: BackButton(color: kTitleTextColor),
          title: const Text('OTP'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BlocConsumer<OtpBloc, OtpState>(
              listener: (context, state) {
                if (state.errorMessage != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }

                if (state.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('OTP Verified (demo)')),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => DashboardBloc()..add(LoadDashboard()),
                        child: const DashboardScreen(),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'Check your email',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'We sent a verification code to',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: kGraySubTitle),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 32),

                    Center(
                      child: Pinput(
                        length: 4,
                        obscureText: true,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        controller: _pinController,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: kTitleTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            color: kComponentBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: kComponentBackground),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: kTitleTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            color: kComponentBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: kButtonColor),
                          ),
                        ),
                        onChanged: (value) =>
                            context.read<OtpBloc>().add(OtpCodeChanged(value)),
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the email? ",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: kGraySubTitle),
                        ),
                        GestureDetector(
                          onTap: state.canResend
                              ? () {
                                  context.read<OtpBloc>().add(
                                    OtpResendRequested(),
                                  );
                                }
                              : null,
                          child: Text(
                            state.canResend ? 'Resend' : 'Resend (wait)',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: state.canResend
                                      ? kButtonColor
                                      : kGraySubTitle,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: state.isSubmitting
                              ? null
                              : () {
                                  context.read<OtpBloc>().add(OtpSubmitted());
                                },
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
                              : const Text('Verify'),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
