import 'package:budget/core/data/db/database.dart';
import 'package:flutter/material.dart';

abstract class CategorySelectorEvent {}

class SubscribedToCategories implements CategorySelectorEvent {
  final Category? maybeSelectedCategory;

  SubscribedToCategories(this.maybeSelectedCategory);
}

class CategoryCreated implements CategorySelectorEvent {
  final String name;
  final Color color;

  CategoryCreated({required this.name, required this.color});
}

class CategorySelected implements CategorySelectorEvent {
  final Category? selected;
  CategorySelected(this.selected);
}
