
import '../../data/models/getuser_model.dart';
import '../../data/models/posh_model.dart';

abstract class UserRepository {
  Future<List<PostModel>> getUsers(bool conection);
  Future<PostModel> getUser(String id);
  Future<void> createUser(createModel user, bool connection);
  Future<void> updateUser(PostModel user,bool conection);
  Future<void> deleteUser(String id,bool connection);
}