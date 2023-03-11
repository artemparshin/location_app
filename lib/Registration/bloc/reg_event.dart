import 'package:equatable/equatable.dart';

abstract class RegEvent extends Equatable{}

class RegistrationRequested extends RegEvent {
  final String email;
  final String password;
  
  RegistrationRequested(this.email, this.password);

  @override
  List<Object> get props =>[email, password];
}
