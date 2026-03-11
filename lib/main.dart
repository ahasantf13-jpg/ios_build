import 'package:beautygm/core/layouts/auth_layout.dart';
import 'package:beautygm/core/services/service_locator.dart';
import 'package:beautygm/core/themes/app_theme.dart';
import 'package:beautygm/core/widgets/custom_scaffold_messenger.dart';
import 'package:beautygm/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:beautygm/features/clinics/presentation/cubit/clinics_cubit.dart';
import 'package:beautygm/features/locations/presentation/cubit/locations_cubit.dart';
import 'package:beautygm/features/offers/presentation/cubit/offers_cubit.dart';
import 'package:beautygm/features/password/presentation/cubit/password_cubit.dart';
import 'package:beautygm/features/profile/presentation/cubit/account_details_cubit.dart';
import 'package:beautygm/features/reviews/presentation/cubit/reviews_clinic_i_d_cubit.dart';
import 'package:beautygm/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CustomScaffoldMessenger _scaffoldMessenger = CustomScaffoldMessenger();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ClinicsCubit()..getAllClinics()),
        BlocProvider(
          create: (context) => AccountDetailsCubit()..fetchAccountDetails(),
        ),
        BlocProvider(create: (context) => ReviewsCubit()..getAllReviews()),
        BlocProvider(create: (context) => ReviewsClinicIDCubit()),
        BlocProvider(create: (context) => OffersCubit()..getAllOfferss()),
        BlocProvider(create: (context) => LocationsCubit()..getAllLocations()),
        BlocProvider(create: (context) => PasswordCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BeautyGM',
            theme: appTheme,
            scaffoldMessengerKey: _scaffoldMessenger.messengerKey,
            home: child,
          );
        },
        child: const AuthLayout(),
      ),
    );
  }
}
