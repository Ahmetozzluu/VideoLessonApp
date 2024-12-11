import 'package:dersgo_app/feature/login/service/login_service.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:dersgo_app/product/global/service/auth/IAuth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  YoutubePlayerController? _controller;
  final ILoginService _loginService = LoginService.instance;
  //final IVideoService _videoService = VideoService.instance;

  VideoCubit() : super(VideoState.initial());

  YoutubePlayerController? get controller => _controller;

  //final IVideoService _videoService = VideoService.instance;

  // Controller'ı ve video'yu başlat
  void initController(String videoUrl) {
    emit(state.copyWith(videoUrl: videoUrl));
    if (videoUrl.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
      _controller!.addListener(_videoListener);
    }
  }

  void popChanged(String changed) {}

  void _videoListener() {
    final isPlaying = _controller!.value.isPlaying;
    final position = _controller!.value.position;
    final minutes = position.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = position.inSeconds.remainder(60).toString().padLeft(2, '0');
    final formattedTime = "$minutes:$seconds";

    emit(state.copyWith(
      status: isPlaying ? VideoStatus.playing : VideoStatus.paused,
      isPlaying: isPlaying,
      progressPercentage: _calculateProgressPercentage(),
      currentTime: formattedTime,
    ));
  }

  void togglePlayPause() {
    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }
  }

  void updateSlider(double value) {
    final newPosition = Duration(
      seconds: (value / 100 * _controller!.metadata.duration.inSeconds).round(),
    );
    _controller!.seekTo(newPosition);
    emit(state.copyWith(progressPercentage: value));
  }

  void updateWatchStatus(String newStatus) {
    emit(state.copyWith(watchStatus: newStatus));
  }

  void resetWatchStatus() {
    emit(state.copyWith(watchStatus: 'İzlemedim'));
  }

  double _calculateProgressPercentage() {
    if (_controller == null) return 0.0;
    final totalDuration = _controller!.metadata.duration.inSeconds;
    final currentPosition = _controller!.value.position.inSeconds;
    return totalDuration > 0 ? (currentPosition / totalDuration) * 100 : 0.0;
  }

  @override
  Future<void> close() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    return super.close();
  }

  Future<void> updateVideo(int id, int videoId, Videos video) async {
    final response = await _loginService.updateVideo(id, videoId, video);
    //video nesnesini response içerisinde gönderdik.
    if (response != null) {
      emit(state.copyWith(updateVideo: response));
    }
  }

  void updateLastWatched(int userId, List<Videos>? videos) {
    if (videos == null || videos.isEmpty) {
      emit(state.copyWith(
        status: VideoStatus.error,
      ));
      return;
    }

    final userVideos =
        videos.where((video) => video.userId == userId).toList();

    if (userVideos.isEmpty) {
      emit(state.copyWith(
        status: VideoStatus.error,
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

  final displayedVideos = sortedVideos.length < 2 
      ? (userVideos.toList()..shuffle()).take(4).toList()
      : sortedVideos.take(5).toList();

    if (displayedVideos.isNotEmpty) {
      emit(state.copyWith(

        lastWatchedVideo: displayedVideos,
        status: VideoStatus.completed,
      ));
    } else {
      emit(state.copyWith(
        status: VideoStatus.error,
      ));
    }
  }

  /* Future<void> updateLastWatched(
      int userId, List<String> lastWatchedVideos) async {
    final response =
        await _videoService.updateLastWatch(userId, lastWatchedVideos);

    if (response == null) {
      emit(state.copyWith(
        status: VideoStatus.error,
        //loginState: LoginStates.error,
      ));
    } else if (response == false) {
      emit(state.copyWith(
        status: VideoStatus.error,
        //errorMessage: "Güncelleme başarısız oldu. Lütfen tekrar deneyiniz.",
      ));
    } else {
      emit(state.copyWith(status: VideoStatus.completed));
    }
  }*/
}
