import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/features/signup/presentation/blocs/signup_bloc.dart';
import 'package:isoule_ai/features/signup/presentation/blocs/signup_event.dart';
import 'package:isoule_ai/features/signup/presentation/blocs/signup_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _dobController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickDob(BuildContext context, DateTime? initialDate) async {
    final bloc = context.read<SignupBloc>();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime(now.year - 20),
      firstDate: DateTime(now.year - 120),
      lastDate: now,
    );

    if (picked != null && mounted) {
      bloc.add(DobChanged(picked));
    }
  }

  Future<void> _pickImage() async {
    final result = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 600,
    );

    if (result != null) {
      setState(() {
        _pickedImage = File(result.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupBloc(),
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
                  'Profile setup',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Help us get to know you better by setting up your profile details.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: kGraySubTitle),
                ),

                const SizedBox(height: 32),

                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 44,
                          backgroundColor: kComponentBackground,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage!)
                              : null,
                          child: _pickedImage == null
                              ? Icon(
                                  Icons.person,
                                  size: 44,
                                  color: kGraySubTitle,
                                )
                              : null,
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: kButtonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                BlocConsumer<SignupBloc, SignupState>(
                  listener: (context, state) {
                    if (state.errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage!)),
                      );
                    }

                    if (state.isSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile setup complete (demo)'),
                        ),
                      );
                    }

                    // Keep the DOB field in sync with state.
                    if (state.dob != null) {
                      _dobController.text =
                          '${state.dob!.month.toString().padLeft(2, '0')}/${state.dob!.day.toString().padLeft(2, '0')}/${state.dob!.year}';
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel(context, 'Full Name'),
                            const SizedBox(height: 10),
                            _buildTextField(
                              context,
                              hint: 'Enter your full name',
                              onChanged: (value) => context
                                  .read<SignupBloc>()
                                  .add(FullNameChanged(value)),
                            ),

                            const SizedBox(height: 20),
                            _buildFieldLabel(context, 'Nickname'),
                            const SizedBox(height: 10),
                            _buildTextField(
                              context,
                              hint: 'Enter a nickname',
                              onChanged: (value) => context
                                  .read<SignupBloc>()
                                  .add(NicknameChanged(value)),
                            ),

                            const SizedBox(height: 20),
                            _buildFieldLabel(context, 'Date of Birth'),
                            const SizedBox(height: 10),
                            _buildTextField(
                              context,
                              controller: _dobController,
                              hint: 'MM/DD/YYYY',
                              readOnly: true,
                              onTap: () => _pickDob(context, state.dob),
                              suffixIcon: const Icon(
                                Icons.calendar_today_outlined,
                                size: 20,
                                color: kGraySubTitle,
                              ),
                            ),

                            const SizedBox(height: 20),
                            _buildFieldLabel(context, 'Email Address'),
                            const SizedBox(height: 10),
                            _buildTextField(
                              context,
                              hint: 'name@example.com',
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => context
                                  .read<SignupBloc>()
                                  .add(EmailChanged(value)),
                            ),

                            const SizedBox(height: 20),
                            _buildFieldLabel(context, 'Phone Number'),
                            const SizedBox(height: 10),
                            _buildTextField(
                              context,
                              hint: '000-000-0000',
                              keyboardType: TextInputType.phone,
                              onChanged: (value) => context
                                  .read<SignupBloc>()
                                  .add(PhoneChanged(value)),
                              prefix: CountryCodePicker(
                                onChanged: (country) {
                                  context.read<SignupBloc>().add(
                                    CountryChanged(
                                      countryCode: country.dialCode ?? '',
                                      // countryFlagUri: country.flagUri ?? '',
                                    ),
                                  );
                                },
                                initialSelection: state.countryCode,
                                showCountryOnly: false,
                                showFlag: true,
                                showFlagDialog: true,
                                alignLeft: false,
                                padding: EdgeInsets.zero,
                              ),
                            ),

                            const SizedBox(height: 32),

                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: state.isSubmitting
                                    ? null
                                    : () => context.read<SignupBloc>().add(
                                        SignupSubmitted(),
                                      ),
                                child: state.isSubmitting
                                    ? const SizedBox(
                                        height: 18,
                                        width: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                        ),
                                      )
                                    : const Text('Continue'),
                              ),
                            ),

                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(BuildContext context, String label) {
    return Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String hint,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    Widget? prefix,
    ValueChanged<String>? onChanged,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kComponentBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (prefix != null) prefix,
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              onChanged: onChanged,
              onTap: onTap,
              readOnly: readOnly,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                suffixIcon: suffixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: suffixIcon,
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 24,
                  minHeight: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
