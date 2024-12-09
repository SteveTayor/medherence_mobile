import 'package:flutter/material.dart';
import 'package:medherence/features/auth/views/login_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;

import '../../core/utils/color_utils.dart';
import '../../core/utils/image_utils.dart';
import '../../core/shared_widget/buttons.dart';
import '../../core/utils/size_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int currentIndex = 0;
  late PageController _controller;

  final List<String> onBoardingImages = [
    ImageUtils.onboarding1,
    ImageUtils.onboarding2,
    ImageUtils.onboarding3,
  ];
  final List<String> onBoardingTitle = [
    'Never miss your Meds',
    'Smart Adherence Monitoring',
    'Adhere and Earn Coins',
  ];

  final List<String> onBoardingSubTitle = [
    'Get daily reminders and pill count reminders to stay up-to-date about your medications',
    'Stay on track in your adherence journey with smart medication adherence monitoring',
    'Earn medhecoin everytime you adhere to your medication and redeem them in cash later',
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: onBoardingImages.length,
            itemBuilder: (_, int index) {
              return Container(
                height: SizeMg.height(280),
                color: AppColors.offWhite,
                child: Image.asset(
                  onBoardingImages[index],
                  fit: BoxFit.contain,
                  width: SizeMg.screenWidth,
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Visibility(
                visible: (currentIndex == 0),
                child: GestureDetector(
                  onTap: () {
                    _controller.animateToPage(2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeMg.text(20),
                        color: AppColors.navBarColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: SizeMg.height(80),
            child: SizedBox(
              height: SizeMg.height(180),
              width: SizeMg.screenWidth,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: SizeMg.height(180),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      left: SizeMg.width(25),
                      right: SizeMg.width(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          onBoardingTitle[currentIndex],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeMg.text(25),
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Text(
                            onBoardingSubTitle[currentIndex],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeMg.text(16),
                              color: AppColors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 80),
              child: smooth_page_indicator.SmoothPageIndicator(
                controller: _controller ??= PageController(initialPage: 0),
                count: 3,
                axisDirection: Axis.horizontal,
                onDotClicked: (i) async {
                  await _controller.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
                effect: smooth_page_indicator.ExpandingDotsEffect(
                  expansionFactor: 2,
                  spacing: 8,
                  radius: SizeMg.radius(16),
                  dotWidth: SizeMg.width(10),
                  dotHeight: SizeMg.height(10),
                  dotColor: AppColors.progressBarFill,
                  activeDotColor: AppColors.navBarColor,
                  paintStyle: PaintingStyle.fill,
                ),
              ),
            ),
          ),
          Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: currentIndex == 1,
                      child: GestureDetector(
                        onTap: () {
                          _controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Icon(
                          Icons.arrow_back_sharp,
                          size: SizeMg.radius(30),
                          color: AppColors.navBarColor,
                        ),
                      ),
                    ),
                    currentIndex != 2
                        ? GestureDetector(
                            onTap: () {
                              _controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeOut);
                            },
                            child: PrimaryButton(
                              buttonConfig: ButtonConfig(
                                  text: 'Next',
                                  action: () {
                                    _controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                  }),
                              width: SizeMg.width(120),
                            ),
                          )
                        : PrimaryButton(
                            width: SizeMg.width(100),
                            buttonConfig: ButtonConfig(
                              text: 'Finish',
                              action: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginView()),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
