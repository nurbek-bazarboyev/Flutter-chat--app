import 'package:flutter/material.dart';
import 'package:modul7_3/pages/login_page.dart';
import 'package:modul7_3/pages/register_page.dart';
class RegisterOrLogin extends StatefulWidget {
  const RegisterOrLogin({super.key});

  @override
  State<RegisterOrLogin> createState() => _RegisterOrLoginState();
}

class _RegisterOrLoginState extends State<RegisterOrLogin> {
  bool showLoginPage =false;
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglePages,);
    }
    else{
      return RegisterPage(onTap: togglePages,);
    }
  }
}
