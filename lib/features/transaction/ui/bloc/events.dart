import 'package:budget/core/data/db/database.dart';
import 'package:flutter/material.dart';

abstract class TransactionEvent {}

class TransactionTypeInitialized implements TransactionEvent {
  final bool createAsIncome;
  TransactionTypeInitialized(this.createAsIncome);
}

class TransactionFetched implements TransactionEvent {}

class TransactionTypeToggled implements TransactionEvent {}

class TransactionCategorySet implements TransactionEvent {
  final Category? category;
  TransactionCategorySet(this.category);
}

class TransactionDateSet implements TransactionEvent {
  final DateTime date;
  TransactionDateSet(this.date);
}

class TransactionDeleted implements TransactionEvent {
  final VoidCallback onDeleted;
  TransactionDeleted(this.onDeleted);
}

class TransactionSaved implements TransactionEvent {
  final String title;
  final int valueKopecks;
  TransactionSaved({required this.title, required this.valueKopecks});
}

abstract class TransactionGotError implements TransactionEvent {
  final Object e;
  final int? id;
  String get reason;
  String get reasonUI;
  TransactionGotError(this.e, this.id);
}

class TransactionGotWriteError implements TransactionGotError {
  @override
  final Object e;
  @override
  final int? id;
  const TransactionGotWriteError(this.e, this.id);

  @override
  String get reason => 'Failed to create/modify transaction with id:$id';

  @override
  String get reasonUI => 'Не удалось создать/отредактировать транзакцию';
}

class TransactionGotReadError implements TransactionGotError {
  @override
  final Object e;
  @override
  final int? id;
  const TransactionGotReadError(this.e, this.id);

  @override
  String get reason => 'Failed to read transaction with id:$id';

  @override
  String get reasonUI => 'Не удалось загрузить транзацию';
}
