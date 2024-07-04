import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'event.dart';
part 'state.dart';
class MyBloc extends Bloc<MyEvent,MyState>{
   bool show=ChangeInInput(TextEditingController()).controller.text.isEmpty;
   MyBloc():super(MyState(isEmpty: true)){
   on<MyEvent>((event, emit){
     if(event is ChangeInInput){
       emit(MyState(isEmpty: show));
     }
   });
  }
}