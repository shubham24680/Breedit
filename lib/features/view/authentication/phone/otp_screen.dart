import 'package:breedit/services/auth_otp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:breedit/core/util/app_colors.dart';
import 'package:breedit/core/util/app_icon.dart';
import 'package:breedit/core/widgets/elevated_button.dart';
import 'package:breedit/core/widgets/text.dart';
import 'package:breedit/features/view/authentication/phone/resend_code.dart';
import 'package:breedit/features/view_model/auth_provider.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider prov = Provider.of(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IMAGE
                  image("assets/icons/shield.png"),
                  const SizedBox(height: 10),

                  // HEADING
                  const MerriWeather(
                    text: "Enter your verification code",
                    size: 20,
                    weight: FontWeight.w900,
                  ),

                  Wrap(
                    children: [
                      // SUBHEADING
                      Quicksand(
                        text:
                            "Sent to ${prov.countryCodeController.text} ${prov.phoneNumberController.text}",
                      ),
                      const SizedBox(width: 5),
                      const Quicksand(
                        text: "•",
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/phoneNumber'),
                        child: const Quicksand(
                          text: "Edit",
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // otp area and resend count down
                  const ResendCode(),
                ],
              ),

              // NAVIGATION BUTTON
              Column(
                children: [
                  Consumer<AuthProvider>(
                    builder: (context, value, child) {
                      return CElevatedButton(
                        backgroundColor: green.withOpacity(0.2),
                        onPressed: !value.resendCode
                            ? () => value.startResendTimer()
                            : null,
                        child: Quicksand(
                          text: "Resend",
                          color: black,
                          weight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  CElevatedButton(
                    backgroundColor: green,
                    onPressed: () {
                      OtpService.verifyCode(context, prov.otpController.text);
                    },
                    child: Quicksand(
                      text: "Confirm",
                      color: white,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
