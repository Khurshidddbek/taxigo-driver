import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:taxigo_driver/domain/states/profile_state.dart';
import 'package:taxigo_driver/ui/theme/app_colors.dart';
import 'package:taxigo_driver/ui/widgets/taxi_button.dart';

class VehicleInfoScreen extends StatefulWidget {
  const VehicleInfoScreen({super.key});

  @override
  State<VehicleInfoScreen> createState() => _VehicleInfoScreenState();
}

class _VehicleInfoScreenState extends State<VehicleInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<ProfileState>();

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
                "Enter vehicle details",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Brand-Bold",
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // #textfields
              Form(
                key: read.formKey,
                child: Column(
                  children: [
                    // #model
                    TextFormField(
                      controller: read.modelController,
                      decoration: const InputDecoration(
                        labelText: "Car model",
                      ),
                      textInputAction: TextInputAction.next,
                      validator: read.simpleValidator,
                    ),

                    const SizedBox(height: 10),

                    // #color
                    TextFormField(
                      controller: read.colorController,
                      decoration: const InputDecoration(
                        labelText: "Car color",
                      ),
                      textInputAction: TextInputAction.next,
                      validator: read.simpleValidator,
                    ),

                    const SizedBox(height: 10),

                    // #number
                    TextFormField(
                      controller: read.carNumberController,
                      decoration: const InputDecoration(
                        labelText: "Vehicle number",
                      ),
                      textInputAction: TextInputAction.next,
                      validator: read.simpleValidator,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // #button
              TaxiButton(
                title: "PROCEED",
                color: AppColors.green,
                onPressed: () => read.updateVehicleInfo(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
