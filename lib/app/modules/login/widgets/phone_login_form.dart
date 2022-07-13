import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:uiam_business/app/data/enums/variant_button_size.dart';
import 'package:uiam_business/app/global/animations/fade_in_animation.dart';
import '../../../global/widgets/backdrop_progress_button.dart';
import '../controllers/login_controller.dart';
import 'otp_field.dart';
import '../../../global/widgets/backdrop_button.dart';
import '../../../global/widgets/backdrop_text_field.dart';
import '../../../global/widgets/drop_shadow.dart';
import '../../../../core/values/consts.dart';

class PhoneLoginForm extends StatelessWidget {
  PhoneLoginForm({Key? key}) : super(key: key);
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return AuthFlowBuilder<PhoneAuthController>(onComplete: (credential) {
      print("***********************************");
    }, listener: (oldState, newState, controller) {
      if (newState is SMSCodeSent) {
        if (loginController.completer != null &&
            loginController.completer?.isCompleted != true) {
          loginController.completer?.complete(true);
        }
      } else if (newState is PhoneVerificationFailed) {
        print("!!!!!!!!!!!PHONE FAILED!!!!!!!!!!!");
        if (loginController.completer != null &&
            loginController.completer?.isCompleted != true) {
          loginController.completer?.complete(false);
        }
        if (loginController.isVerifying == true) {
          loginController.isVerifying = false;
        }
        Get.snackbar(
          'Error',
          "Phone Number Verification Failed",
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
        );
      } else if (newState is AuthFailed) {
        print("########ERROR########");
        if (loginController.completer != null &&
            loginController.completer?.isCompleted != true) {
          loginController.completer?.complete(false);
        }

        if (loginController.isVerifying == true) {
          loginController.otpFieldController.clear();
          loginController.backdropProgressButtonController?.reverse();
          controller.reset();
          loginController.isVerifying = false;
        }

        Get.snackbar(
          'Error',
          "Auth Failed",
          icon: const Icon(
            Icons.error,
            color: Colors.red,
          ),
        );
      } else if (newState is PhoneVerified) {
        print("@@@@@@@@@@@@@@@VERIFIED@@@@@@@@@@@@@@@@@@@@");
        if (loginController.completer != null &&
            loginController.completer?.isCompleted != true) {
          loginController.completer?.complete(true);
        }
        if (loginController.isVerifying == true) {
          loginController.isVerifying = false;
        }
        Get.snackbar(
          'Success',
          "Phone Number Verified",
          icon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      }
    }, builder: (context, state, controller, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedBuilder(
            animation: loginController.fadeAnimation1,
            builder: (context, child) => IgnorePointer(
              ignoring: loginController.fadeAnimation1.value == 0,
              child: Opacity(
                opacity: loginController.fadeAnimation1.value,
                child: child,
              ),
            ),
            child: Column(
              children: [
                BackdropTextField(
                  icon: Icons.phone,
                  hintText: 'Phone Number',
                  prefixText: '+91',
                  controller: loginController.phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(height: dSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BackdropProgressButton(
                      size: VariantButtonSize.large,
                      width: hSize / 2,
                      content: "SEND OTP",
                      onCompleted: () {
                        loginController.slideFadeController.forward();
                      },
                      onTap: () async {
                        HapticFeedback.lightImpact();
                        final phone = loginController.phoneController.text;
                        if (phone.length == 10) {
                          loginController.completer = Completer();
                          controller.acceptPhoneNumber('+91' + phone);
                          return await loginController.completer?.future;
                        } else {
                          Get.snackbar(
                            "Error",
                            "Invalid Phone Number",
                            colorText: Get.theme.colorScheme.error,
                            icon: const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: dSpace),
          AnimatedBuilder(
            animation: loginController.fadeAnimation2,
            builder: (context, child) => IgnorePointer(
              ignoring: loginController.fadeAnimation2.value == 0,
              child: Opacity(
                opacity: loginController.fadeAnimation2.value,
                child: child,
              ),
            ),
            child: Column(
              children: [
                BackdropProgressButton(
                  controller: loginController.backdropProgressButtonController,
                  size: VariantButtonSize.large,
                  content: Icons.arrow_back_rounded,
                  onTap: () async {
                    HapticFeedback.lightImpact();
                    loginController.slideFadeController.reverse();
                  },
                ),
                const SizedBox(height: dSpace / 2),
                Text(
                  "OTP",
                  style: TextStyle(
                    color: Get.theme.colorScheme.onBackground.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: dSpace / 2),
                OTPTextField(
                    controller: loginController.otpFieldController,
                    length: 6,
                    width: 300,
                    onCompleted: (value) {
                      try {
                        controller.verifySMSCode(value);
                        loginController.backdropProgressButtonController
                            ?.forward();
                        loginController.isVerifying = true;
                      } catch (e) {
                        print(e);
                      }
                    },
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    otpFieldStyle: OtpFieldStyle(
                      borderColor: Colors.transparent,
                      enabledBorderColor: Color.fromARGB(0, 132, 128, 128),
                      focusBorderColor:
                          Get.theme.colorScheme.onBackground.withOpacity(.5),
                    ),
                    textFieldAlignment: MainAxisAlignment.center,
                    parent: (child) {
                      return DropShadow(
                        blurRadius: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaY: 15,
                              sigmaX: 15,
                            ),
                            child: Container(
                              height: vSize,
                              width: vSize,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Get.theme.colorScheme.onBackground
                                    .withOpacity(.05),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: child,
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      );
    });
  }
}
