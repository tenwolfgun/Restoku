import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/datum.dart';
import '../../domain/entities/menu.dart';

abstract class MenuState extends Equatable {
  const MenuState();
}

class InitialMenuState extends MenuState {
  @override
  List<Object> get props => [];
}

class LoadingState extends InitialMenuState {}

class LoadedState extends InitialMenuState {
  final Menu menu;

  LoadedState({@required this.menu});

  @override
  List<Object> get props => [menu];
}

class LoadOrderState extends InitialMenuState {
  final List<Datum> menu;

  LoadOrderState({@required this.menu});

  LoadOrderState copyWith({
    List<Datum> menu,
  }) =>
      LoadOrderState(menu: menu ?? this.menu);

  @override
  List<Object> get props => [menu];
}

class ErrorState extends InitialMenuState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
