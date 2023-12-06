import '../repositories/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository userRepository;
  DeleteUserUseCase(this.userRepository);
  Future<void> execute(String id,bool connection) async {
    try {
      await userRepository.deleteUser(id, connection);
    } catch (e) {
      print('Error al eliminar el usuario: $e');
      throw e;
    }
  }
}
