import 'package:NoteNest/features/botom_navigation_bar.dart' show CustomBottomBar;
import 'package:NoteNest/features/setting/header.dart';
import 'package:NoteNest/features/setting/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:NoteNest/features/auth/login_page.dart';
class Setting extends StatefulWidget {
  final String name;
  final String email;

  const Setting({super.key, required this.name, required this.email});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  //PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 244, 244),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),

              CommonHeader(
                title: "Settings",
              ),



              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));},
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        child: Image.asset(
                          'assets/setting/person_image.png',
                          width: 52,
                          height: 52,
                        ),
                      ),
                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.email,
                              style: const TextStyle(
                                color: Color(0xFF6A6B73),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(Icons.arrow_forward_ios_outlined, size: 16),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset(
                            'assets/setting/translate.svg',
                            height: 24,
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Language",
                            style: GoogleFonts.beVietnamPro(fontSize: 16),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Divider(color: Colors.grey.shade300),
                    const SizedBox(height: 15),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/setting/logout.svg',
                            height: 24,
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Log out",
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),


         ], ),
        ),

    ),

    );
  }
}
