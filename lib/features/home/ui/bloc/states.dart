import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/domain/transaction_with_category.dart';
import 'package:budget/features/home/domain/calculator.dart';
import 'package:budget/features/home/domain/date_range.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

abstract class HomeState {}

class HomeLoading implements HomeState {}

@freezed
abstract class HomeLoaded with _$HomeLoaded implements HomeState {
  factory HomeLoaded({
    required List<TransactionWithCategory> transactionsWithCategory,
    required List<Category> categories,
    @Default({}) Set<int> categoriesIdFilter,
    @Default(null) DateTime? startDateFilter,
    @Default(null) DateTime? endDateFilter,
  }) = _HomeLoaded;

  HomeLoaded._();

  late final List<TransactionWithCategory> filtered = filter();

  late final calculator = Calculator(transactions: filtered);
  int get totalIncomes => calculator.sum(TransactionType.incomes);
  int get totalExpenses => calculator.sum(TransactionType.expenses);

  bool get hasFilters {
    return categoriesIdFilter.isNotEmpty ||
        startDateFilter != null ||
        endDateFilter != null;
  }

  int get filtersCount {
    int count = 0;
    count += categoriesIdFilter.length;
    if (startDateFilter != null) count += 1;
    if (endDateFilter != null) count += 1;
    return count;
  }

  List<TransactionWithCategory> filter() {
    final byCategories = _filterByCategories(transactionsWithCategory);
    final byCategoriesAndDate = _filterByDate(byCategories);
    return byCategoriesAndDate.toList();
  }

  Iterable<TransactionWithCategory> _filterByCategories(
      Iterable<TransactionWithCategory> items) {
    if (categoriesIdFilter.isEmpty) return items;
    return items.where((t) {
      return categoriesIdFilter.contains(t.category?.id);
    }).toList();
  }

  Iterable<TransactionWithCategory> _filterByDate(
      Iterable<TransactionWithCategory> items) {
    if (startDateFilter == null && endDateFilter == null) return items;
    final range = DateRange(
        startDateFilter ?? DateTime(1970), endDateFilter ?? DateTime(2100));
    return items.where((t) {
      final transactionDate = t.transaction.date;
      return range.isInRange(transactionDate);
    }).toList();
  }
}

class HomeError implements HomeState {
  final Object e;
  final String reason;
  final String reasonUI;
  HomeError(this.e, this.reason, this.reasonUI);
}
