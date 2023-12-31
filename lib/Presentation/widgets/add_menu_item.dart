import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restro_range/Presentation/menu/controller/menu_controller.dart';

import '../../const/colors.dart';
import '../../const/controllers.dart';
import '../../const/size_radius.dart';
import '../../const/utils.dart';
import '../screens/home.dart';
import 'custom_button.dart';
import 'form_field.dart';

class AddMenuItem extends ConsumerStatefulWidget {
  static const routeName = '/addMenu';
  const AddMenuItem({super.key});

  @override
  ConsumerState<AddMenuItem> createState() => _AddMenuItemState();
}

class _AddMenuItemState extends ConsumerState<AddMenuItem> {
  File? image;
  void selectImage(ImageSource source) async {
    image = (await pickImageFromGallery(context, source));
    Navigator.pop(context);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    addCategory() async {
      if (nameController.text.isNotEmpty) {
        await ref.read(menuControProvider).addCategory(
              context: context,
              categoryPic: image,
              categoryName: nameController.text,
            );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScreenHome(),
            ));
        nameController.clear();
      }
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              height20,
              Stack(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CircleAvatar(
                    radius: 105,
                    backgroundColor: primColor,
                    child: image == null
                        ? const CircleAvatar(
                            radius: 97,
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1555244162-803834f70033?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjBmb29kfGVufDB8fDB8fHww&w=1000&q=80'),
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
                title: 'Enter Category Name',
                size: size,
                controller: nameController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: CustomButton(
                  size: size,
                  buttonColor: primColor,
                  title: 'Confirm',
                  buttontextColor: backgroundColor,
                  onPressed: addCategory,
                ),
              ),
              height20,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> photoType(BuildContext ctx) async {
    showModalBottomSheet(
      isScrollControlled: true,
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
