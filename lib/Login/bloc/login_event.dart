import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;
  
  LoginRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}