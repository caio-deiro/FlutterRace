import 'package:meu_app/modules/signup/repositories/signup_repository.dart';
import 'package:meu_app/shared/models/user_model.dart';
import 'package:meu_app/shared/services/app_database.dart';

class SignupRepositoryImpl implements SignupRepository {
  final AppDatabase database;

  SignupRepositoryImpl(this.database);
  @override
  Future<UserModel> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    final response = await database.createAccount(
        email: email, password: password, name: name);
    return response;
  }
}
