import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/colors.dart';

class CategoryCard extends ConsumerWidget {
  final String categoryName;
  final String categoryPic;
  final String categoryId;
  final String restroId;
  const CategoryCard({
    super.key,
    required this.size,
    required this.categoryName,
    required this.categoryPic,
    required this.categoryId,
    required this.restroId,
  });

  final Size size;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size.width * 0.35,
          height: size.height * 0.28,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(categoryPic),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken),
                  fit: BoxFit.cover),
              color: primColor,
              // borderRadius: radius10,
              border: Border.all(
                color: textColor,
                width: 8,
              )),
        ),
        Positioned(
          bottom: 20,
          child: Text(
            categoryName,
            style: TextStyle(
                fontSize: 20,
                // color: textColor,
                background: Paint()
                  ..strokeWidth = 30.0
                  ..color = Colors.white
                  ..style = PaintingStyle.stroke
                  ..strokeJoin = StrokeJoin.round
                // backgroundColor: textColor,
                ),
          ),
        ),
      ],
    );
  }
}
