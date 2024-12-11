// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:dersgo_app/feature/home/widgets/last_watched_video_card.dart';
import 'package:dersgo_app/feature/home/widgets/quik_video_section.dart';
import 'package:dersgo_app/feature/login/cubit/login_cubit.dart';
import 'package:dersgo_app/feature/video/cubit/video_cubit.dart';
import 'package:dersgo_app/feature/video/cubit/video_state.dart';
import 'package:dersgo_app/product/constants/app_color.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';

class HomePage extends StatelessWidget {
  final List<UserModel>? user;
  //final List<Videos>? videos;
  final LoginCubit logCubit;
  const HomePage({
    super.key,
    this.user,
    required this.logCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LastWatchedVideoCard(logCubit:logCubit),
            SizedBox(height: 16.h),
            const VideoSummaryCard(),
            SizedBox(height: 16.h),
            TotalVideoCount(videos: user![0].videos!),
            SizedBox(height: 35.h),
            const QuickVideosSection(),
            SizedBox(height: 35.h),
            _buildHorizontalVideoCarousel(context,logCubit),
          ],
        ),
      ),
    );
  }
  }

  
class VideoSummaryCard extends StatelessWidget {
  const VideoSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Video Özet Sayfası",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Icon(Icons.keyboard_arrow_right, color: Colors.blue[200]),
            ],
          ),
        ),
      ),
    );
  }
}
class TotalVideoCount extends StatelessWidget {
  final List<Videos> videos;

  const TotalVideoCount({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Sistemde Bulunan Toplam Video Sayısı: ${videos.length}",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}



Widget _buildHorizontalVideoCarousel(BuildContext context, LoginCubit logCubit) {
  //final state = context.read<LoginCubit>().state;

  if (logCubit.state.lastWatchedVideo == null) {
    return const Center(child: Text("No videos available."));
  }
  
  final videoThumbnails = logCubit.state.lastWatchedVideo!
      .map((video) => video.url)
      .where((url) => url != null)
      .map((url) {
        final videoId = YoutubePlayer.convertUrlToId(url!);
        return videoId != null
            ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
            : null;
      })
      .cast<String>()
      .toList();

  return HorizontalVideoCarousel(
    videoThumbnails: videoThumbnails,
    user: logCubit.state.lastWatchedVideo,
  );
}


class HorizontalVideoCarousel extends StatelessWidget {
  final List<String> videoThumbnails;
  final List<Videos>? user;

  const HorizontalVideoCarousel({
    super.key,
    required this.videoThumbnails,
    this.user,
  });

  static CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            buttonCarouselController.previousPage();
          },
          icon: const Icon(Icons.keyboard_arrow_left),
        ),
        Expanded(
          child: CarouselSlider.builder(
            carouselController: buttonCarouselController,
            itemCount: videoThumbnails.isNotEmpty
                ? videoThumbnails.length
                : (user != null ? user!.length : 0),
            options: CarouselOptions(
              autoPlay: true,
              height: 100.0, // video
              enableInfiniteScroll: false,
              viewportFraction: 0.5,
              enlargeCenterPage: true,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return BlocBuilder<VideoCubit, VideoState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      if (user != null && user != null) {
                        context.push(
                          '/video',
                          //extra: user![0].videos![index],
                          extra: {
                            'video': user![index],
                            //'videos': user!,
                            'videoCubit': context.read<VideoCubit>(),
                          },
                        );
                      } else {
                        const SizedBox.shrink();
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          videoThumbnails.isNotEmpty
                              ? videoThumbnails[index]
                              : (user != null &&
                                      user != null &&
                                      index < user!.length &&
                                      user![index].url != null)
                                  ? 'https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(user![index].url!)}/hqdefault.jpg'
                                  : 'https://via.placeholder.com/150',
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error, size: 75);
                          },
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        IconButton(
          onPressed: () {
            buttonCarouselController.nextPage();
          },
          icon: const Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
