import 'package:get_it/get_it.dart';

import 'core/utils/utils.dart';
import 'features/menu/data/datasources/menu_data_source.dart';
import 'features/menu/data/repositories/menu_repository_impl.dart';
import 'features/menu/domain/repositories/menu_repository.dart';
import 'features/menu/domain/usecases/get_menu.dart';
import 'features/menu/presentation/bloc/menu_bloc.dart';

var sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    () => MenuBloc(
      getMenu: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetMenu(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(
      dataSource: sl(),
    ),
  );

  sl.registerLazySingleton<MenuDataSource>(
    () => MenuDataSourceImple(
      utils: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => Utils(),
  );
}
