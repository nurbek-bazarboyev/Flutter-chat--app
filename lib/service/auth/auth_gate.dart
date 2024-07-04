import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul7_3/pages/home_page.dart';
import 'package:modul7_3/service/auth/register_or_login.dart';
import 'package:modul7_3/service/chat_service/chat_service.dart';
import 'package:provider/provider.dart';
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ChangeNotifierProvider(
              create: (_)=>ChatService(),
            child: HomePage(),);
          }return RegisterOrLogin();
        }
    );
  }
}
