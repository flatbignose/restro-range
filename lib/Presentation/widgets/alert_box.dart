// import 'package:flutter/material.dart';

// class AlertWidget extends StatelessWidget {
//   const AlertWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return showDialog(
//                       context: context,
//                       builder: ((context) {
//                         return AlertDialog(
//                           elevation: 10,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               side: const BorderSide(
//                                   color: secondColor, width: 1)),
//                           backgroundColor: Colors.black,
//                           //   title: Text(''),
//                           content: Text('Leaving Already?',
//                               style: GoogleFonts.grandstander(
//                                   fontWeight: FontWeight.w500, fontSize: 25)),
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text(
//                                   'Not yet',
//                                   style: TextStyle(color: secondColor),
//                                 )),
//                             TextButton(
//                                 onPressed: () async {
//                                   await FirebaseAuth.instance
//                                       .signOut()
//                                       .whenComplete(() =>
//                                           Navigator.pushNamedAndRemoveUntil(
//                                               context,
//                                               ScreenLogin.routeName,
//                                               (route) => false));
//                                 },
//                                 child: const Text(
//                                   "I'm Done!",
//                                   style: TextStyle(color: secondColor),
//                                 ))
//                           ],
//                         );
//                       }),
//     );
//   }
// }