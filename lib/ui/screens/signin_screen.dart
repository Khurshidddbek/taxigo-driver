import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taxigo_driver/domain/states/auth_state.dart';
import 'package:taxigo_driver/ui/theme/app_colors.dart';
import 'package:taxigo_driver/ui/widgets/taxi_button.dart';

class SignInScreen extends StatefulWidget {
  static const String id = "signin";

  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                "Sign in as Driver",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Brand-Bold",
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // #textfields
              Form(
                key: read.signInformKey,
                child: Column(
                  children: [
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
                title: "LOGIN",
                color: AppColors.accentPurple,
                onPressed: () => read.signIn(context),
              ),

              const SizedBox(height: 25),

              // #button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Don't have an account? Sign up here",
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
