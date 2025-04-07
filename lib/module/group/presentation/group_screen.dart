import 'package:assignment2_mobileapp_prototype/module/group/controller/group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final groupcontroller = Get.put(GroupController());
  double width = 0;

  @override
  void initState() {
    super.initState();
    groupcontroller.fetchGroup();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(49, 39, 79, 1),
        title: const Center(
          child: Text(
            "Group members",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(49, 39, 79, 1),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 20),
            Obx(
              () => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: groupcontroller.users.length,
                  itemBuilder: (context, index) {
                    final myUser = groupcontroller.users[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => AnimatedContainer(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          duration: Duration(milliseconds: 400 + (index * 250)),
                          curve: Curves.decelerate,
                          transform: Matrix4.translationValues(
                              groupcontroller.myAnimation() ? 0 : width, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      NetworkImage(myUser.image ?? ''),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      myUser.username ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      myUser.role ?? '',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
