import 'package:budget/core/data/db/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'states.freezed.dart';

abstract class CategorySelectorState {}

class CategoriesLoading implements CategorySelectorState {}

@freezed
abstract class CategoriesLoaded
    with _$CategoriesLoaded
    implements CategorySelectorState {
  const factory CategoriesLoaded({
    required List<Category> categories,
    Category? selected,
    @Default(false) bool didCreateNew,
  }) = _CategoriesLoaded;
}

class CategoriesError implements CategorySelectorState {
  final String reason;
  final String reasonUI;
  CategoriesError(this.reason, this.reasonUI);
}
