
import 'package:dersgo_app/feature/video/cubit/video_cubit.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LessonView extends StatefulWidget {
  final List<Videos>? video;

  const LessonView({super.key, required this.video});

  @override
  LessonViewState createState() => LessonViewState();
}

class LessonViewState extends State<LessonView> {
  late List<Map<String, dynamic>> subjects;
  

  @override
  void initState() {
    super.initState();

    final mathVideos = widget.video!.take(5).toList();
    final fenVideos = widget.video!.skip(5).toList();

    subjects = [
      {
        'title': 'Matematik Dersi Videoları',
        'videos': mathVideos,
        //'color': Colors.blue.shade50,
      },
      {
        'title': 'Fen Dersi Videoları',
        'videos': fenVideos,
        //'color': Colors.green.shade50,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  final subject = subjects[index];
                  final List<Videos> videos = subject['videos'];
                  return Card(
                   // color: subject['color'],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subject['title'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 10),
                          ...videos.map((video) {
                            return InkWell(
                              onTap: (){
                                context.push('/video', extra: {
                                  'video':video,
                                  'videoCubit': context.read<VideoCubit>(),
                                });
                              },
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.blueAccent,
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  video.title ?? 'Video Başlığı Yok',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
