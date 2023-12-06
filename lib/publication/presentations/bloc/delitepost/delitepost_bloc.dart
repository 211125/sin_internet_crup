import 'package:bloc/bloc.dart';
import '../../../domain/usecases/delitepost_usercase.dart';
import 'delitepost_event.dart';
import 'delitepost_state.dart';

class DelitePostBloc extends Bloc<DelitePostEvent, DelitePostState> {
  final DeleteUserUseCase? deleteUserUseCase;

  DelitePostBloc({required this.deleteUserUseCase})
      : super(UserInitial());

  @override
  Stream<DelitePostState> mapEventToState(DelitePostEvent event) async* {
    if (event is DeleteUserEvent) {
      yield UserDeleting();
      try {
        await deleteUserUseCase!.execute(event.id);
        yield UserDeletedSuccessfully();
      } catch (e) {
        yield UserDeleteFailure(e.toString());
      }
    }
  }
}


