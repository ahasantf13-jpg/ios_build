import 'dart:io';
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

class UserRegisterationPage extends StatefulWidget {
  const UserRegisterationPage({super.key});

  @override
  State<UserRegisterationPage> createState() => _UserRegisterationPageState();
}

class _UserRegisterationPageState extends State<UserRegisterationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  File? _profileImage;
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

  void submit() {
    if (nameController.text.trim().isEmpty) {
      CustomScaffoldMessenger().showFail("Full name is required");
      return;
    }

    if (!Validators.isValidEmail(emailController.text.trim())) {
      CustomScaffoldMessenger().showFail("Please enter a valid email.");
      return;
    }

    if (!Validators.isValidPassword(passwordController.text.trim())) {
      CustomScaffoldMessenger().showFail(
        "Password must be at least 6 characters.",
      );
      return;
    }

    if (!Validators.isPasswordsMatch(
      passwordController.text.trim(),
      confirmPasswordController.text.trim(),
    )) {
      CustomScaffoldMessenger().showFail(
        "Password and Confirm Password do not match.",
      );
      return;
    }

    final params = SignupUserParams(
      fullName: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      type: "U",
      phoneNumber: phoneController.text.trim(),
      businessName: "",
      commercialImageUrl: null,
      profileImageUrl: _profileImage,
      isMale: null,
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
            SizedBox(height: 40.h),

            // FULL NAME
            CustomInputField(
              label: "Full Name",
              hint: "Enter ...",
              controller: nameController,
            ),
            SizedBox(height: 16.h),

            // EMAIL
            CustomInputField(
              label: "Email",
              hint: "Enter ...",
              controller: emailController,
            ),
            SizedBox(height: 16.h),

            // PHONE
            PhoneInputField(label: "Phone Number", controller: phoneController),

            AddImageWidget(
              title: "Profile Image",
              selectedImage: _profileImage,
              onPressed: _pickProfileImage,
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(height: 8.h),

            SizedBox(height: 16.h),

            // PASSWORD
            CustomInputField(
              label: "Password",
              hint: "••••••••••••",
              controller: passwordController,
              obscureText: true,
            ),
            SizedBox(height: 16.h),

            // CONFIRM PASSWORD
            CustomInputField(
              label: "Confirm Password",
              hint: "••••••••••••",
              controller: confirmPasswordController,
              obscureText: true,
            ),
            SizedBox(height: 100.h),

            // SUBMIT BUTTON
            ElevatedButton(
              onPressed: isLoading ? null : submit,
              style: isLoading
                  ? Theme.of(context).elevatedButtonTheme.style!.copyWith(
                        backgroundColor: WidgetStateProperty.all(Colors.grey),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                        ),
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
