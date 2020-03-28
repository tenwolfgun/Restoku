import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'datum.dart';

class Menu extends Equatable {
  final List<Datum> data;

  Menu({@required this.data});

  Menu copyWith({
    List<Datum> data,
  }) =>
      Menu(
        data: data ?? this.data,
      );

  @override
  List<Object> get props => [data];
}
