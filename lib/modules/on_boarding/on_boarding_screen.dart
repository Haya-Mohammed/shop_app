import 'package:flutter/material.dart';
import 'package:shop_app1/modules/login/login_screen.dart';
import 'package:shop_app1/network/local/cache_helper.dart';
import 'package:shop_app1/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardingController = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboarding_1.png',
      title: 'Screen Title 1',
      body: 'Screen Body 1',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_1.png',
      title: 'Screen Title 2',
      body: 'Screen Body 2',
    ),
    BoardingModel(
      image: 'assets/images/onboarding_1.png',
      title: 'Screen Title 3',
      body: 'Screen Body 3',
    ),
  ];

  bool isLast = false;

  void submitOnboarder() {
    CacheHelper.saveData(key: 'onboarding', value: true).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submitOnboarder();
            },
            child: Text('SKIP'.toUpperCase()),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                itemCount: boarding.length,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (index >= boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 2,
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submitOnboarder();
                    } else {
                      boardingController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: AssetImage(model.image)),
          ),
          const SizedBox(height: 15),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
        ],
      );
}
