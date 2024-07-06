import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth_component.dart';
import '/main_component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: green),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
    }
  }

  textbutton(id) {
    return Container(
      alignment: (id == 1) ? Alignment.centerRight : null,
      child: TextButton(
        onPressed: () => (id == 1)
            ? Navigator.pushNamed(context, 'forgetPassword')
            : Navigator.pushNamedAndRemoveUntil(
                context, 'signUp', (route) => false),
        style: TextButton.styleFrom(foregroundColor: Colors.white),
        child: Text(
          (id == 1) ? "forgot password?" : "Create account",
          style:
              GoogleFonts.quicksand(color: green, fontWeight: FontWeight.bold),
        ),
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
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/pictures/green.svg',
                  width: 200,
                ),
                const SizedBox(height: 100),
                Text(
                  "Welcome back, you've been missed!",
                  style: GoogleFonts.quicksand(
                      fontSize: 18, fontWeight: FontWeight.bold),
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
                textbutton(1),
                const SizedBox(height: 30),
                const CElevatedButton(
                    text: "Sign in", backgroundColor: green, route: 'userInfo'),
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
                      "Not a member?",
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                    ),
                    textbutton(2),
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
