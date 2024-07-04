import 'package:flutter/material.dart';
import 'package:modul7_3/components/my_button.dart';
import 'package:modul7_3/components/mytext_field.dart';
import 'package:modul7_3/service/auth/auth_service.dart';
import 'package:provider/provider.dart';
class RegisterPage extends StatefulWidget {
  final void  Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void signUp(){
    if(passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords don't match")));
    }
    else{
    try{
      final service = Provider.of<AuthService>(context,listen: false);
      service.signUPwithemailandpassword(emailController.text, passwordController.text, nameController.text);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error ${e.toString()}")));
    }}
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
              Text("Let's create an account for you!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
              SizedBox(height: 30,),

              // email
              MyLoginTextField(
                  hintText: "Name",
                  controller: nameController,
                  obscure: false),
              SizedBox(height: 10,),

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
              SizedBox(height: 10,),

              // confirm password
              MyLoginTextField(
                hintText: "Confirm Password",
                controller: confirmPasswordController,
                obscure: false,
                managable: true,
              ),
              SizedBox(height: 30,),

              // sign in button
              MyButton(text: 'Sign Up',onTap: signUp,),
              SizedBox(height: 50,),
              // not a member text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member?",),
                  SizedBox(width: 5,),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Login now",style: TextStyle(fontWeight: FontWeight.bold),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
