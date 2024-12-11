import 'package:bloc/bloc.dart';
import 'package:dersgo_app/feature/login/cubit/login_state.dart';
import 'package:dersgo_app/feature/login/service/login_service.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:dersgo_app/product/global/service/auth/IAuth_service.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial()) {
    init();
  }

  init() async {}

  final ILoginService _loginService = LoginService.instance;

  Future<void> userLogin(String email, String password) async {
    emit(state.copyWith(loginState: LoginStates.loading));
    final response = await _loginService.userLogin(email, password);
    if (response == null) {
      emit(state.copyWith(
          loginState: LoginStates.error,
          errorMessage:
              "Veriler yüklenmedi. Lütfen internet bağlantınızı kontrol ediniz..."));
    } else {
      if (response.success!) {
        await fetchUserInfo(response.id!);
      } else {
        emit(state.copyWith(
            loginState: LoginStates.error,
            errorMessage: response.errorMessage ?? "Bir hata oluştu"));
      }
    }
  }

  Future<void> fetchUserInfo(int id) async {
    emit(state.copyWith(loginState: LoginStates.loading));

    final response = await _loginService.getUser(id);

    if (response == null || response.isEmpty ) {
      emit(state.copyWith(
          loginState: LoginStates.error,
          errorMessage:
              "Veriler yüklenmedi. Lütfen internet bağlantınızı kontrol ediniz..."));
    } else {
      final loggedInUser = response.firstWhere(
        (user) => user.id == id,
        orElse: () => UserModel(),
      );
      emit(state.copyWith(
          loginState: LoginStates.completed,
          user: [loggedInUser],
          message: "Hoşgeldin ${loggedInUser.name}"));
    }
    emit(state.copyWith(loginState: LoginStates.initial));
  }

  Future<void> updateVideo(int id, int videoId, Videos video) async {
    emit(state.copyWith(loginState: LoginStates.loading));
    final response = await _loginService.updateVideo(id, videoId, video);

    if (response == null) {
      emit(state.copyWith(
          loginState: LoginStates.error,
          errorMessage: "İşlem tamamlanmadı veya tekrar deneyin."));
    } else {
      emit(state.copyWith(
          loginState: LoginStates.completed, updateVideo: response));
    }
  }
 
 void updateLastWatched(int userId, List<Videos>? videos) {
    if (videos == null || videos.isEmpty) {
      emit(state.copyWith(
        loginState: LoginStates.error,
      ));
      return;
    }

    final userVideos =
        videos.where((video) => video.userId == userId).toList();

    if (userVideos.isEmpty) {
      emit(state.copyWith(
        loginState: LoginStates.error,
      ));
      return;
    }

    final now = DateTime.now();
    final sortedVideos =
        userVideos.where((video) => video.lastWatched != null).toList()
          ..sort((a, b) {
            final aDiff = now.difference(a.lastWatched!).abs();
            final bDiff = now.difference(b.lastWatched!).abs();
            return aDiff.compareTo(bDiff);
          });

  final displayedVideos = sortedVideos.length < 5
      ? (userVideos.toList()..shuffle()).take(4).toList()
      : sortedVideos.take(5).toList();

    if (displayedVideos.isNotEmpty) {
      emit(state.copyWith(
        lastWatchedVideo: displayedVideos,
       // loginState: LoginStates.completed,
      ));
    } else {
      emit(state.copyWith(
        loginState: LoginStates.error,
      ));
    }
  }



  Future<void> updateUserIsActive(int id, bool isActive) async {
    emit(state.copyWith(loginState: LoginStates.isNotActive));
    final response = await _loginService.updateUserActive(id, isActive);
    if (response == null) {
      emit(state.copyWith(
          loginState: LoginStates.error,
          errorMessage: "İşlem tamamlanmadı veya tekrar deneyin."));
    } else {
      emit(state.copyWith());
    }
  }

  void obsecure(){
      emit(state.copyWith(isSecure: !state.isSecure));
  }

}

