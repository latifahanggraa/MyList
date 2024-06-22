import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:punya_orang/ui/add_task.dart';
import 'package:punya_orang/ui/profile_screen.dart';
import '../../repositories/auth_repo.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _repo = AuthRepo();
  void login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await _repo.login(email: email, password: password);
      emit(LoginSuccess('Login berhasil!'));
      MaterialPageRoute(builder: (context) => ProfileScreen());
    } catch (e) {
      print(e);
      emit(LoginFailure(e.toString()));
    }
  }
}