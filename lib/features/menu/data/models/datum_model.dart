import 'package:meta/meta.dart';

import '../../domain/entities/datum.dart';

class DatumModel extends Datum {
  DatumModel({
    @required String id,
    @required String nama,
    @required int harga,
    @required String gambar,
  }) : super(
          id: id,
          nama: nama,
          harga: harga,
          gambar: gambar,
        );

  factory DatumModel.fromJson(Map<String, dynamic> json) => DatumModel(
        id: json["id"] == null ? null : json["id"],
        nama: json["nama"] == null ? null : json["nama"],
        harga: json["harga"] == null ? null : json["harga"],
        gambar: json["gambar"] == null ? null : json["gambar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "nama": nama ?? null,
        "harga": harga ?? null,
        "gambar": gambar ?? null,
      };
}
