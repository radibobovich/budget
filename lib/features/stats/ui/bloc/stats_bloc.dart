import 'package:budget/core/data/categories_repository.dart';
import 'package:budget/core/data/transactions_repository.dart';
import 'package:budget/features/home/domain/transactions_categories_bundle.dart';
import 'package:budget/features/stats/ui/bloc/events.dart';
import 'package:budget/features/stats/ui/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TransactionsRepository _transactionsRepo;
  final CategoriesRepository _categoriesRepo;
  StatsBloc(this._transactionsRepo, this._categoriesRepo)
      : super(StatsLoading()) {
    on<StatsSubscribed>(_onStatsSubscribed);
  }

  Future<void> _onStatsSubscribed(event, Emitter emit) {
    final transactionsStream = _transactionsRepo.transactionsWithCategory();
    final categoriesStream = _categoriesRepo.categories();
    final combinedStream = Rx.combineLatest2(transactionsStream,
        categoriesStream, (ts, cs) => TransactionsCategoriesBundle(ts, cs));

    return emit.forEach(
      combinedStream,
      onData: (bundle) {
        return StatsLoaded(
            transactions: bundle.transactions, categories: bundle.categories);
      },
      onError: (error, stackTrace) {
        return StatsError(
            error,
            'Failed to get transactions or categories snapshot: $error',
            'Не удалось загрузить статистику');
      },
    );
  }
}
