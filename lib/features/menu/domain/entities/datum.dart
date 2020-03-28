import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Datum extends Equatable {
  final String id;
  final String nama;
  final int harga;
  final String gambar;

  Datum({
    @required this.id,
    @required this.nama,
    @required this.harga,
    @required this.gambar,
  });

  Datum copyWith({
    String id,
    String nama,
    int harga,
    String gambar,
  }) =>
      Datum(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        harga: harga ?? this.harga,
        gambar: gambar ?? this.gambar,
      );

  @override
  List<Object> get props => [
        id,
        nama,
        harga,
        gambar,
      ];
}
