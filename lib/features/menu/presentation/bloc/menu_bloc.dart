import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../domain/usecases/get_menu.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetMenu getMenu;

  MenuBloc({@required this.getMenu});

  @override
  MenuState get initialState => InitialMenuState();

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    if (event is GetMenuEvent) {
      yield* _mapLoadedMenu(event);
    } else if (event is AddOrderEvent) {
      yield* _mapLoadOrder(event);
    }
  }

  Stream<MenuState> _mapLoadedMenu(GetMenuEvent event) async* {
    yield LoadingState();
    try {
      final result = await getMenu();
      yield LoadedState(menu: result);
    } catch (e) {
      yield ErrorState(e);
    }
  }

  Stream<MenuState> _mapLoadOrder(AddOrderEvent event) async* {
    var state = this.state as LoadOrderState;
    // List<Datum> data = [];

    // data.add(Datum(
    //   id: event.id,
    //   harga: event.harga,
    //   nama: event.nama,
    //   gambar: "",
    // ));

    yield LoadOrderState(menu: state.menu + event.data);
  }
}
