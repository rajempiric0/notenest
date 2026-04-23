import 'package:NoteNest/features/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'on_boarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController imageController = PageController();
  int currentIndex = 0;

  List<OnboardingModel> screens = [
    OnboardingModel(
      image: 'assets/image/onboarding1.png',
      title: 'Organize Your Tasks in One Place',
      subtitle:
          'Plan your day, manage your to-do lists, and keep track of everything that matters.',
    ),
    OnboardingModel(
      image: 'assets/image/onboarding2.png',

      title: 'Plan Smarter and Stay Focused',
      subtitle:
          'Break big goals into simple tasks and manage your time more effectively. ',
    ),
    OnboardingModel(
      image: 'assets/image/onboarding3.png',

      title: 'Build Productive Habits Every Day',
      subtitle:
          'Track progress, complete tasks, and celebrate every achievement.',
    ),
  ];

  void nextPage() {
    if (currentIndex == screens.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      imageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: currentIndex == index ? 48 : 20,

      decoration: BoxDecoration(
        color: currentIndex == index ? Color(0xFF794098) : Color(0xFFE2E5E5),
        borderRadius: BorderRadius.circular(13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        leadingWidth: 60,
        leading: currentIndex > 0
            ? Padding(
                padding: EdgeInsets.only(left: 20, top: 18),
                child: Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFE5E2E3), width: 2),
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        if (currentIndex > 0) {
                          final prevIndex = currentIndex - 1;

                          imageController.animateToPage(
                            prevIndex,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );

                          setState(() => currentIndex = prevIndex);
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Color(0xFF252526),
                        size: 15,
                      ),
                    ),
                  ),
                ),
              )
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 18),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Skip',
                style: GoogleFonts.beVietnamPro(
                  color: Color(0xFF6F6F73),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 51),

              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: imageController,
                  itemCount: screens.length,
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final data = screens[index];

                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 51,
                        left: 20,
                        right: 20,
                      ),
                      child: Image.asset(data.image as String),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    screens.length,
                    (dotIndex) => buildDot(dotIndex),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 64),
                      child: Text(
                        screens[currentIndex].title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 24,
                          color: Color(0xFF262626),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      child: Text(
                        screens[currentIndex].subtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.beVietnamPro(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF6F6F73),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 6,
                ),
                child: ElevatedButton(
                  onPressed: nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF794098),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      currentIndex == screens.length - 1
                          ? "Let's Get Started"
                          : "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
