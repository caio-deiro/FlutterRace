import 'package:flutter/foundation.dart';
import 'package:meu_app/shared/models/user_model.dart';
import 'package:meu_app/shared/services/app_database.dart';
import 'package:supabase/supabase.dart';

class SupabaseDatabase implements AppDatabase {
  late final SupabaseClient client;

  SupabaseDatabase() {
    init();
  }

  @override
  void init() {
    client = SupabaseClient(
      const String.fromEnvironment('SUPABASEURL'),
      const String.fromEnvironment('SUPABASEKEY'),
    );
    if (!kReleaseMode) {
      print('DataBase foi inicializado');
    }
  }

  @override
  Future<UserModel> createAccount(
      {required String email,
      required String password,
      required String name}) async {
    final response = await client.auth.signUp(email, password);
    if (response.error == null) {
      final user = UserModel(email: email, id: response.user!.id, name: name);
      await createUser(user);
      return user;
    } else {
      throw Exception(
          response.error?.message ?? 'Não foi possivel criar conta');
    }
  }

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await client.auth.signIn(email: email, password: password);
    if (response.error == null) {
      final user = await getUser(response.user!.id);
      return user;
    } else {
      throw Exception(
          response.error?.message ?? 'Não foi possivel fazer login');
    }
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    final response = await client.from('users').insert(user.toMap()).execute();
    if (response.error == null) {
      return user;
    } else {
      throw Exception('Não foi possivel cadastrar o usuario!');
    }
  }

  @override
  Future<UserModel> getUser(String id) async {
    final response =
        await client.from('users').select().filter('id', 'eq', id).execute();
    if (response.error == null) {
      final user = UserModel.fromMap(response.data[0]);
      return user;
    } else {
      throw Exception('Não foi possivel buscar o usuario');
    }
  }

  @override
  Future<bool> create(
      {required String table, required Map<String, dynamic> data}) async {
    final response = await client.from(table).insert(data).execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return true;
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final response =
        await client.from(table).select("*").order("created").execute();
    if (response.error != null) {
      throw Exception(response.error!.message);
    }
    return (response.data as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
