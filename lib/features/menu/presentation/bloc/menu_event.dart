import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/datum.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class GetMenuEvent extends MenuEvent {
  @override
  List<Object> get props => [];
}

class AddOrderEvent extends MenuEvent {
  final List<Datum> data;
  final String id;
  final String nama;
  final int harga;

  AddOrderEvent({
    @required this.id,
    @required this.nama,
    @required this.harga,
    @required this.data,
  });

  @override
  List<Object> get props => [
        id,
        nama,
        harga,
      ];
}
