import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/domain/transaction_with_category.dart';
import 'package:budget/core/misc/exceptions.dart';
import 'package:drift/drift.dart';

abstract class TransactionsRepository {
  Stream<List<TransactionWithCategory>> transactionsWithCategory();
  Future<Transaction?> getTransaction(int id);
  Future<TransactionWithCategory> getTransactionWithCategory(int id);

  Future<Transaction> addTransaction(
      {required String title,
      required int valueKopecks,
      required bool isIncome,
      required DateTime? date,
      int? categoryId});

  Future<void> updateTransaction(
      {required int id,
      String? title,
      int? valueKopecks,
      bool? isIncome,
      DateTime? date,
      required int? Function()? categoryIdSetter});

  Future<void> removeTransaction(int id);
}

class TransactionsRepositoryImpl implements TransactionsRepository {
  TransactionsRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Stream<List<TransactionWithCategory>> transactionsWithCategory() {
    final query = _db.select(_db.transactions).join([
      leftOuterJoin(_db.categories,
          _db.categories.id.equalsExp(_db.transactions.category))
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(row.readTable(_db.transactions),
            row.readTableOrNull(_db.categories));
      }).toList();
    });
  }

  @override
  Future<Transaction?> getTransaction(int id) async {
    final transaction = await (_db.select(_db.transactions)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return transaction;
  }

  @override
  Future<TransactionWithCategory> getTransactionWithCategory(int id) async {
    final joinedStatement =
        (_db.select(_db.transactions)..where((t) => t.id.equals(id))).join([
      leftOuterJoin(
        _db.categories,
        _db.categories.id.equalsExp(_db.transactions.category),
      ),
    ]);

    final TypedResult? result =
        await (joinedStatement..limit(1)).getSingleOrNull();
    if (result == null) throw TransactionNotFoundException(id);
    return TransactionWithCategory(result.readTable(_db.transactions),
        result.readTableOrNull(_db.categories));
  }

  @override
  Future<Transaction> addTransaction({
    required String title,
    required int valueKopecks,
    required bool isIncome,
    DateTime? date,
    int? categoryId,
  }) {
    return _db.into(_db.transactions).insertReturning(
          TransactionsCompanion.insert(
            title: title,
            value: valueKopecks,
            isIncome: isIncome,
            date: date ?? DateTime.now(),
            category: Value(categoryId),
          ),
        );
  }

  @override
  Future<Transaction> updateTransaction(
      {required int id,
      String? title,
      int? valueKopecks,
      bool? isIncome,
      DateTime? date,
      required int? Function()? categoryIdSetter}) async {
    final returns = await (_db.update(_db.transactions)
          ..where((t) => t.id.equals(id)))
        .writeReturning(TransactionsCompanion(
      id: Value(id),
      title: Value.absentIfNull(title),
      value: Value.absentIfNull(valueKopecks),
      isIncome: Value.absentIfNull(isIncome),
      date: Value.absentIfNull(date),
      category:
          categoryIdSetter != null ? Value(categoryIdSetter()) : Value.absent(),
    ));

    if (returns.isEmpty) throw TransactionNotFoundException(id);
    return returns.first;
  }

  @override
  Future<void> removeTransaction(int id) async {
    await (_db.delete(_db.transactions)..where((t) => t.id.equals(id))).go();
  }
}
