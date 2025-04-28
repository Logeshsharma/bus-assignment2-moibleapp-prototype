import 'package:get/get.dart';

/* 

 File: [home_controller.dart]
 1. This class [HomeController] is to hold the state of the Home screen.
 2. [currentPageIndex] is Reactive value - if we have any changes, it will update the UI elements.

  
 Reference document:
 - [https://pub.dev/packages/get]

*/

class HomeController extends GetxController {
  RxInt currentPageIndex = 0.obs;
}
