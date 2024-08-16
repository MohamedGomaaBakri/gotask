import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:todo/features/auth_feature/data/models/firebase_user.dart';
import 'package:todo/features/auth_feature/domain/auth_repo.dart';
import 'package:todo/features/auth_feature/domain/user_entity.dart';
import 'package:todo/utils/errors/exeptions.dart';
import 'package:todo/utils/errors/failure.dart';
import 'package:todo/utils/services/firebase_services.dart';

class RepoIpml extends AuthRepo
{
  FirebaseServices firebaseServices ;
  RepoIpml({required this.firebaseServices});

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
      String email, String password , String name)async {
    try
    {

      var user = await firebaseServices.createUserWithEmailAndPassword(
          email: email,
          password: password,

      );
      return right(UserModel.fromFirebaseUser(user));

    }on CustomException catch(e)
    {
      return left(ServerFailure(message: e.message));
    }

    catch(e)
    {
      log('Exeption on RepoIpml.createUserWithEmailAndPassword: ${e.toString()}');

      return left(ServerFailure(message: e.toString()));
    }
  }
  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password  ) async {
    try
    {
        var user = await firebaseServices.signInWithEmailAndPassword(
            email: email,
            password: password
        );
        return right(UserModel.fromFirebaseUser(user));
    }
    on CustomException catch(e)
    {
      return left(ServerFailure(message: e.message));
    }
    catch(e)
    {
      log('Exeption on RepoIpml.signInWithEmailAndPassword: ${e.toString()}');
      return left(ServerFailure(message: e.toString()));
    }

  }
  @override
  Future<Either<Failure, UserEntity>> signInWithFacaBook() async {
    try
    {
      var user = await firebaseServices.signInWithFacaBook();
      return right(UserModel.fromFirebaseUser(user));
    }
    on CustomException catch(e)
    {
      return left(ServerFailure(message: e.message));
    }
    catch(e)
    {
      log('Exeption on RepoIpml.signInWithFacebook: ${e.toString()}');
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try
    {
      var user = await firebaseServices.signInWithGoogle();
      return right(UserModel.fromFirebaseUser(user));
    }
    on CustomException catch(e)
    {
      return left(ServerFailure(message: e.message));
    }
    catch(e)
    {
      log('Exeption on RepoIpml.signInWithGoogle: ${e.toString()}');
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signOut() async {
    // TODO: implement signOut
    throw UnimplementedError();
  }






}