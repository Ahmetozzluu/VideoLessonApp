// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:dersgo_app/product/global/model/user_model.dart';

class VideoState extends Equatable {
  final VideoStatus status;
  final bool isPlaying;
  final double progressPercentage;
  final String watchStatus;
  final Videos? updateVideo;
  final String? currentTime;
  final String? videoUrl;
 final List<String>? lastVideo;
 final List<Videos>? lastWatchedVideo;

  const VideoState({
    required this.status,
    required this.isPlaying,
    required this.progressPercentage,
    required this.watchStatus,
    this.updateVideo,
    this.currentTime,
    this.videoUrl,
    this.lastVideo,
    this.lastWatchedVideo,
  });

  factory VideoState.initial() {
    return const VideoState(
      status: VideoStatus.initial,
      isPlaying: false,
      progressPercentage: 0.0,
      watchStatus: 'İzlemedim',
      updateVideo: null,
      currentTime: '',
      videoUrl: '',
      lastVideo: [],
      lastWatchedVideo: []
    );
  }

  @override
  List<Object?> get props =>
      [status, isPlaying, progressPercentage, watchStatus,updateVideo, lastWatchedVideo];

  VideoState copyWith(
      {VideoStatus? status,
      bool? isPlaying,
      double? progressPercentage,
      String? watchStatus,
      Videos? updateVideo,
      String? currentTime,
      String? videoUrl,
      List<String>? lastVideo,
      List<Videos>? lastWatchedVideo,
      }) {
    return VideoState(
      status: status ?? this.status,
      isPlaying: isPlaying ?? this.isPlaying,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      watchStatus: watchStatus ?? this.watchStatus,
      updateVideo: updateVideo ?? this.updateVideo,
      currentTime: currentTime ?? this.currentTime,
      videoUrl: videoUrl ?? this.videoUrl,
      lastVideo: lastVideo,
      lastWatchedVideo: lastWatchedVideo ?? this.lastWatchedVideo
    );
  }
}

enum VideoStatus {
  initial,
  playing,
  paused,
  completed,
  error,
}
