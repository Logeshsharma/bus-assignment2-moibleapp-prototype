import 'package:assignment2_mobileapp_prototype/core/app_color.dart';
import 'package:assignment2_mobileapp_prototype/module/group/presentation/group_screen.dart';
import 'package:assignment2_mobileapp_prototype/module/home/controller/home_controller.dart';
import 'package:assignment2_mobileapp_prototype/module/tasks/presentation/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* 

 File: [home.dart]
 1. This class is to render [HomeScreen]
 2. This screen has [NavigationBar]
 3. homeController.currentPageIndex(index) == 0 [TasksScreen] is rendered 
 4. homeController.currentPageIndex(index) == 1 [GroupScreen] is rendered 

  
 Reference document:
 - [https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html] 

*/

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: Colors.white,
          onDestinationSelected: (int index) =>
              homeController.currentPageIndex(index),
          indicatorColor: AppColor.primary,
          selectedIndex: homeController.currentPageIndex(),
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.task_alt_rounded,
                color: Colors.white,
              ),
              icon: Icon(Icons.task_alt_rounded),
              label: 'Tasks',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.group_rounded, color: Colors.white),
              icon: Icon(Icons.group_rounded),
              label: 'Group',
            ),
          ],
        ),
      ),
      body: Obx(
        () => <Widget>[
          const TasksScreen(),
          const GroupScreen()
        ][homeController.currentPageIndex()],
      ),
    );
  }
}
