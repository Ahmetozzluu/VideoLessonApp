// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:dersgo_app/feature/video/cubit/video_cubit.dart';
import 'package:dersgo_app/feature/video/cubit/video_state.dart';
import 'package:dersgo_app/product/constants/app_color.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';

class VideoView extends StatelessWidget {
  final List<Videos>? videos;
  final Videos? video;
  const VideoView({
    super.key,
    this.videos,
    this.video,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VideoCubit>();
    cubit.initController(video!.url!);
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            cubit.resetWatchStatus();
          },
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
              child: Center(
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.all(15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          video!.title.toString(),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(height: 15.h),
                        YoutubePlayer(
                          controller: cubit.controller!,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blueAccent,
                          aspectRatio: 16 / 15,
                        ),
                        SizedBox(height: 10.h),
                        /* Slider(
                          activeColor: AppColors.primaryColor,
                          value: state.progressPercentage,
                          min: 0,
                          max: 100,
                          onChanged: (value) {
                            cubit.updateSlider(value);
                          },
                        ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomElevatedButton(
                              text: state.isPlaying ? "Duraklat" : "Oynat",
                              icon: Icon(
                                state.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              color: AppColors.primaryColor,
                              onPressed: cubit.togglePlayPause,
                            ),
                            Text(
                              "İlerleme: ${state.progressPercentage.toStringAsFixed(0)}%",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Center(
                          child: DropdownButton<String>(
                            value: state.watchStatus,
                            items: <String>['İzlemedim', 'İzledim']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                cubit.updateWatchStatus(newValue);
                                cubit.updateVideo(
                                  video!.userId!,
                                  video!.videoId!,
                                  video!.copyWith(
                                    isWatched:
                                        newValue == "İzlemedim" ? false : true,
                                    currentTime: state.currentTime,
                                    lastWatched: newValue == "İzlemedim"
                                        ? null
                                        : DateTime.now(),
                                  ),
                                );
                               if (newValue == "İzledim") {
                                  cubit.updateLastWatched(
                                      video!.userId!, videos);
                                }
                              }
                            },
                            elevation: 8,
                            underline: const SizedBox.shrink(),
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomElevatedButton(
                              text: "Beğendim",
                              icon: const Icon(Icons.thumb_up),
                              color: AppColors.primaryColor,
                              onPressed: () {
                                cubit.updateVideo(
                                  video!.userId!,
                                  video!.videoId!,
                                  video!.copyWith(
                                    isLiked: true,
                                    currentTime: state.currentTime,
                                  ),
                                );
                              },
                            ),
                            CustomElevatedButton(
                              text: "Beğenmedim",
                              icon: const Icon(Icons.thumb_down),
                              color: AppColors.primaryColor,
                              onPressed: () {
                                cubit.updateVideo(
                                  video!.userId!,
                                  video!.videoId!,
                                  video!.copyWith(
                                    isLiked: false,
                                    currentTime: state.currentTime,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        // Ana Sayfaya Dön Butonu
                        Center(
                          child: CustomElevatedButton(
                            text: "Ana sayfaya dön",
                            color: AppColors.primaryColor,
                            onPressed: () {
                              context.pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Icon? icon;
  final Color color;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon ?? const SizedBox.shrink(),
      label: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
        minimumSize: Size(100.w, 40.h),
      ),
    );
  }
}
