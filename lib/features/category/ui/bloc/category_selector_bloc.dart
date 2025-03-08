import 'package:budget/core/data/categories_repository.dart';
import 'package:budget/core/data/db/database.dart';
import 'package:budget/features/category/ui/bloc/events.dart';
import 'package:budget/features/category/ui/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelectorBloc
    extends Bloc<CategorySelectorEvent, CategorySelectorState> {
  final CategoriesRepository _categoriesRepo;
  CategorySelectorBloc(this._categoriesRepo) : super(CategoriesLoading()) {
    on<SubscribedToCategories>(_subscribeToCategories);
    on<CategoryCreated>(_onCategoryCreated);
    on<CategorySelected>(_onCategorySelected);
  }

  Future<void> _subscribeToCategories(
      SubscribedToCategories event, Emitter emit) {
    final stream = _categoriesRepo.categories();
    return emit.forEach(
      stream,
      onData: (categories) {
        return CategoriesLoaded(
            categories: categories, selected: event.maybeSelectedCategory);
      },
      onError: (error, stackTrace) {
        return CategoriesError(
            'Failed to get categories', 'Не удалось загрузить категории');
      },
    );
  }

  Future<void> _onCategoryCreated(CategoryCreated event, Emitter emit) async {
    final category = await _addCategory(name: event.name, color: event.color);
    if (state is CategoriesLoaded) {
      emit((state as CategoriesLoaded)
          .copyWith(selected: category, didCreateNew: true));
    }
  }

  Future<void> _onCategorySelected(CategorySelected event, Emitter emit) async {
    if (state is CategoriesLoaded) {
      emit((state as CategoriesLoaded).copyWith(selected: event.selected));
    }
  }

  Future<Category> _addCategory(
      {required String name, required Color color}) async {
    final newCategory =
        await _categoriesRepo.addCategory(name: name, color: color);
    return newCategory;
  }
}
