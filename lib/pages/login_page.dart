import 'package:flutter/material.dart';
import 'package:modul7_3/components/my_button.dart';
import 'package:modul7_3/components/mytext_field.dart';
import 'package:modul7_3/service/auth/auth_service.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  final void  Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn()async{
    try{
      final service = Provider.of<AuthService>(context,listen: false);
      await service.signINwithemailandpassword(emailController.text, passwordController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              // logo
              Transform.rotate(
                angle: -.5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 5, color: Colors.green)
                  ), child: Icon(Icons.send_rounded, color: Colors.blue, size: 80,),
                ),
              ),
              SizedBox(height: 20,),

              // welcome back text
              Text("Welcome back you've been missed!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              SizedBox(height: 30,),

              // email
              MyLoginTextField(
                  hintText: "Email",
                  controller: emailController,
                  obscure: false),
              SizedBox(height: 10,),

              // password
              MyLoginTextField(
                hintText: "Password",
                controller: passwordController,
                obscure: false,
                managable: true,
              ),
              SizedBox(height: 30,),

              // sign in button
              MyButton(text: 'Sign In',onTap: signIn,),
              SizedBox(height: 50,),
              // not a member text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?",),
                  SizedBox(width: 5,),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Register now",style: TextStyle(fontWeight: FontWeight.bold),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
