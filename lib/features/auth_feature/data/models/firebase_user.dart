import 'package:todo/features/auth_feature/domain/user_entity.dart';

class UserModel extends UserEntity
{
  UserModel(
      {required super.email,
        required super.uid,
        required super.name}
      );

  factory UserModel.fromFirebaseUser(user)
  {
    return UserModel(
        email: user.email ?? '',
        uid: user.uid,
        name: user.displayName ?? '',
    );
  }

}