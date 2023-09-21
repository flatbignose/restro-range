import 'package:flutter/material.dart';
import 'package:restro_range/auth/screens/login.dart';
import 'package:restro_range/const/colors.dart';
import 'package:restro_range/const/size_radius.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

import '../widgets/launch_stack.dart';

class ScreenLaunch extends StatefulWidget {
  static const routeName = '/launch';
  const ScreenLaunch({super.key});

  @override
  State<ScreenLaunch> createState() => _ScreenLaunchState();
}

class _ScreenLaunchState extends State<ScreenLaunch> {
  late VideoPlayerController _videoController;
  final _pageController = PageController(
    initialPage: 0,
  );
  final String launchVideo = 'asset/video/getting_started.mp4';

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(launchVideo)
      ..initialize().then((_) {
        setState(() {});
      });
    _videoController.addListener(() {
      if (_videoController.value.hasError) {
        print('VideoPlayer error: ${_videoController.value.errorDescription}');
      }
    });
    _videoController.pause();
    // _videoController.play();
    // _videoController.setLooping(true);
    _videoController.setVolume(0.0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              child: VideoPlayer(_videoController)),
          PageView(
            controller: _pageController,
            children: [
              LaunchPages(
                size: size,
                description:
                    'Welcome to RestroRange - where we turn restaurant chaos into organized symphonies! Get ready to transform your restaurant management game with a touch of order and a dash of laughter.',
                isButton: false,
                isSkip: true,
              ),
              LaunchPages(
                size: size,
                description:
                    '• Keep your restaurant fully stocked and organized with ease.\n\n• Simplify inventory tracking to reduce waste and operational costs.\n\n• Optimize your restaurant\'s inventory for cost savings and efficiency.',
                isButton: false,
                isSkip: false,
              ),
              LaunchPages(
                size: size,
                description:
                    '• Effortlessly manage restaurant orders with our intuitive system.\n\n• Streamline order processing for faster service and happier diners.\n\n• Take control of your restaurant\'s orders and ensure accuracy every time.',
                isButton: true,
                isSkip: false,
              ),
            ],
          ),
          Positioned(
              right: 10,
              bottom: 30,
              child: SmoothPageIndicator(
                  effect:const ExpandingDotsEffect(
                    dotHeight: 3,
                    dotWidth: 10,
                    activeDotColor: Colors.orange,
                    dotColor: backgroundColor,
                  ),
                  controller: _pageController,
                  count: 3))
        ],
      ),
    );
  }
}
