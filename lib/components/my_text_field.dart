import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function()? onTap;
  const MyTextField({super.key, required this.controller, this.onTap});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  String salom='';
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              //padding: EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withOpacity(.4)
              ),child: Row(
              children: [
                Expanded(child: TextField(
                  maxLines: 7,
                  minLines: 1,
                  controller: widget.controller,
                  onChanged: (value){
                    if(value.isNotEmpty && salom == ''){
                      setState(() {
                        salom = value;
                      });print('?????????????????????????????????????????full');
                    }else if(value.isEmpty){
                      setState(() {
                        salom = value;
                      });print('?????????????????????????????????????????empty');
                    }
                  },
                  style: TextStyle(
                    color: CupertinoColors.white
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white.withOpacity(.01),
                    filled: true
                  ),
                )),
                widget.controller.text.isEmpty ? Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white54
                  ),child: Icon(CupertinoIcons.chat_bubble_fill,color: CupertinoColors.white,),

                ) : SizedBox()
              ],
            ),
            ),
          ),
        ),
        SizedBox(width: 10,),
        Column(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(0, 172, 131, 1)
              ),child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.camera,color: Colors.white,),)
            ),
           // SizedBox(height: 10,),
            widget.controller.text.isEmpty ? SizedBox() : Container(
              margin: EdgeInsets.only(top: 10),
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromRGBO(131, 125, 255, 1)
              ),child: IconButton(onPressed: widget.onTap, icon: Icon(CupertinoIcons.chat_bubble_fill,color: CupertinoColors.white,)),

            )
          ],
        )
      ],
    );
  }
}
