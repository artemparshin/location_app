import 'package:bloc/bloc.dart';
import '../../service/login_reg_service.dart';
import 'reg_event.dart';
import 'reg_state.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  
  RegBloc(this.regService) : super(RegInitial()){
    on<RegistrationRequested>(_signUp);
  }
  
  final RegService regService;

  void _signUp(RegistrationRequested event, Emitter<RegState> emit) async {
    emit(RegLoading());
    try {
      await regService.signUp(email: event.email, password: event.password);
      emit(RegSuccess());
    } catch (e) {
      emit(RegFailure());
    }
  }
}