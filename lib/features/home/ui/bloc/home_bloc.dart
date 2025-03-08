import 'package:budget/core/data/categories_repository.dart';
import 'package:budget/core/data/transactions_repository.dart';
import 'package:budget/features/home/domain/transactions_categories_bundle.dart';
import 'package:budget/features/home/ui/bloc/events.dart';
import 'package:budget/features/home/ui/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TransactionsRepository _transactionsRepo;
  final CategoriesRepository _categoriesRepo;
  HomeBloc(this._transactionsRepo, this._categoriesRepo)
      : super(HomeLoading()) {
    on<HomeTransactionsSubscribed>(_onHomeTransactionsSubscribed);
    on<HomeCategoryFilterAdded>(_onCategoryFilterAdd);
    on<HomeCategoryFilterRemoved>(_onCategoryFilterRemove);
    on<HomeCategoryFilterReset>(_onCategoryFilterReset);
    on<HomeDateFilterSet>(_onDateFilterSet);
  }

  Future<void> _onHomeTransactionsSubscribed(event, Emitter emit) {
    final transactionsStream = _transactionsRepo.transactionsWithCategory();
    final categoriesStream = _categoriesRepo.categories();
    final combinedStream = Rx.combineLatest2(transactionsStream,
        categoriesStream, (ts, cs) => TransactionsCategoriesBundle(ts, cs));

    return emit.forEach(
      combinedStream,
      onData: (bundle) {
        return HomeLoaded(
            transactionsWithCategory: bundle.transactions,
            categories: bundle.categories);
      },
      onError: (error, stackTrace) {
        return HomeError(error, 'Failed to fetch transactions and categories',
            'Не удалось загрузить данные транзакций');
      },
    );
  }

  void _onCategoryFilterAdd(HomeCategoryFilterAdded event, Emitter emit) {
    if (state is! HomeLoaded) return;
    final currentCategories = (state as HomeLoaded).categoriesIdFilter;
    final newCategories = {...currentCategories, event.categoryId};

    emit((state as HomeLoaded).copyWith(categoriesIdFilter: newCategories));
  }

  void _onCategoryFilterRemove(HomeCategoryFilterRemoved event, Emitter emit) {
    if (state is! HomeLoaded) return;
    final currentCategories = (state as HomeLoaded).categoriesIdFilter;
    final newCategories = {...currentCategories}..remove(event.categoryId);

    emit((state as HomeLoaded).copyWith(categoriesIdFilter: newCategories));
  }

  void _onCategoryFilterReset(event, Emitter emit) {
    if (state is! HomeLoaded) return;
    emit((state as HomeLoaded).copyWith(categoriesIdFilter: {}));
  }

  void _onDateFilterSet(HomeDateFilterSet event, Emitter emit) {
    if (state is! HomeLoaded) return;
    final loadedState = state as HomeLoaded;
    emit(loadedState.copyWith(
      startDateFilter:
          event.start != null ? event.start!() : loadedState.startDateFilter,
      endDateFilter:
          event.end != null ? event.end!() : loadedState.endDateFilter,
    ));
  }
}
