import 'package:assignment2_mobileapp_prototype/module/login/controller/login_controller.dart';
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
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(40.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: const Image(image: AssetImage('assets/mixnmatch.png'))),
            const SizedBox(height: 40),
            _loginText(),
            const SizedBox(height: 20),
            _loginFields(),
            const SizedBox(height: 50),
            _loginButton()
          ],
        ),
      ),
    ));
  }

  Widget _loginText() {
    return FadeInUp(
        duration: const Duration(milliseconds: 1500),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Login',
              style: TextStyle(
                color: Color.fromRGBO(49, 39, 79, 1),
                fontWeight: FontWeight.bold,
                fontSize: 25,
              )),
        ));
  }

  Widget _loginFields() {
    return FadeInUp(
      duration: const Duration(milliseconds: 1700),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(196, 135, 198, .3),
                  blurRadius: 20,
                  offset: Offset(0, 10))
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
        duration: const Duration(milliseconds: 1700),
        child: Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color.fromRGBO(49, 39, 79, 1),
          ),
          child: Obx(
            () => loginController.loadingState()
                ? const Center(
                    child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ))
                : InkWell(
                    onTap: () => loginController.login(
                      userTextController.text,
                      passwordTextController.text,
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
          ),
        ));
  }
}
