// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:budget/features/home/ui/home_wrapper_screen.dart' as _i1;
import 'package:budget/features/navigation/root_screen.dart' as _i2;
import 'package:budget/features/stats/ui/statistics_wrapper_screen.dart' as _i3;
import 'package:budget/features/transaction/ui/transaction_wrapper_screen.dart'
    as _i4;
import 'package:flutter/material.dart' as _i6;

/// generated route for
/// [_i1.HomeWrapperScreen]
class HomeWrapperRoute extends _i5.PageRouteInfo<void> {
  const HomeWrapperRoute({List<_i5.PageRouteInfo>? children})
    : super(HomeWrapperRoute.name, initialChildren: children);

  static const String name = 'HomeWrapperRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i1.HomeWrapperScreen());
    },
  );
}

/// generated route for
/// [_i2.RootScreen]
class RootRoute extends _i5.PageRouteInfo<void> {
  const RootRoute({List<_i5.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.RootScreen();
    },
  );
}

/// generated route for
/// [_i3.StatsWrapperScreen]
class StatsWrapperRoute extends _i5.PageRouteInfo<void> {
  const StatsWrapperRoute({List<_i5.PageRouteInfo>? children})
    : super(StatsWrapperRoute.name, initialChildren: children);

  static const String name = 'StatsWrapperRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return _i5.WrappedRoute(child: const _i3.StatsWrapperScreen());
    },
  );
}

/// generated route for
/// [_i4.TransactionWrapperScreen]
class TransactionWrapperRoute
    extends _i5.PageRouteInfo<TransactionWrapperRouteArgs> {
  TransactionWrapperRoute({
    _i6.Key? key,
    required int? transactionId,
    bool? createAsIncome,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         TransactionWrapperRoute.name,
         args: TransactionWrapperRouteArgs(
           key: key,
           transactionId: transactionId,
           createAsIncome: createAsIncome,
         ),
         rawPathParams: {
           'transactionId': transactionId,
           'createAsIncome': createAsIncome,
         },
         initialChildren: children,
       );

  static const String name = 'TransactionWrapperRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TransactionWrapperRouteArgs>(
        orElse:
            () => TransactionWrapperRouteArgs(
              transactionId: pathParams.optInt('transactionId'),
              createAsIncome: pathParams.optBool('createAsIncome'),
            ),
      );
      return _i5.WrappedRoute(
        child: _i4.TransactionWrapperScreen(
          key: args.key,
          transactionId: args.transactionId,
          createAsIncome: args.createAsIncome,
        ),
      );
    },
  );
}

class TransactionWrapperRouteArgs {
  const TransactionWrapperRouteArgs({
    this.key,
    required this.transactionId,
    this.createAsIncome,
  });

  final _i6.Key? key;

  final int? transactionId;

  final bool? createAsIncome;

  @override
  String toString() {
    return 'TransactionWrapperRouteArgs{key: $key, transactionId: $transactionId, createAsIncome: $createAsIncome}';
  }
}
