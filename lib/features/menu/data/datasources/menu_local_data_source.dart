import 'package:restoran/features/menu/domain/entities/datum.dart';

abstract class MenuLocalDataSource {
  Future<void> addData(List<Datum> data);

  Future<List<Datum>> fetchData();
}

class MenuLocalDataSourceImpl implements MenuLocalDataSource {
  @override
  Future<void> addData(List<Datum> data) {
    return null;
  }

  @override
  Future<List<Datum>> fetchData() {
    return null;
  }
}
