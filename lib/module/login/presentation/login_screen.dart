import 'package:assignment2_mobileapp_prototype/core/app_color.dart';
import 'package:assignment2_mobileapp_prototype/module/login/controller/login_controller.dart';
import 'package:assignment2_mobileapp_prototype/module/login/presentation/mix_n_match_logo.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final loginController = Get.put(LoginController());
  final userTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
      ),
      backgroundColor: AppColor.secondary,
      body: GestureDetector(
        onTap: () => loginController.removeFocus(),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
        child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MixNMatchLogo(),
            const SizedBox(height: 40),
            _loginText(),
            const SizedBox(height: 20),
            _loginFields(),
            const SizedBox(height: 50),
            _loginButton(),
          ],
        ),
      ),
    ));
  }

  Widget _loginText() {
    return FadeInUp(
        duration: const Duration(seconds: 2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Login',
              style: TextStyle(
                color: AppColor.primary,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              )),
        ));
  }

  Widget _loginFields() {
    return FadeInUp(
      duration: const Duration(seconds: 3),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.secondary,
            boxShadow: [
              BoxShadow(
                  color: AppColor.tertiary,
                  blurRadius: 20,
                  offset: const Offset(0, 10))
            ]),
        child: Column(
          children: [_userName(), _password()],
        ),
      ),
    );
  }

  Widget _userName() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: TextField(
        controller: userTextController,
        focusNode: loginController.usernameFocusNode,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Username',
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _password() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Obx(
        () => TextField(
          controller: passwordTextController,
          focusNode: loginController.passwordFocusNode,
          obscureText: loginController.obscureText(),
          decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () =>
                    loginController.obscureText(!loginController.obscureText()),
                icon: Icon(
                  size: 18,
                  loginController.obscureText()
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: const TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return FadeInUp(
        duration: const Duration(seconds: 3),
        child: Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: AppColor.primary),
          child: Obx(
            () => loginController.loadingState()
                ? Center(
                    child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColor.secondary,
                  ))
                : InkWell(
                    onTap: () => loginController.login(
                      userTextController.text,
                      passwordTextController.text,
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: AppColor.secondary,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                  ),
          ),
        ));
  }
}
