import 'package:NoteNest/features/setting/widgets/language_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/header.dart';
import '../services/language_services.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final TextEditingController searchController = TextEditingController();
  final LanguageService languageService = LanguageService();

  int languageIndex = -1;

  final List<Map<String, dynamic>> language = [
    {'name': 'Hindi', 'locale': const Locale('hi', 'IN')},
    {'name': 'English', 'locale': const Locale('en', 'US')},
    {'name': 'Gujarati', 'locale': const Locale('gu', 'IN')},
    {'name': 'Spanish', 'locale': const Locale('es', 'ES')},
    {'name': 'Bengali', 'locale': const Locale('bn', 'IN')},
    {'name': 'Punjabi', 'locale': const Locale('pa', 'IN')},
    {'name': 'Tamil', 'locale': const Locale('ta', 'IN')},
    {'name': 'Telugu', 'locale': const Locale('te', 'IN')},
    {'name': 'Malayalam', 'locale': const Locale('ml', 'IN')},
    {'name': 'Kannada', 'locale': const Locale('kn', 'IN')},
    {'name': 'Urdu', 'locale': const Locale('ur', 'IN')},
    {'name': 'Odia', 'locale': const Locale('or', 'IN')},
    {'name': 'Assamese', 'locale': const Locale('as', 'IN')},
    {'name': 'Sanskrit', 'locale': const Locale('sa', 'IN')},
    {'name': 'Nepali', 'locale': const Locale('ne', 'IN')},
    {'name': 'Bhojpuri', 'locale': const Locale('bho', 'IN')},
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(title: 'Language'.tr),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF7F6FC),
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
                        controller: searchController,
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
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 161 / 42,
                  ),
                  itemCount: language.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Locale selectedLocale = language[index]['locale'];

                    return LanguageGridItem(
                      name: language[index]['name'],
                      isSelected: languageIndex == index,
                      onTap: () async {
                        setState(() {
                          languageIndex = index;
                        });

                        await languageService.changeLanguage(
                          selectedLocale.languageCode,
                          selectedLocale.countryCode ?? '',
                        );

                        Get.back();
                      },
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