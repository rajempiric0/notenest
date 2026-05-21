import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

void showDeleteTaskDialog(
    BuildContext context,
    HomeController controller,
    String docId,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: const Color(0xFFFFFFFF),
        surfaceTintColor: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 101,
                width: 101,
                decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
                child: SvgPicture.asset(
                  'assets/homepage/delete_task.svg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'delete_task'.tr,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF252526),
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'delete_task_message'.tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF252526),
                ),
              ),
              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        await controller.deleteTask(docId);
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFFF3D00)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'yes_delete'.tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.beVietnamPro(
                            color: const Color(0xFFFF3D00),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF794098),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'no_keep_it'.tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.beVietnamPro(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}