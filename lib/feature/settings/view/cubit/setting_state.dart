// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_cubit.dart';

// ignore: must_be_immutable
class SettingsState extends Equatable {
  bool isTheme;
  SettingsState({
    required this.isTheme,
  });

  factory SettingsState.initial() {
    return SettingsState(isTheme: false);
  }


  @override
  List<Object> get props => [isTheme];

  SettingsState copyWith({
    bool? isTheme,
  }) {
    return SettingsState(
      isTheme: isTheme ?? this.isTheme,
    );
  }
}


