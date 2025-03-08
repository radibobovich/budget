import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get value => integer()();
  BoolColumn get isIncome => boolean()();
  DateTimeColumn get date => dateTime()();
  IntColumn get category => integer()
      .nullable()
      .references(Categories, #id, onDelete: KeyAction.setNull)();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();
  TextColumn get color => text().withLength(min: 8, max: 8)();
}

class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get value => integer()();
  late IntColumn category = integer().references(Categories, #id)();
}

@DriftDatabase(tables: [Transactions, Categories, Budgets])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (migrator) async {
        await migrator.createAll();
        await batch((batch) async {
          batch.insertAll(categories, [
            CategoriesCompanion.insert(name: 'Питание', color: 'FF13CD9F'),
            CategoriesCompanion.insert(name: 'Развлечения', color: 'FFFDED39'),
            CategoriesCompanion.insert(name: 'Транспорт', color: 'FFB3E6FD'),
          ]);
        });
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
