import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/domain/transaction_with_category.dart';

class TransactionsCategoriesBundle {
  const TransactionsCategoriesBundle(this.transactions, this.categories);
  final List<TransactionWithCategory> transactions;
  final List<Category> categories;
}
