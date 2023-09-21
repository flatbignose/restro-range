// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../const/colors.dart';
import '../../../const/controllers.dart';
import '../../../const/utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/form_field.dart';
import '../controller/waiter_controller.dart';

class ScreenEditProfile extends ConsumerStatefulWidget {
  final String waiterName;
  final String waiterAge;
  final String waiterPic;
  final String waiterId;
  final String waiterPhone;
  final String restroId;
  final Timestamp joinDate;
  const ScreenEditProfile({
    super.key,
    required this.waiterName,
    required this.waiterAge,
    required this.waiterPic,
    required this.waiterId,
    required this.waiterPhone,
    required this.restroId,
    required this.joinDate,
  });

  @override
  ConsumerState<ScreenEditProfile> createState() => _ScreenEditProfileState();
}

class _ScreenEditProfileState extends ConsumerState<ScreenEditProfile> {
  File? image;

  void selectImage(ImageSource source) async {
    image = await pickImageFromGallery(context, source);
    Navigator.pop(context);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    nameController = TextEditingController(text: widget.waiterName);
    ageController = TextEditingController(text: widget.waiterAge);
    phoneController = TextEditingController(text: widget.waiterPhone);
    idController = TextEditingController(text: widget.waiterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    editWaiter() async {
      if (nameController.text.isNotEmpty &&
          ageController.text.isNotEmpty &&
          idController.text.isNotEmpty &&
          restroController.text.isNotEmpty &&
          phoneController.text.isNotEmpty) {
        await ref.read(waiterControProvider).savewaiterInfo(
              context: context,
              waiterPic: image,
              waiterName: nameController.text,
              waiterAge: ageController.text,
              waiterPhone: phoneController.text,
              userId: idController.text,
            );
        Navigator.pop(context);
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
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
                            ? CircleAvatar(
                                radius: 97,
                                backgroundImage: NetworkImage(widget.waiterPic))
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
                    title: 'Edit Waiter',
                    buttontextColor: backgroundColor,
                    onPressed: () async {
                      await editWaiter();
                      print('asdfasd');
                    },
                  )
                ],
              ),
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
