import 'package:flutter/material.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/lists.dart';
import 'package:restro_range/const/size_radius.dart';
import 'package:restro_range/widgets/custom_button.dart';
import 'package:restro_range/widgets/form_field.dart';

import 'home.dart';

class ScreenRestroDetails extends StatelessWidget {
  const ScreenRestroDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: textColor,
            )),
        title: const Text(
          'Add Restaurant Details',
          style: TextStyle(fontSize: 20, color: backgroundColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: ListView(
            children: [
              ImageUpload(size: size),
              height10,
              Column(
                children: List.generate(3, (index) {
                  return CustomField(size: size, title: RestroHintList[index]);
                }),
              ),
              height20,
              height20,
              CustomButton(
                size: size,
                buttonColor: primColor,
                title: 'Confirm',
                buttontextColor: backgroundColor,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenHome(),
                      ),
                      (route) => false);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImageUpload extends StatelessWidget {
  const ImageUpload({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size.height / 5,
          decoration: BoxDecoration(
              borderRadius: radius20,
              border: Border.all(color: borderColor, width: 5),
              image: DecorationImage(
                  image: const AssetImage('asset/images/restro_upload.jpg'),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.darken),
                  fit: BoxFit.cover)),
        ),
        Container(
          alignment: Alignment.center,
          width: size.width / 3,
          height: size.height * 0.05,
          decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
              borderRadius: radius10,
              color: Colors.black.withOpacity(0.5)),
          child: const Text(
            'Change Cover',
            style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
