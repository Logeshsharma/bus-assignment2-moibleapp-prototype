import 'package:assignment2_mobileapp_prototype/common/app_color.dart';
import 'package:assignment2_mobileapp_prototype/module/group/controller/group_controller.dart';
import 'package:assignment2_mobileapp_prototype/service/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
        backgroundColor: AppColor.primary,
        title: Center(
          child: Text(
            "Group members",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.secondary,
              fontSize: 25,
            ),
          ),
        ),
      ),
      backgroundColor: AppColor.primary,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          Obx(() =>
              groupcontroller.loadingState() ? _loadingView() : _groupList()),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _groupList() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: groupcontroller.users.length,
        itemBuilder: (context, index) {
          final user = groupcontroller.users[index];
          return _groupItem(user, index);
        });
  }

  Widget _groupItem(User user, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => AnimatedContainer(
          decoration: BoxDecoration(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(20)),
          duration: Duration(milliseconds: 400 + (index * 250)),
          curve: Curves.decelerate,
          transform: Matrix4.translationValues(
              groupcontroller.myAnimation() ? 0 : width, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _profileImage(user.image ?? ''),
                const SizedBox(width: 10),
                _nameAndRole(
                  user.username ?? '',
                  user.role ?? '',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileImage(String image) {
    return CircleAvatar(
      radius: 35,
      backgroundImage: NetworkImage(image),
    );
  }

  Widget _nameAndRole(String username, String role) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(role),
      ],
    );
  }

  Widget _loadingView() {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (_, __) => _loadingShimmerItem());
  }

  Widget _loadingShimmerItem() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  _profileImageShimmer(),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _usernameShimmer(),
                      const SizedBox(height: 8),
                      _roleShimmer()
                    ],
                  )
                ],
              ),
            )));
  }

  Widget _profileImageShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: const CircleAvatar(
        radius: 35,
      ),
    );
  }

  Widget _usernameShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: Get.width * 0.4,
        height: 15,
        decoration: BoxDecoration(
          color: AppColor.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _roleShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: Get.width * 0.2,
        height: 15,
        decoration: BoxDecoration(
          color: AppColor.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
