import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

abstract class CategoriesRepository {
  Stream<List<Category>> categories();
  Future<Category> addCategory({required String name, required Color color});
  Future<Category> updateCategory(
      {required int id, String? name, Color? color});
  Future<void> removeCategory(int id);
}

class CategoriesRepositoryImpl extends CategoriesRepository {
  CategoriesRepositoryImpl(this._db);
  final AppDatabase _db;

  @override
  Stream<List<Category>> categories() {
    final query = _db.select(_db.categories);
    return query.watch();
  }

  @override
  Future<Category> addCategory(
      {required String name, required Color color}) async {
    return _db.into(_db.categories).insertReturning(
        CategoriesCompanion.insert(name: name, color: color.hex));
  }

  @override
  Future<Category> updateCategory(
      {required int id, String? name, Color? color}) async {
    final returns = await (_db.update(_db.categories)
          ..where((c) => c.id.equals(id)))
        .writeReturning(
      CategoriesCompanion(
        id: Value(id),
        name: Value.absentIfNull(name),
        color: Value.absentIfNull(color?.hex),
      ),
    );
    if (returns.isEmpty) throw StateError('No category with $id found');
    return returns.first;
  }

  @override
  Future<void> removeCategory(int id) async {
    await (_db.delete(_db.categories)..where((c) => c.id.equals(id))).go();
  }
}
