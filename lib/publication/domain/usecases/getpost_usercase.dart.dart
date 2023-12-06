

import '../../data/models/getuser_model.dart';
import '../repositories/user_repository.dart';

class GetUsersUseCase {
  final UserRepository userRepository;
  GetUsersUseCase(this.userRepository);
  Future<List<PostModel>> execute(bool conection) async {
    try {
      return await userRepository.getUsers(conection);
    } catch (e) {
      print('Error al obtener xd usuarios: $e');
      throw e;
    }
  }
}