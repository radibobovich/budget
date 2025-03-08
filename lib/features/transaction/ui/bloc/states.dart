import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/domain/transaction_with_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'states.freezed.dart';

abstract class TransactionState {}

class TransactionLoading implements TransactionState {}

@freezed
abstract class TransactionDraft
    with _$TransactionDraft
    implements TransactionState {
  const factory TransactionDraft({
    required String title,
    required bool isIncome,
    required DateTime date,
    Category? category,
    int? value,
    int? id,
  }) = _TransactionDraft;

  factory TransactionDraft.fromTransaction(
      TransactionWithCategory transaction) {
    final t = transaction.transaction;
    return TransactionDraft(
      title: t.title,
      isIncome: t.isIncome,
      category: transaction.category,
      value: t.value,
      date: t.date,
      id: t.id,
    );
  }
}

class TransactionError implements TransactionState {
  final Object e;
  final String reason;
  final String reasonUI;
  TransactionError(this.e, this.reason, this.reasonUI);
}
