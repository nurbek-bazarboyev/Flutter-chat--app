import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class MyLoginTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscure;
  final bool managable;

  const MyLoginTextField(
      {super.key,
        required this.hintText,
        required this.controller,
        required this.obscure,
        this.managable=false});

  @override
  State<MyLoginTextField> createState() => _MyLoginTextFieldState();
}

class _MyLoginTextFieldState extends State<MyLoginTextField> {
  bool hide=true;
  @override
  Widget build(BuildContext context) {
    return widget.managable ? Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey,width: 1.5),
          color: Colors.grey.shade100
      ),
      child: Row(
        children: [
          Expanded(child: TextField(
            controller: widget.controller,
            obscureText: hide,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
            ),
          ),),
          IconButton(onPressed: (){
            setState(() {
              hide = !hide;
            });
          }, icon: Icon(hide ? CupertinoIcons.eye_slash : CupertinoIcons.eye))
        ],
      ),
    )
        : TextField(
      obscureText: widget.obscure,
      controller: widget.controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green,width: 1.5)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey,width: 1.5)
          ),fillColor: Colors.grey.shade100,
          filled: true,
          hintText: widget.hintText
      ),
    );
  }
}
