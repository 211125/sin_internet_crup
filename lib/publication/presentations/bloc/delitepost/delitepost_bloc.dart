import 'package:bloc/bloc.dart';
import '../../../domain/usecases/delitepost_usercase.dart';
import 'delitepost_event.dart';
import 'delitepost_state.dart';
import '../connectivity_service.dart';

class DelitePostBloc extends Bloc<DelitePostEvent, DelitePostState> {
  final DeleteUserUseCase? deleteUserUseCase;
  final ConnectivityService connectivityService;

  DelitePostBloc(
      {required this.deleteUserUseCase, required this.connectivityService})
      : super(UserInitial());

  @override
  Stream<DelitePostState> mapEventToState(DelitePostEvent event) async* {
    if (event is DeleteUserEvent) {
      yield UserDeleting();
      try {
        bool isConnected = connectivityService.isConnected;

        await deleteUserUseCase!.execute(event.id,isConnected);
        yield UserDeletedSuccessfully();
      } catch (e) {
        yield UserDeleteFailure(e.toString());
      }
    }
  }
}
