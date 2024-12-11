/*import 'package:bloc/bloc.dart';


import 'package:dersgo_app/feature/login/cubit/login_state.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';

class LessonCubit extends Cubit<LoginState> {
  LessonCubit() : super(LoginState.initial());


  void updateSelectedVideos(String subjectTitle, List<Videos> allVideos) {
    List<Videos>? selectedVideos;
    selectedVideos = subjectTitle == 'Matematik Dersi Videoları'
        ? allVideos.take(5).toList()
        : allVideos.skip(5).toList();
    emit(state.copyWith(selectedVideos: selectedVideos));
  }
  Future<void> updateLastWatched(
      int userId, List<String> lastWatchedVideos) async {
    final response =
        await _lessonService.updateLastWatch(userId, lastWatchedVideos);

    if (response == null) {
      emit(state.copyWith(
        loginState: LoginStates.error,
        errorMessage:
            "Veriler yüklenmedi. Lütfen internet bağlantınızı kontrol ediniz...",
      ));
    } else if (response == false) {
      emit(state.copyWith(
        loginState: LoginStates.error,
        errorMessage: "Güncelleme başarısız oldu. Lütfen tekrar deneyiniz.",
      ));
    } else {
      emit(state.copyWith(loginState: LoginStates.completed));
    }
  }
}
*/