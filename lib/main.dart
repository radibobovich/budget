import 'package:budget/core/data/categories_repository.dart';
import 'package:budget/core/data/transactions_repository.dart';
import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/routing/app_router.dart';
import 'package:budget/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

final getIt = GetIt.instance;
final _appRouter = AppRouter();
final _theme = AppTheme.nightTheme;
void main() async {
  getIt.registerSingleton<AppDatabase>(AppDatabase());
  getIt.registerLazySingleton<TransactionsRepository>(
      () => TransactionsRepositoryImpl(getIt.get<AppDatabase>()));
  getIt.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(getIt.get<AppDatabase>()));

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: _theme.canvasColor));
  initializeDateFormatting('ru_RU');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.nightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
