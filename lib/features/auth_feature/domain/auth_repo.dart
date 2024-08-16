import 'package:dartz/dartz.dart';
import 'package:todo/utils/errors/failure.dart';

import 'user_entity.dart';

abstract class AuthRepo
{
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(String email, String password, String name);
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(String email, String password );
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithFacaBook();
  Future<Either<Failure, UserEntity>> signOut();

}