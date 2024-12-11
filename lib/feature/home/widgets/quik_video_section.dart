
import 'package:flutter/material.dart';


class QuickVideosSection extends StatelessWidget {
  const QuickVideosSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            /*final quickVideoTitle = (state.selectedVideos?.isNotEmpty ?? false)
              ? state.selectedVideos![0].title!.split(':').first
              : "Tüm Dersler";*/
            Text.rich(
      TextSpan(
        text: 'Hızlı Videolar: ',
        style: Theme.of(context).textTheme.headlineSmall,
        children: const [
          TextSpan(
            text: "En son izlenenler",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ));
  }
}
