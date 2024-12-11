import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dersgo_app/feature/notification/cubit/notification_cubit.dart';
import 'package:dersgo_app/feature/notification/cubit/notification_state.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state.notificationState == NotificationStates.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.notification.isEmpty) {
            return Center(
              child: Text(
                'Henüz bir ödeviniz yok.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
                    ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: state.notification.length,
            itemBuilder: (context, index) {
              final notification = state.notification[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: CircleAvatar(
                    backgroundColor: Colors.purple,
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    'Ödev',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  subtitle: Text(
                    notification['body'] ?? 'Mesaj yok',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                        ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      context.read<NotificationCubit>().deleteWork(
                          notification['userId'], notification['workId'], index);
                    },
                    child: const Text(
                      "Sil",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
