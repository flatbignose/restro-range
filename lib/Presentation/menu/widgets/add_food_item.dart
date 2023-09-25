import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restro_range/Presentation/menu/controller/menu_controller.dart';
import 'package:restro_range/Presentation/waiters/screens/waiters.dart';
import 'package:restro_range/const/controllers.dart';

import '../../../const/colors.dart';
import '../../../const/utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/form_field.dart';

class AddFoodItem extends ConsumerStatefulWidget {
  final String categoryName;
  final String categoryId;
  const AddFoodItem(
      {required this.categoryName, required this.categoryId, super.key});

  @override
  ConsumerState<AddFoodItem> createState() => _AddFoodItemState();
}

class _AddFoodItemState extends ConsumerState<AddFoodItem> {
  File? image;

  void selectImage(ImageSource source) async {
    image = await pickImageFromGallery(context, source);
    Navigator.pop(context);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    addFoodItem() async {
      if (nameController.text.isNotEmpty &&
          infoController.text.isNotEmpty &&
          priceController.text.isNotEmpty) {
        Navigator.pop(context);
        await ref.read(menuControProvider).saveMenuItemtoFirebase(
              context: context,
              foodPic: image,
              foodPrice: priceController.text,
              foodName: nameController.text,
              foodInfo: infoController.text,
              categoryName: widget.categoryName,
              categoryId: widget.categoryId,
            );
        nameController.clear();
        priceController.clear();
        infoController.clear();
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
              Stack(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  CircleAvatar(
                    radius: 105,
                    backgroundColor: primColor,
                    child: image == null
                        ? const CircleAvatar(
                            radius: 97,
                            backgroundImage: AssetImage(
                                'asset/images/categories/biriyani.jpeg'),
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
                title: 'Enter ${widget.categoryName} Name',
                size: size,
                controller: nameController,
              ),
              CustomField(
                // maxlength: 2,
                keyboardType: TextInputType.number,
                obscure: false,
                visible: false,
                title: 'Enter Price',
                size: size,
                controller: priceController,
              ),
              CustomField(
                // maxlength: 10,
                obscure: false,
                visible: false,
                title: 'Enter ${widget.categoryName} Description',
                size: size,
                controller: infoController,
              ),
              CustomButton(
                size: size,
                buttonColor: primColor,
                title: 'Add ${widget.categoryName}',
                buttontextColor: backgroundColor,
                onPressed: () {
                  addFoodItem();
                },
              )
            ],
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


// CustomField(
//                 obscure: false,
//                 visible: false,
//                 title: 'Enter Food Name',
//                 size: size,
//                 controller: nameController,
//               ),
//               CustomField(
//                 obscure: false,
//                 visible: false,
//                 title: 'Enter Price',
//                 size: size,
//                 controller: priceController,
//               ),
//               CustomField(
//                 obscure: false,
//                 visible: false,
//                 title: 'Enter Food info',
//                 size: size,
//                 controller: infoController,
//               ),