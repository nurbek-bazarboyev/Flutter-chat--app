part of 'bloc.dart';

@immutable
sealed class MyEvent{}

final class ChangeInInput extends MyEvent{
  TextEditingController controller;
  ChangeInInput(this.controller);
}