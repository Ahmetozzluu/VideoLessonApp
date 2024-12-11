// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dersgo_app/feature/lesson/view/lesson_view.dart';
import 'package:dersgo_app/feature/login/cubit/login_cubit.dart';
import 'package:dersgo_app/feature/notification/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dersgo_app/feature/home/view/home_page.dart';
import 'package:dersgo_app/feature/notification/notification.dart';
import 'package:dersgo_app/feature/settings/view/settings_view.dart';
import 'package:dersgo_app/feature/video/cubit/video_cubit.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';

enum HomePageType { home, lessons, notifications, settings }

class HomeView extends StatefulWidget {
  final List<UserModel>? user;
  final List<Videos>? videos;

  const HomeView({
    super.key,
    this.user,
    this.videos,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  late final PageController _pageController;

  final Map<HomePageType, String> _appBarTitles = {
    HomePageType.home: 'Ana Sayfa',
    HomePageType.lessons: 'Dersler',
    HomePageType.notifications: 'Ödevler',
    HomePageType.settings: 'Ayarlar',
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  HomePageType get _currentPageType => HomePageType.values[_currentIndex];

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VideoCubit()),
        BlocProvider(create: (context)=> NotificationCubit(widget.user![0].id!,initialWorks: widget.user![0].works,)),
      ],
      child: Scaffold(
        appBar: customAppBar(context),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            HomePage(user: widget.user, logCubit: loginCubit),
            LessonView(video: widget.user![0].videos),
             const NotificationPage(),
            SettingsPage(
              user: widget.user,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Ana Sayfa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Dersler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Ödevler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Ayarlar',
            ),
          ],
        ),
      ),
    );
  }

  AppBar customAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        _appBarTitles[_currentPageType] ?? '',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      centerTitle: true,
      elevation: 0,
    );
  }
}
