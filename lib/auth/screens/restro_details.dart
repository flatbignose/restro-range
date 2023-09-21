import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restro_range/auth/controllers/auth_controller.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/controllers.dart';
import 'package:restro_range/const/lists.dart';
import 'package:restro_range/const/size_radius.dart';
import 'package:restro_range/const/utils.dart';

import '../../Presentation/widgets/custom_button.dart';
import '../../Presentation/widgets/form_field.dart';
import '../../const/loader.dart';

class ScreenRestroDetails extends ConsumerStatefulWidget {
  static const routeName = '/restroDetails';
  const ScreenRestroDetails({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScreenRestroDetailsState();
}

class _ScreenRestroDetailsState extends ConsumerState<ScreenRestroDetails> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    closeDialog() {
      Navigator.pop(context);
    }

    void selectImage(ImageSource source) async {
      image = await pickImageFromGallery(context, source);
      closeDialog();
      setState(() {});
    }

    final resControlList = ref.watch(resDetailsControlProvider);
    addUserDetails() async {
      String name = nameController.text;
      String owner = resControlList[1].text;
      String address = resControlList[2].text;
      String phoneNumber = resControlList[3].text;

      if (name.isNotEmpty &&
          owner.isNotEmpty &&
          address.isNotEmpty &&
          phoneNumber.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => const Loader(title: 'Adding Details...'),
        );
        await ref.read(authContollerProvider).saveRestroInfo(
              context: context,
              restroName: name,
              owner: owner,
              address: address,
              phoneNumber: phoneNumber,
              restroPic: image,
            );
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
            )),
        title: const Text(
          'Add Restaurant Details',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ListView(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: size.height / 5,
                        decoration: BoxDecoration(
                            borderRadius: radius20,
                            border: Border.all(color: borderColor, width: 5),
                            image: image == null
                                ? DecorationImage(
                                    image: const AssetImage(
                                        'asset/images/restro_upload.jpg'),
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: FileImage(image!),
                                    fit: BoxFit.cover)),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                elevation: 5,
                                backgroundColor: textColor,
                                content: const Text(
                                  'Select Landscape photos as the image will be cropped to 16:9 ratio',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 150),
                                        width: size.width / 8,
                                        height: size.width / 8,
                                        decoration: BoxDecoration(
                                          color: backgroundColor,
                                          borderRadius: radius10,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              offset: const Offset(4.0, 4.0),
                                              blurRadius: 6.0,
                                              spreadRadius: 2.0,
                                            ),
                                          ],
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              selectImage(ImageSource.camera);
                                            },
                                            icon: const Icon(
                                              Icons.camera_alt_rounded,
                                              color: primColor,
                                            )),
                                      ),
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 150),
                                        width: size.width / 8,
                                        height: size.width / 8,
                                        decoration: BoxDecoration(
                                          color: backgroundColor,
                                          borderRadius: radius10,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              offset: const Offset(4.0, 4.0),
                                              blurRadius: 6.0,
                                              spreadRadius: 2.0,
                                            ),
                                          ],
                                        ),
                                        child: IconButton(
                                            onPressed: () {
                                              selectImage(ImageSource.gallery);
                                            },
                                            icon: const Icon(
                                              Icons.photo,
                                              color: primColor,
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Visibility(
                          visible: true,
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width / 3,
                            height: size.height * 0.05,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: borderColor, width: 2),
                                borderRadius: radius10,
                                color: Colors.black.withOpacity(0.5)),
                            child: const Text(
                              'Change Cover',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  height10,
                  Column(
                    children: List.generate(4, (index) {
                      return CustomField(
                          keyboardType: index == 3
                              ? TextInputType.phone
                              : TextInputType.text,
                          visible: false,
                          obscure: false,
                          controller: resControlList[index],
                          size: size,
                          title: ConstantLists.restroHintList[index]);
                    }),
                  ),
                ],
              ),
              Positioned(
                right: 10,
                bottom: 20,
                child: CustomButton(
                  size: size,
                  buttonColor: primColor,
                  title: 'Confirm',
                  buttontextColor: backgroundColor,
                  onPressed: () {
                    addUserDetails();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
