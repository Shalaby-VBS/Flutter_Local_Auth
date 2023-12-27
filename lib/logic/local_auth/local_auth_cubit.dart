import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/local_auth_services.dart';
import 'local_auth_state.dart';

class LocalAuthCubit extends Cubit<LocalAuthState> {
  LocalAuthCubit() : super(LocalAuthInitial());

  Future<void> authenticate() async {
    emit(LocalAuthLoading());
    final authenticated = await LocalAuthServices.authenticate();
    if (authenticated) {
      emit(LocalAuthSuccess());
    }
  }
}
