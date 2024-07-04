import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modul7_3/pages/person_chat_page.dart';
import 'package:modul7_3/pages/group_chat_page.dart';
import 'package:modul7_3/service/auth/auth_service.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void signOut(){
    final service = Provider.of<AuthService>(context,listen: false);
    service.singOut();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      //initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(onPressed: (){},icon: Icon(Icons.menu_outlined,color: Colors.white,),),
          title: Center(child: Text("My Chat App",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)),
          bottom: TabBar(tabs: [
            Tab(text: 'groups',),
            Tab(text: 'personal',)
          ]),
          actions: [
            IconButton(onPressed: signOut, icon: Icon(Icons.send_to_mobile_outlined,color: Colors.white,size: 30,))
          ],
        ),
        body:
        TabBarView(children: [
          Container(
            color: Colors.white,
            child: _buildGroupList(),
          ),
          Container(
            color: Colors.white,
            child: _buildUserList(),
          )
        ]),
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(20),
                height: size.height * .25,
                width: double.infinity,
                color: Colors.blueAccent.withOpacity(.7),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(.5),
                          radius: 40,
                          child: Text('UY'),
                        ),
                        Spacer(),
                        IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_outlined,color: Colors.white,size: 30,))
                      ],
                    ),
                    SizedBox(height: 30,),
                    Text('+998908524518',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
                    Text('Umrzoq Yuldoshov',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              // edit image
              ListTile(
                onTap: (){},
                leading: Icon(Icons.image,color: Colors.green,),
                title: Text('edit picture'),
              ),
              // edit name
              ListTile(
                onTap: (){},
                leading: Icon(Icons.edit,color: Colors.black.withOpacity(.6),),
                title: Text('edit name'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildUserList(){
    return StreamBuilder(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text("Error ${snapshot.error}");
          }if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator.adaptive(strokeWidth: 10,),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) => _buildUserListItem(doc)).toList(),
          );
        }
    );
  }
  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if(_firebaseAuth.currentUser!.uid == data['uid']){
      return SizedBox();
    }
    return ListTile(

      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(title: data['name'],receiverId: data['uid'],)));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Text(data['name'].toString().substring(0,2),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
      ),
      title: Text(data['name']),
    );
  }

  Widget _buildGroupList(){
    return StreamBuilder(
        stream: _firestore.collection('groups').snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          }if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator.adaptive(strokeWidth: 10,),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) => _buildGroupListItem(document)).toList(),
          );
        }
    );
  }
  Widget _buildGroupListItem(DocumentSnapshot document){
    print(document.id);
    final String id = document.id;
    Map<String,dynamic> data = document.data()! as Map<String, dynamic>;
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupChatPage(title: data['name'],groupId: id,)));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        child: Text(data['name'].toString().substring(0,2),style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
      ),
      title: Text(data['name']),
    );

  }
}
