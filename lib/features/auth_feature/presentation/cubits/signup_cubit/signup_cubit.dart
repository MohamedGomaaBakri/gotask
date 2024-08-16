import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/auth_feature/domain/auth_repo.dart';
import 'package:todo/features/auth_feature/domain/user_entity.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo ;

  Future<void> createUserWithEmailAndPassword(String email, String password , String name) async {
    emit(SignupLoading());
    final result = await authRepo.signUpWithEmailAndPassword(email, password , name);
    result.fold(
      (failure) => emit(SignupError(failure.message)),
      (userEntity) => emit(SignupSuccess(userEntity)),
    );
  }

}
