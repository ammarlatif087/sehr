import 'package:flutter/material.dart';
import 'package:sehr/presentation/views/bottom_navigation/bottom_nav_view.dart';
import 'package:sehr/presentation/views/business_views/payment/payment_view.dart';
import 'package:sehr/presentation/views/customer_views/scanner/scanner_view.dart';
import 'package:sehr/presentation/views/drawer/custom_drawer.dart';
import 'package:sehr/presentation/views/profile/add_bio/add_business_details_view.dart';
import 'package:sehr/presentation/views/profile/add_bio/add_customer_bio_view.dart';
import 'package:sehr/presentation/views/profile/profile_complete_view.dart';
import 'package:sehr/presentation/views/profile/set_location_view.dart';
import 'package:sehr/presentation/views/profile/upload_profile_photo_view.dart';
import 'package:sehr/presentation/views/profile/varification_code_view.dart';

import '../src/index.dart';
import '../views/auth/login_view.dart';
import '../views/auth/signup_view.dart';
import '../views/onboarding/onboarding_view.dart';
import '../views/profile/add_bio/business_verification/business_verification_processing_view.dart';
import '../views/profile/add_bio/business_verification/business_verification_view.dart';
import '../views/profile/add_bio/business_verification/qr_business_view.dart';
import '../views/splash/splash_view.dart';

class Routes {
  static const String mainRoute = '/mainRoute';
  static const String splashRoute = '/';
  static const String onboardingRoute = '/onboarding';

  // Auth views
  static const String loginRoute = '/login';
  static const String signUpRoute = '/signUp';
  // static const String profileSelectionRoute = '/profileSelection';

  // Profile views
  static const String addCustomerBioRoute = '/addCustomerBio';
  static const String addBusinessBioRoute = '/addBusinessBio';
  static const String photoSelectionRoute = '/photoSelection';
  static const String setLocationRoute = '/setLocation';
  static const String verificationCodeRoute = '/verificationCode';
  static const String profileCompleteRoute = '/profileComplete';
  static const String businessVerificationRoute = '/businessVerification';
  static const String businessVerificationProcesingRoute =
      '/businessVerificationProcessing';
  static const String qrBusinessRoute = '/qrBusiness';

  // Customer Side Views
  static const String drawerRoute = '/drawer';
  static const String customerBottomNavRoute = '/customerBottomNav';
  static const String scannerRoute = '/scanner';
  static const String paymentRoute = '/payment';
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      // Auth Routes
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      // case Routes.profileSelectionRoute:
      //   return MaterialPageRoute(builder: (_) => const ProfileSelectionView());

      // Profile Routes
      case Routes.addCustomerBioRoute:
        return MaterialPageRoute(builder: (_) => const AddCustomerBioView());
      case Routes.addBusinessBioRoute:
        return MaterialPageRoute(
            builder: (_) => const AddBusinessDetailsView());
      case Routes.photoSelectionRoute:
        return MaterialPageRoute(
            builder: (_) => const UplaodProfilePhotoView());
      case Routes.setLocationRoute:
        // Map<String, dynamic> arguments =
        //     routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => const SetLocationView(
              // imageFile: arguments['image'],
              ),
        );
      case Routes.verificationCodeRoute:
        return MaterialPageRoute(builder: (_) => const VerificationCodeView());
      case Routes.profileCompleteRoute:
        return MaterialPageRoute(builder: (_) => const ProfileCompleteView());

      // Customer Side Views
      case Routes.drawerRoute:
        return MaterialPageRoute(
            builder: (_) => DrawerView(
                  pageindex: 0,
                ));
      case Routes.customerBottomNavRoute:
        return MaterialPageRoute(
            builder: (_) => BottomNavigationView(
                  pageindexview: 0,
                ));
      case Routes.scannerRoute:
        return MaterialPageRoute(builder: (_) => const ScannerView());

      // Business Side Views
      case Routes.businessVerificationRoute:
        return MaterialPageRoute(
            builder: (_) => const BusinessVerificationView());
      case Routes.businessVerificationProcesingRoute:
        return MaterialPageRoute(
            builder: (_) => const BusinessVerificationProcessingView());
      case Routes.qrBusinessRoute:
        return MaterialPageRoute(builder: (_) => const QrBusinessView());
      case Routes.paymentRoute:
        return MaterialPageRoute(
            builder: (_) => PaymentView(
                  datetime: "",
                  amount: "",
                ));
    }
    return _unDefinedRoute();
  }

  static Route<dynamic> _unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.undefinedRoute),
        ),
        body: const Center(
          child: Text(StringManager.noRouteFound),
        ),
      ),
    );
  }
}
