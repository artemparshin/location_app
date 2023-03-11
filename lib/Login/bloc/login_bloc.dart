import 'package:bloc/bloc.dart';
import '../../service/login_reg_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc(this.loginService) : super(LoginInitial()) {
    on<LoginRequested>(_login);
  }

 final LoginService loginService;

  void _login(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await loginService.login(email: event.email, password: event.password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure());
    }
  }
  
}
