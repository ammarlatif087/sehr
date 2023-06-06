// import 'package:sehr/app/index.dart';
// import 'package:sehr/presentation/view_models/auth_view_model.dart';

// import '../../common/app_button_widget.dart';
// import '../../common/text_field_widget.dart';
// import '../../common/top_back_button_widget.dart';
// import '../../src/index.dart';
// import '../../utils/utils.dart';

// class ForgotPassView extends StatelessWidget {
//   const ForgotPassView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = Provider.of<AuthViewModel>(context);
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Image.asset(
//               AppImages.pattern2,
//               color: ColorManager.primary.withOpacity(0.1),
//             ),
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const TopBackButtonWidget(),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: getProportionateScreenWidth(34),
//                     ),
//                     child: Form(
//                       key: viewModel.forgotPassFormKey,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           buildVerticleSpace(80),
//                           kTextBentonSansBold(
//                             'Forgot Password',
//                             fontSize: getProportionateScreenHeight(20),
//                           ),
//                           buildVerticleSpace(40),
//                           TextFieldWidget(
//                             controller: viewModel.newPasswordController,
//                             focusNode: viewModel.newPasswordFocusNode,
//                             keyboardType: TextInputType.visiblePassword,
//                             hintText: 'New Password',
//                             obscureText: viewModel.newPassObscureText,
//                             prefixIcon: Icon(
//                               Icons.lock_rounded,
//                               size: getProportionateScreenHeight(18),
//                               color: ColorManager.primaryLight,
//                             ),
//                             sufixIcon: IconButton(
//                               splashRadius: 1,
//                               onPressed: () => viewModel.showNewPass(),
//                               icon: Icon(
//                                 viewModel.loginPassObscureText
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                                 size: getProportionateScreenHeight(20),
//                                 color: ColorManager.textGrey.withOpacity(0.6),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'New Password is required';
//                               } else if (value.length < 8) {
//                                 return 'Password should be 8 charators minimum';
//                               }
//                               return null;
//                             },
//                             onFieldSubmit: (value) {
//                               Utils.fieldFocusChange(
//                                 context,
//                                 viewModel.newPasswordFocusNode,
//                                 viewModel.confirmNewPasswordFocusNode,
//                               );
//                             },
//                           ),
//                           buildVerticleSpace(20),
//                           TextFieldWidget(
//                             controller: viewModel.confirmNewPasswordController,
//                             focusNode: viewModel.confirmNewPasswordFocusNode,
//                             keyboardType: TextInputType.visiblePassword,
//                             hintText: 'Re-Enter New Password',
//                             obscureText: viewModel.confirnNewPassObscureText,
//                             prefixIcon: Icon(
//                               Icons.lock_rounded,
//                               size: getProportionateScreenHeight(18),
//                               color: ColorManager.primaryLight,
//                             ),
//                             sufixIcon: IconButton(
//                               splashRadius: 1,
//                               onPressed: () => viewModel.showConfirmNewPass(),
//                               icon: Icon(
//                                 viewModel.loginPassObscureText
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                                 size: getProportionateScreenHeight(20),
//                                 color: ColorManager.textGrey.withOpacity(0.6),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Confirm New Password is required';
//                               } else if (value !=
//                                   viewModel.newPasswordController.text) {
//                                 return 'Password did\'t match';
//                               }
//                               return null;
//                             },
//                           ),
//                           buildVerticleSpace(50),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: getProportionateScreenWidth(90),
//                             ),
//                             child: AppButtonWidget(
//                               ontap: () {},
//                               text: 'Next',
//                             ),
//                           ),
//                           buildVerticleSpace(50),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
