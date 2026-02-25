import 'package:beautygm/core/constants/app_assets.dart';
import 'package:beautygm/core/constants/app_colors.dart';
import 'package:beautygm/core/constants/app_text_styles.dart';
import 'package:beautygm/core/widgets/custom_input_field.dart';
import 'package:beautygm/features/auth/presentation/widgets/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            const Text("Contact Us", style: AppTextStyles.paragraph01SemiBold),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.contactUsBackground,
                width: double.infinity,
                height: 175.h,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Us",
                      style: AppTextStyles.paragraph01SemiBold.copyWith(
                        color: AppColors.primary05,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: 32.w,
                      height: 2.h,
                      color: const Color(0xFFF8CF2C),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    CustomInputField(
                      label: "Owner's Name",
                      hint: "Mustafa Emad",
                      controller: _nameController,
                    ),
                    SizedBox(height: 16.h),
                    CustomInputField(
                      label: "Email",
                      hint: "mustafa@gmail.com",
                      controller: _emailController,
                    ),
                    SizedBox(height: 16.h),
                    PhoneInputField(
                      controller: _phoneController,
                      label: "Phone Number",
                    ),
                    SizedBox(height: 16.h),
                    CustomInputField(
                      label: "Your Message",
                      hint: "Enter your message here...",
                      controller: _messageController,
                      maxLines: 5,
                    ),
                    SizedBox(height: 24.h),
                    const Center(child: Text("GlowGuideSup@gmail.com")),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary05,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          "Send A Message",
                          style: AppTextStyles.paragraph02Regular.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
