import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taxigo_driver/domain/states/auth_state.dart';
import 'package:taxigo_driver/ui/screens/signin_screen.dart';
import 'package:taxigo_driver/ui/theme/app_colors.dart';
import 'package:taxigo_driver/ui/widgets/taxi_button.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "signup";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthState>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 70),

              // #logo
              SvgPicture.asset(
                "assets/Logo Files/For Web/svg/White logo - no background.svg",
                height: 200,
                width: 200,
              ),

              const SizedBox(height: 35),

              // #title
              const Text(
                "Create a Driver's account",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Brand-Bold",
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // #textfields
              Form(
                key: read.signUpformKey,
                child: Column(
                  children: [
                    // #fullname
                    TextFormField(
                      controller: read.nameController,
                      decoration: const InputDecoration(
                        labelText: "Fullname",
                      ),
                      textInputAction: TextInputAction.next,
                      validator: read.validateName,
                    ),

                    const SizedBox(height: 10),

                    // #email
                    TextFormField(
                      controller: read.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email address",
                      ),
                      textInputAction: TextInputAction.next,
                      validator: read.validateEmail,
                    ),

                    const SizedBox(height: 10),

                    // #phone
                    TextFormField(
                      controller: read.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Phone number",
                      ),
                      textInputAction: TextInputAction.next,
                      validator: read.validatePhone,
                    ),

                    const SizedBox(height: 10),

                    // #password
                    TextFormField(
                      controller: read.passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                      validator: read.validatePassword,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // #button
              TaxiButton(
                title: "REGISTER",
                color: AppColors.accentPurple,
                onPressed: () => read.signUp(context),
              ),

              const SizedBox(height: 25),

              // #button
              TextButton(
                onPressed: () => Navigator.pushNamed(context, SignInScreen.id),
                child: const Text(
                  "Already have a Driver account? Log in",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
