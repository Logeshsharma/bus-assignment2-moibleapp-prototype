import 'package:assignment2_mobileapp_prototype/common/app_color.dart';
import 'package:assignment2_mobileapp_prototype/module/group/presentation/group_screen.dart';
import 'package:assignment2_mobileapp_prototype/module/home/controller/home_controller.dart';
import 'package:assignment2_mobileapp_prototype/module/tasks/presentation/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          /// TaskScreen 
          const  TasksScreen(),

          /// GroupScreen
          const GroupScreen()

        ][homeController.currentPageIndex()],
      ),
    );
  }
}
