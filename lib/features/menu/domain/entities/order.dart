import 'package:equatable/equatable.dart';

class Order {
  final String id;
  final String nama;
  final int harga;
  int jumlah;
  int total;

  Order({
    this.id,
    this.nama,
    this.harga,
    this.jumlah,
    this.total,
  });

  Order copyWith({
    String id,
    String nama,
    int harga,
    int jumlah,
    int total,
  }) =>
      Order(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        harga: harga ?? this.harga,
        jumlah: jumlah ?? this.jumlah,
        total: total ?? this.total,
      );

  // @override
  // List<Object> get props => [id, nama, harga, jumlah, total];
}
