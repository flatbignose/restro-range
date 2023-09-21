import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restro_range/Presentation/waiters/controller/waiter_controller.dart';
import 'package:restro_range/const/controllers.dart';

import '../../const/colors.dart';
import '../../const/loader.dart';
import '../../const/utils.dart';
import 'custom_button.dart';
import 'form_field.dart';

class AddWaiter extends ConsumerStatefulWidget {
  static const routeName = 'add-waiter';
  const AddWaiter({super.key});

// final int index =2;
  @override
  ConsumerState<AddWaiter> createState() => _AddWaiterState();
}

class _AddWaiterState extends ConsumerState<AddWaiter> {
  File? image;
  void selectImage(ImageSource source) async {
    image = await pickImageFromGallery(context, source);
    Navigator.pop(context);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    addWaiter() async {
      if (nameController.text.isNotEmpty &&
          ageController.text.isNotEmpty &&
          idController.text.isNotEmpty  &&
          phoneController.text.isNotEmpty) {
        
        await ref.read(waiterControProvider).savewaiterInfo(
              context: context,
              waiterPic: image,
              waiterName: nameController.text,
              waiterAge: ageController.text,
              waiterPhone: phoneController.text,
              userId: idController.text,
            );
           
        nameController.clear();
        ageController.clear();
        phoneController.clear();
        idController.clear();
        restroController.clear();
      }
    }

    return WillPopScope(
      onWillPop: () async {
        nameController.clear();
        ageController.clear();
        phoneController.clear();
        idController.clear();
        restroController.clear();
        return true;
      },
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircleAvatar(
                      radius: 105,
                      backgroundColor: primColor,
                      child: image == null
                          ? const CircleAvatar(
                              radius: 97,
                              backgroundImage:
                                  AssetImage('asset/images/waiter.png'),
                            )
                          : CircleAvatar(
                              radius: 97, backgroundImage: FileImage(image!)),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          photoType(context);
                        },
                        child: const CircleAvatar(
                          radius: 37,
                          backgroundColor: primColor,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 32,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Color.fromARGB(255, 207, 199, 199),
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomField(
                  obscure: false,
                  visible: false,
                  title: 'Enter Name',
                  size: size,
                  controller: nameController,
                ),
                CustomField(
                  maxlength: 2,
                  keyboardType: TextInputType.number,
                  obscure: false,
                  visible: false,
                  title: 'Enter Age',
                  size: size,
                  controller: ageController,
                ),
                CustomField(
                  maxlength: 10,
                  keyboardType: TextInputType.phone,
                  obscure: false,
                  visible: false,
                  title: 'Enter Phone Number',
                  size: size,
                  controller: phoneController,
                ),
                CustomField(
                  obscure: false,
                  visible: false,
                  title: 'Enter UserId',
                  size: size,
                  controller: idController,
                ),
                CustomButton(
                  size: size,
                  buttonColor: primColor,
                  title: 'Add Waiter',
                  buttontextColor: backgroundColor,
                  onPressed: () {
                    addWaiter();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> photoType(BuildContext ctx) async {
    showModalBottomSheet(
      context: ctx,
      builder: (ctx1) => Container(
        height: 100,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      selectImage(ImageSource.camera);
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: primColor,
                      child: Icon(
                        Icons.camera_alt,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      selectImage(ImageSource.gallery);
                    },
                    child: const CircleAvatar(
                      backgroundColor: primColor,
                      radius: 30,
                      child: Icon(
                        Icons.photo_size_select_actual_outlined,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Camera',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
