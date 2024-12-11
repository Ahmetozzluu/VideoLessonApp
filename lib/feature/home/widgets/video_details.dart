 import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideoDetails extends StatelessWidget {
  final Videos? video;
 // 
  const VideoDetails({super.key, this.video});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "En Son İzlediğin Video",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8.h),
          Text(
            video?.title ?? "Ders",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 3.h),
          Row(
            children: [
              Icon(Icons.timer, size: 16.sp, color: Colors.blue[300]),
              SizedBox(width: 5.w),
              Text(
                video == null
                    ? "Toplam Süre: Bilinmiyor"
                    : "Toplam Süre: ${video!.duration}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            "Nerede kaldın: ${video?.currentTime ?? 'Henüz İzlenmedi'}",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

