import '../repositories/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository userRepository;
  DeleteUserUseCase(this.userRepository);
  Future<void> execute(String id) async {
    try {
      await userRepository.deleteUser(id);
    } catch (e) {
      print('Error al eliminar el usuario: $e');
      throw e;
    }
  }
}
