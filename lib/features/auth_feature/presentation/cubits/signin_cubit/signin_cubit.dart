import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/auth_feature/domain/auth_repo.dart';
import 'package:todo/features/auth_feature/domain/user_entity.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());

  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword(String email, String password ) async {
    emit(SigninLoading());
    final result = await authRepo.signInWithEmailAndPassword(email, password );
    result.fold(
      (failure) => emit(SigninError(failure.message)),
      (userEntity) => emit(SigninSuccess(userEntity)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(SigninLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(SigninError(failure.message)),
      (userEntity) => emit(SigninSuccess(userEntity)),
    );
  }

  Future<void> signInWithFacebook() async {
    emit(SigninLoading());
    final result = await authRepo.signInWithFacaBook();
    result.fold(
      (failure) => emit(SigninError(failure.message)),
      (userEntity) => emit(SigninSuccess(userEntity)),
    );
  }
}
