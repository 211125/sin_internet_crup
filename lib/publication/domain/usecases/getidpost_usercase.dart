
import '../../data/models/getuser_model.dart';
import '../repositories/user_repository.dart';

class GetUserIdUseCase {
  final UserRepository userRepository;
  GetUserIdUseCase(this.userRepository);
  Future<PostModel> execute(String id) async {
    try {
      return await userRepository.getUser(id);
    } catch (e) {
      print('Error al obtener el usuario: $e');
      throw e;
    }
  }
}