import 'package:budget/core/data/db/database.dart';

class TransactionWithCategory {
  TransactionWithCategory(this.transaction, this.category);
  final Transaction transaction;
  final Category? category;
}
