import '../../domain/entities/post.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_data_source.dart';
import '../models/getuser_model.dart';
import '../models/posh_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl( {required this.userLocalDataSource,});

  @override
  Future<List<PostModel>> getUsers(bool conection) async {
    return await userLocalDataSource.getUsers(conection);
  }

  @override
  Future<PostModel> getUser(String id) async {
    return await userLocalDataSource.getUser(id);
  }

  @override
  Future<void> createUser(createModel user, bool connection) async {
    await userLocalDataSource.createUser(user, connection);
  }

  @override
  Future<void> updateUser(PostModel user,bool conection) async {
    await userLocalDataSource.updateUser(user,conection);
  }

  @override
  Future<void> deleteUser(String id,bool connection) async {
    await userLocalDataSource.deleteUser(id, connection);
  }
}
