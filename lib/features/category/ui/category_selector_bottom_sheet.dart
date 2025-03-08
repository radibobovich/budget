import 'package:auto_route/auto_route.dart';
import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/widgets/bottom_actions.dart';
import 'package:budget/core/widgets/close_button.dart';
import 'package:budget/core/widgets/confirm_button.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/category/ui/bloc/category_selector_bloc.dart';
import 'package:budget/features/category/ui/bloc/events.dart';
import 'package:budget/features/category/ui/bloc/states.dart';
import 'package:budget/features/category/ui/create_category_bottom_sheet.dart';
import 'package:budget/features/category/ui/category_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelectorBottomSheet extends StatelessWidget {
  const CategorySelectorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Выберите категорию',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ConstrainedBox(
                  constraints:
                      BoxConstraints(maxHeight: context.window.height * 0.7),
                  child: SingleChildScrollView(
                    child: CategoriesWrappedList(),
                  )),
            ],
          ),
        ),
        SizedBox(height: 12),
        BottomActions(
            closeButton: CloseBackButton.forBottomActions(
                onTap: () => context.router.pop()),
            actionButton: LongButton.skip(
              borderColor: context.colors.border,
              onTap: () => context.router.pop(),
            )),
        SizedBox(height: 12),
      ],
    );
  }
}

class CategoriesWrappedList extends StatelessWidget {
  const CategoriesWrappedList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategorySelectorBloc, CategorySelectorState>(
      listenWhen: (previous, current) {
        if (previous is CategoriesLoaded && current is CategoriesLoaded) {
          if (current.didCreateNew == true) return true;
        }
        return false;
      },
      listener: (context, state) {
        final newCategory = (state as CategoriesLoaded).selected;
        context.router.pop(CategorySelected(newCategory));
      },
      builder: (context, state) {
        if (state is CategoriesLoading) return const SizedBox.shrink();
        if (state is CategoriesError) {
          return Center(child: Text(state.reason));
        }
        if (state is CategoriesLoaded) {
          final categories = state.categories;
          return Builder(builder: (context) {
            bool isSelected(Category c) => c.id == state.selected?.id;
            final categoriesChips = categories.map((category) {
              return CategoryButton.selectable(
                category: category,
                isSelected: isSelected(category),
                defaultBorderColor: context.colors.border,
                contrastColor: context.colors.contrast,
                canvasColor: context.theme.canvasColor,
                onTap: (context) {
                  final bloc = context.read<CategorySelectorBloc>();
                  bloc.add(CategorySelected(category));
                  context.router.pop(CategorySelected(category));
                },
                onDeselect: () {
                  final bloc = context.read<CategorySelectorBloc>();
                  bloc.add(CategorySelected(null));
                  context.router.pop(CategorySelected(null));
                },
              );
            }).toList();
            final allChips = [
              ...categoriesChips,
              CreateCategoryButton(onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (modalContext) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: modalContext.mediaQuery.viewInsets.bottom),
                        child: SafeArea(
                          child: CreateCategoryBottomSheet(
                            onAdd: (name, color) {
                              final bloc = context.read<CategorySelectorBloc>();
                              bloc.add(
                                  CategoryCreated(name: name, color: color));
                            },
                          ),
                        ),
                      );
                    });
              })
            ];
            return Wrap(spacing: 16, runSpacing: 16, children: allChips);
          });
        }
        throw UnimplementedError();
      },
    );
  }
}
