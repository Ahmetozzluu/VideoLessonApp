import 'package:dersgo_app/feature/home/widgets/video_details.dart';
import 'package:dersgo_app/feature/home/widgets/video_thumbnail.dart';
import 'package:dersgo_app/feature/login/cubit/login_cubit.dart';
import 'package:dersgo_app/feature/video/cubit/video_cubit.dart';
import 'package:dersgo_app/feature/video/cubit/video_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LastWatchedVideoCard extends StatelessWidget {
  final LoginCubit logCubit;
  const LastWatchedVideoCard({super.key, required this.logCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, videoCubit) {
        final video =  videoCubit.updateVideo;
        final videoImage = video != null && video.url != null
            ? YoutubePlayer.convertUrlToId(video.url!) != null
                ? 'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(video.url!)}/hqdefault.jpg'
                : 'https://via.placeholder.com/150'
            : 'https://via.placeholder.com/150';

        return InkWell(
          onTap: () {},
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 7,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  VideoThumbnail(imageUrl: videoImage),
                  SizedBox(width: 14.w),
                  VideoDetails(video: video),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
