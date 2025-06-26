import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:juyelari/Features/Screens/bottom_bar/bottom_bar_view.dart';
import 'package:juyelari/Features/Screens/dashboard_screen/dashboard_screen.dart';
import 'package:juyelari/Features/Screens/forgot_password/create_password/create_password_screen.dart';
import 'package:juyelari/Features/Screens/forgot_password/forgot_password.dart';
import 'package:juyelari/Features/Screens/login/login_view.dart';
import 'package:juyelari/Features/Screens/my_cart/my_cart_screen.dart';
import 'package:juyelari/Features/Screens/on_boarding/on_boarding_screen.dart';
import 'package:juyelari/Features/Screens/otp_verification/otp_verification_screen.dart';
import 'package:juyelari/Features/Screens/product_screen/product_screen.dart';
import 'package:juyelari/Features/Screens/review_order_details/review_order_details_screen.dart';
import 'package:juyelari/Features/Screens/sign_up/sign_up_view.dart';
import 'package:juyelari/Features/res/routes/routes_name.dart';

class Routes {
  static appRoutes() => [
        GetPage(
            name: RoutesName.onboardingscreen,
            page: () => const OnBoardingScreen()),
        GetPage(name: RoutesName.loginview, page: () => const LoginView()),
        GetPage(name: RoutesName.signupview, page: () => SignUpView()),
        GetPage(
            name: RoutesName.forgotpassword,
            page: () => const ForgotPassword()),
        GetPage(
            name: RoutesName.otpverficationview,
            page: () => const OtpVerificationScreen()),
        GetPage(
            name: RoutesName.dashboardscreen,
            page: () => const DashboardScreen()),
        GetPage(
            name: RoutesName.productscreen, page: () => const ProductScreen()),
        GetPage(
          name: RoutesName.createpasswordscreen,
          page: () => const CreatePasswordScreen(),
        ),
        GetPage(
          name: RoutesName.revieworderdetailsscreen,
          page: () => const ReviewOrderDetailsScreen(),
        ),
        GetPage(name: RoutesName.mycartscreen, page: () => const MyCartScreen()),
         GetPage(name: RoutesName.bottombarview, page: () => const BottomBarView())
      ];
}
