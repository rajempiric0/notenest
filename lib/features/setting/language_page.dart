import 'package:NoteNest/features/setting/header.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final TextEditingController _searchController = TextEditingController();
  int languageIndex = -1;

  List<String> language = [
    'Hindi',
    'English',
    'Gujarati',
    'Marathi',
    'Bengali',
    'Punjabi',
    'Tamil',
    'Telugu',
    'Malayalam',
    'Kannada',
    'Urdu',
    'Odia',
    'Assamese',
    'Sanskrit',
    'Nepali',
    'Bhojpuri',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(title: 'Language'),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xFFF7F6FC),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Image.asset(
                        'assets/homepage/search_icon.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Languages..',
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.beVietnamPro(
                            color: const Color(0xFF777777),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 161 / 42,
                  ),

                  itemCount: language.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => setState(() {
                        languageIndex = index;
                      }),

                      child: Container(
                        width: 161,
                        height: 42,
                        decoration: BoxDecoration(
                          color: languageIndex == index
                              ? Color(0x1A794098)
                              : Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: languageIndex == index
                                ? Color(0xFF794098)
                                : Color(0xFFE5E5E5),
                            width: 1,
                          ),
                        ),

                        child: Center(
                          child: Text(
                            language[index],
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 14,
                              color: Color(0xFF262626),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
