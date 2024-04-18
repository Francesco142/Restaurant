
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ordini_ristorante/features/login/data/datasources/user_datasource.dart';
import 'package:ordini_ristorante/features/login/domain/repositories/user_repo.dart';


class UserRepositoryImpl extends UserRepository{

  final UserDatasource userDatasource;

  UserRepositoryImpl(this.userDatasource);

  Future<User?> signUp(String email, String password) async{

    return userDatasource.signUp(email, password);

  }

  Future<User?> signIn(String email, String password) async{

    return userDatasource.signIn(email, password);

  }



}