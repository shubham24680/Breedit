import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';

import '../../main_component.dart';
import '../auth_component.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool obscure = true;

  Future signUp(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: green),
          );
        });

    if (_passwordController.text == _newPasswordController.text) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password don't match!")));
    }

    Navigator.pop(context);
  }

  textbutton(context) {
    return TextButton(
      onPressed: () =>
          Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false),
      // onPressed: () {
      //   Navigator.pushAndRemoveUntil(context,
      //       MaterialPageRoute(builder: (context) {
      //     return const LoginScreen();
      //   }), (route) => false);
      // },
      style: TextButton.styleFrom(foregroundColor: Colors.white),
      child: Text(
        "Sign in",
        style: GoogleFonts.quicksand(color: green, fontWeight: FontWeight.bold),
      ),
    );
  }

  divider() {
    return Expanded(
      child: Divider(
        thickness: 0.5,
        color: Colors.grey[400],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/pictures/green.svg',
                  width: 200,
                ),
                const SizedBox(height: 100),
                Text(
                  "You are just one step closer to us!",
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CTextField(
                  controller: _emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                CTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 10),
                CTextField(
                  controller: _newPasswordController,
                  hintText: "Confirm Password",
                  obscureText: obscure,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    child: Icon(
                      (obscure)
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: grey,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const CElevatedButton(
                    text: "Create account",
                    backgroundColor: green,
                    route: 'userInfo'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: subheading("Or continue with"),
                    ),
                    divider(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                    ),
                    textbutton(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
