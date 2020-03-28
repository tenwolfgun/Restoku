import 'dart:convert';

import 'package:meta/meta.dart';

import '../../domain/entities/datum.dart';
import '../../domain/entities/menu.dart';
import 'datum_model.dart';

Menu menuFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel extends Menu {
  MenuModel({
    @required List<Datum> data,
  }) : super(data: data);

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"]
                .map((x) => x == null ? null : DatumModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data ?? null,
      };
}
