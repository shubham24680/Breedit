import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main_component.dart';
import 'auth_component.dart';
import 'otp_screen.dart';

class CreateAccount extends StatefulWidget {
  static String verify = "";

  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  late TextEditingController countryCode;
  late TextEditingController phoneNumber;
  bool active = false;

  @override
  void initState() {
    countryCode = TextEditingController(text: "+91");
    phoneNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryCode.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  showCountryCodePicker() {
    return showCountryPicker(
      context: context,
      useSafeArea: true,
      showPhoneCode: true,
      favorite: ["IN"],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: MediaQuery.of(context).size.height,
        borderRadius: BorderRadius.circular(0),
        flagSize: 20,
        textStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
        searchTextStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
        inputDecoration: InputDecoration(
          hintText: "Search countries",
          hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: black,
              width: 2,
            ),
          ),
        ),
      ),
      onSelect: (country) {
        countryCode.text = "+${country.phoneCode}";
      },
    );
  }

  _launchURL() async {
    Uri uri = Uri.parse(
        'https://hingeapp.zendesk.com/hc/en-us/articles/360034066073-How-do-I-change-my-phone-number');
    if (!await launchUrl(uri)) {
      throw Exception("Could not launch $uri");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IMAGE
                  image("assets/icons/phone.png"),
                  const SizedBox(height: 20),

                  // HEADING
                  heading("What's your phone number?"),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      // COUNTRY CODE
                      Expanded(
                        child: CTextField(
                          onTap: () => showCountryCodePicker(),
                          controller: countryCode,
                          readOnly: true,
                          textAlign: TextAlign.end,
                          suffixIcon:
                              const Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                      ),
                      const SizedBox(width: 10),

                      // PHONE NUMBER
                      Expanded(
                        flex: 2,
                        child: CTextField(
                          onChanged: (value) {
                            setState(() {
                              active = value.length == 10;
                            });
                          },
                          controller: phoneNumber,
                        ),
                      ),
                    ],
                  ),

                  // SUB HEADING
                  subheading(
                      "Breedit will send you a text with a verification code."
                      " Message and data rates may apply."),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // BOTTOM URL
                  BottomText(
                      onTap: () => _launchURL(),
                      text: "What if my number changes?"),

                  // NAVIGATION BUTTON
                  authElevatedButton(
                    context,
                    active
                        ? () {
                            sendCode(countryCode.text, phoneNumber.text);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTPScreen(
                                    countryCode.text,
                                    phoneNumber.text,
                                  ),
                                ),
                                (route) => false);
                          }
                        : null,
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
