import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 300),
          _loginText(),
          const SizedBox(height: 20),
          _loginFields(),
          const SizedBox(height: 50),
          _loginButton()
        ],
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
      child: const TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Username',
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _password() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: const TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.grey)),
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
          child: const Center(
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
