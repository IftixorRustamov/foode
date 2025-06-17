part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeToggled extends ThemeEvent {
  const ThemeToggled({required this.brightness});

  final Brightness brightness;

  @override
  List<Object> get props => [brightness];
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}
