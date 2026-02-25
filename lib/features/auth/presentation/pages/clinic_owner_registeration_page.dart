import 'dart:io';
import 'package:beautygm/core/constants/app_assets.dart';
import 'package:beautygm/core/constants/app_text_styles.dart';
import 'package:beautygm/core/params/params.dart';
import 'package:beautygm/core/utils/validators.dart';
import 'package:beautygm/core/widgets/add_image_widget.dart';
import 'package:beautygm/core/widgets/custom_input_field.dart';
import 'package:beautygm/core/widgets/custom_scaffold.dart';
import 'package:beautygm/core/widgets/custom_scaffold_messenger.dart';
import 'package:beautygm/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:beautygm/features/auth/presentation/cubit/auth_states.dart';
import 'package:beautygm/features/auth/presentation/pages/sign_in_page.dart';
import 'package:beautygm/features/auth/presentation/widgets/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ClinicOwnerRegistrationPage extends StatefulWidget {
  const ClinicOwnerRegistrationPage({super.key});

  @override
  State<ClinicOwnerRegistrationPage> createState() =>
      _ClinicOwnerRegistrationPageState();
}

class _ClinicOwnerRegistrationPageState
    extends State<ClinicOwnerRegistrationPage> {
  final _businessController = TextEditingController();
  final _ownerController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _profileImage;
  File? _commercialImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickProfileImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() => _profileImage = File(pickedFile.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please enable photo access in Settings')),
        );
      }
    }
  }

  Future<void> _pickCommercialImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() => _commercialImage = File(pickedFile.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Please enable photo access in Settings')),
        );
      }
    }
  }

  void _submit() {
    if (_ownerController.text.trim().isEmpty) {
      CustomScaffoldMessenger().showFail("Owner name is required.");
      return;
    }

    if (!Validators.isValidEmail(_emailController.text.trim())) {
      CustomScaffoldMessenger().showFail("Please enter a valid email.");
      return;
    }

    if (!Validators.isValidPassword(_passwordController.text.trim())) {
      CustomScaffoldMessenger().showFail(
        "Password must be at least 6 characters.",
      );
      return;
    }

    if (!Validators.isPasswordsMatch(
      _passwordController.text.trim(),
      _confirmPasswordController.text.trim(),
    )) {
      CustomScaffoldMessenger().showFail(
        "Password and Confirm Password do not match.",
      );
      return;
    }

    if (_profileImage == null || _commercialImage == null) {
      CustomScaffoldMessenger().showFail("Please select both images.");
      return;
    }

    final params = SignupUserParams(
      fullName: _ownerController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      businessName: _businessController.text.trim(),
      profileImageUrl: _profileImage!,
      commercialImageUrl: _commercialImage!,
      type: "CO",
      isMale: null, // ⬅️ إرسال الجنس
    );

    context.read<AuthCubit>().signupUser(params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SignupUserSuccess) {
          CustomScaffoldMessenger().showSuccess(
            "Account created successfully!\nYou can login to your account.",
            duration: const Duration(seconds: 5),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInPage()),
            (route) => false,
          );
        }

        if (state is SignupUserFailed) {
          CustomScaffoldMessenger().showFail(state.errMessage);
        }
      },
      builder: (context, state) {
        final isLoading = state is SignupUserLoading;

        return CustomScaffold(
          safeTop: false,
          children: [
            const Text(
              "Welcome to BeautyGM 🎉",
              style: AppTextStyles.heading01SemiBold,
            ),
            Text(
              "Enter your info to create new account",
              style: AppTextStyles.paragraph02Regular.copyWith(
                color: const Color(0xFF78808B),
              ),
            ),
            SizedBox(height: 12.h),
            Center(
              child: Image.asset(
                AppAssets.frame,
                fit: BoxFit.cover,
                width: 300.w,
              ),
            ),
            SizedBox(height: 20.h),
            CustomInputField(
              label: "Business Name",
              hint: "Enter ...",
              controller: _businessController,
            ),
            SizedBox(height: 16.h),
            CustomInputField(
              label: "Owner’s Name",
              hint: "Enter ...",
              controller: _ownerController,
            ),
            SizedBox(height: 16.h),
            CustomInputField(
              label: "Email",
              hint: "Enter ...",
              controller: _emailController,
            ),
            SizedBox(height: 16.h),
            PhoneInputField(
              label: "Phone Number",
              controller: _phoneController,
            ),
            SizedBox(height: 16.h),
            AddImageWidget(
              title: "Commercial Registration",
              selectedImage: _commercialImage,
              onPressed: _pickCommercialImage,
            ),
            SizedBox(height: 16.h),
            AddImageWidget(
              title: "Profile Image",
              selectedImage: _profileImage,
              onPressed: _pickProfileImage,
            ),
            SizedBox(height: 16.h),
            CustomInputField(
              label: "Password",
              hint: "••••••••••••••••••",
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 16.h),
            CustomInputField(
              label: "Confirm Password",
              hint: "••••••••••••••••••",
              controller: _confirmPasswordController,
              obscureText: true,
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
              onPressed: isLoading ? null : _submit,
              style: isLoading
                  ? Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor: WidgetStateProperty.all(Colors.grey),
                      )
                  : Theme.of(context).elevatedButtonTheme.style,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("Continue"),
            ),
          ],
        );
      },
    );
  }
}
