import 'package:auto_route/auto_route.dart';
import 'package:budget/core/routing/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: RootRoute.page, initial: true, children: [
          AutoRoute(page: HomeWrapperRoute.page),
          AutoRoute(page: StatsWrapperRoute.page),
        ]),
        AutoRoute(page: TransactionWrapperRoute.page),
      ];
}
