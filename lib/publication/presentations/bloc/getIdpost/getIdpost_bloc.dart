import 'package:bloc/bloc.dart';
import '../../../domain/usecases/delitepost_usercase.dart';
import '../../../domain/usecases/getidpost_usercase.dart';
import 'getIdpost_event.dart';
import 'getIdpost_state.dart';

class getIdpostBloc extends Bloc<UserCreateEvent, UserCreateState> {
  final GetUserIdUseCase? getUserIdUseCase;

  getIdpostBloc({required this.getUserIdUseCase}) : super(UserInitial());


}
