import 'package:NoteNest/features/tasks/pages/in_progress_task_page.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;


  const CustomBottomBar({
    super.key,
    required this.currentIndex,

  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [

        Container(
          height: 93,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
              )
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              GestureDetector(
                onTap: () => onTap(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: currentIndex == 0
                          ? const Color(0xff7B4BB7)
                          : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: currentIndex == 0
                            ? const Color(0xff7B4BB7)
                            : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(width: 50),

              GestureDetector(
                onTap: () => onTap(1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.settings,
                      color: currentIndex == 1
                          ? const Color(0xff7B4BB7)
                          : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Settings",
                      style: TextStyle(
                        color: currentIndex == 1
                            ? const Color(0xff7B4BB7)
                            : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: -25,
          child: FloatingActionButton(
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>InProgressTaskPage()));},
            shape: const CircleBorder(),
            backgroundColor: const Color(0xff7B4BB7),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

void onTap(int i) {
}
