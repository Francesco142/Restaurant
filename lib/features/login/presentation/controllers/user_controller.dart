import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ordini_ristorante/features/login/domain/repositories/user_repo.dart';

class UserController extends GetxController{

  final UserRepository userRepository;

  UserController(this.userRepository);

  Future<User?> signUp(String email, String password) async{

    return userRepository.signUp(email, password);

  }

  Future<User?> signIn(String email, String password) async{

    return userRepository.signIn(email, password);

  }


}