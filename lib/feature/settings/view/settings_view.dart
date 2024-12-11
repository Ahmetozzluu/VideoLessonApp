import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dersgo_app/feature/login/cubit/login_cubit.dart';
import 'package:dersgo_app/feature/settings/view/cubit/settings_cubit.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';

class SettingsPage extends StatefulWidget {
  final List<UserModel>? user;
  const SettingsPage({
    super.key,
    this.user,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          _buildSectionTitle('Tercihler'),
          _buildSwitchTile(
            title: 'Koyu Tema',
            icon: const Icon(Icons.dark_mode_outlined),
            value: isDarkTheme,
            context: context,
          ),
          /*_buildSwitchTile(
            title: 'Bildirimleri Aç/Kapat',
            icon: const Icon(Icons.notifications_active_outlined),
            value: isDarkTheme,
            context: context,
          ),*/
          const Divider(height: 40),
          _buildSectionTitle('Hesap Yönetimi'),
          customListTile(
            title: 'Profili Güncelle',
            icon: const Icon(Icons.person_outline),
            onTap: () {
              context.push('/profile');
            },
          ),
          customListTile(
            title: 'Hesabı Sil',
            icon: const Icon(Icons.delete_forever_outlined),
            onTap: () {
              if (widget.user != null && widget.user!.isNotEmpty) {
                _showDeleteAccountDialog(context, widget.user![0].id!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kullanıcı verisi bulunamadı')),
                );
              }
            },
            color: Colors.red,
          ),
          const Divider(height: 40),
          _buildSectionTitle('Oturum'),
          customListTile(
            title: 'Çıkış Yap',
            icon: const Icon(Icons.logout_outlined),
            onTap: () {
              context.pushReplacement('/');
            },
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, int userId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hesabı Sil'),
          content: const Text('Hesabınızı silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Hayır'),
            ),
            TextButton(
              onPressed: () {
                context.read<LoginCubit>().updateUserIsActive(userId, false);
                context.pop();
              },
              child: const Text('Evet'),
            ),
          ],
        );
      },
    );
  }

  Widget customListTile({
    required String title,
    required Icon icon,
    required VoidCallback onTap,
    Color color = Colors.grey,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: Icon(icon.icon, color: color),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
Widget _buildSwitchTile({
  required String title,
  required Icon icon,
  required bool value,
  required BuildContext context,
}) {
  return BlocBuilder<SettingsCubit, SettingsState>(
    builder: (context, state) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        trailing: Switch(
          value: state.isTheme,
          onChanged: (value) {
            context.read<SettingsCubit>().isThemeChanged(value);
          },
          activeColor: const Color.fromARGB(255, 62, 113, 215),
          inactiveThumbColor: Colors.black45,
        ),
      );
    },
  );
}

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
