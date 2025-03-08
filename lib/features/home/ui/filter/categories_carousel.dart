import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/category/ui/category_button.dart';
import 'package:flutter/material.dart';

class CategoriesCarousel extends StatelessWidget {
  const CategoriesCarousel({
    super.key,
    required this.categories,
    required this.selectedIds,
    required this.onTap,
    required this.onDeselect,
  });
  final List<Category> categories;
  final Set<int> selectedIds;
  final void Function(Category category) onTap;
  final void Function(Category category) onDeselect;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: CustomScrollView(scrollDirection: Axis.horizontal, slivers: [
        SliverToBoxAdapter(child: const SizedBox(width: 16)),
        SliverList.separated(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return CategoryButton.selectable(
                category: category,
                onTap: (_) => onTap(category),
                onDeselect: () => onDeselect(category),
                isSelected: selectedIds.contains(category.id),
                defaultBorderColor: context.colors.border,
                deselectBySeparateButton: false,
                contrastColor: context.colors.contrast,
                canvasColor: context.theme.canvasColor,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 8)),
        SliverToBoxAdapter(child: const SizedBox(width: 16)),
      ]),
    );
  }
}
