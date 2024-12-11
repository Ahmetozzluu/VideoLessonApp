import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';


part 'setting_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial()){
    _loadThemePreference(); 
  }

  void isThemeChanged(bool isTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isTheme);  
    emit(state.copyWith(isTheme: isTheme));
  }

  
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkTheme = prefs.getBool('isDarkTheme') ?? false;  // Varsayılan olarak false al
    emit(state.copyWith(isTheme: isDarkTheme));
  }
}

// herhangi bir kullanıcı en son hangi videoda kalmış onun bilgisini tutabilirsin.
