import 'package:auto_size_text/auto_size_text.dart';
import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:flutter/material.dart';

class CategoryButtonBuilder extends StatelessWidget {
  const CategoryButtonBuilder(
      {super.key, required this.category, required this.showModalSheet});
  final Function showModalSheet;
  final Category? category;
  @override
  Widget build(BuildContext context) {
    return CategoryButton.display(
      category: category,
      defaultBorderColor: context.colors.border,
      onTap: (context) => showModalSheet(),
      contrastColor: context.colors.contrast,
      mainColor: context.theme.canvasColor,
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.category,
    required this.onTap,
    this.onDeselect,
    this.isSelected = false,
    this.selectableMode = false,
    this.deselectBySeparateButton = true,
    this.fontSize = 18,
    required this.contrastColor,
    required this.mainColor,
    required this.fillColor,
    required this.borderColor,
    required this.circleColor,
    required this.textColor,
  });
  final Category? category;
  final Function(BuildContext context) onTap;
  final VoidCallback? onDeselect;
  final bool isSelected;
  final bool selectableMode;
  final bool deselectBySeparateButton;
  final double fontSize;

  final Color contrastColor;
  final Color mainColor;

  final Color fillColor;
  final Color borderColor;
  final Color circleColor;
  final Color? textColor;

  factory CategoryButton.display({
    required Category? category,
    required Function(BuildContext context) onTap,
    required Color defaultBorderColor,
    required Color contrastColor,
    required Color mainColor,
  }) {
    final fillColor = category?.flutterColor ?? Colors.transparent;
    final borderColor = category?.flutterColor ?? defaultBorderColor;
    final circleColor = category != null ? contrastColor : defaultBorderColor;
    final textColor = category != null
        ? fillColor.maybeInvertedTextColor(contrastColor, mainColor)
        : null;
    return CategoryButton(
      category: category,
      onTap: onTap,
      contrastColor: contrastColor,
      mainColor: mainColor,
      fillColor: fillColor,
      borderColor: borderColor,
      circleColor: circleColor,
      textColor: textColor,
    );
  }

  factory CategoryButton.selectable({
    required Category category,
    required Function(BuildContext context) onTap,
    required VoidCallback? onDeselect,
    required bool isSelected,
    required Color defaultBorderColor,
    required Color contrastColor,
    required Color canvasColor,
    bool deselectBySeparateButton = true,
  }) {
    final fillColor = isSelected ? category.flutterColor : Colors.transparent;
    final borderColor = isSelected ? contrastColor : defaultBorderColor;
    final circleColor = isSelected ? contrastColor : category.flutterColor;
    final textColor = isSelected
        ? fillColor.maybeInvertedTextColor(contrastColor, canvasColor)
        : null;
    return CategoryButton(
      category: category,
      onTap: onTap,
      onDeselect: onDeselect,
      isSelected: isSelected,
      selectableMode: true,
      deselectBySeparateButton: deselectBySeparateButton,
      fontSize: 16,
      contrastColor: contrastColor,
      mainColor: canvasColor,
      fillColor: fillColor,
      borderColor: borderColor,
      circleColor: circleColor,
      textColor: textColor,
    );
  }
  @override
  Widget build(BuildContext context) {
    assert(!selectableMode || category != null);
    final screenWidth = context.window.width;
    final maxTextWidth = screenWidth - 120;

    final double side = isSelected ? 25.5 : 28;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
          color: fillColor,
          borderRadius: BorderRadius.circular(100)),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              if (!deselectBySeparateButton) {
                isSelected ? onDeselect?.call() : onTap(context);
                return;
              }
              onTap(context);
            },
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 6, top: 6, bottom: 6, right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: circleColor),
                    child: SizedBox(height: side, width: side),
                  ),
                  SizedBox(width: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxTextWidth),
                    child: AutoSizeText(
                      category?.name ?? 'Выбрать категорию',
                      maxLines: 1,
                      minFontSize: 9,
                      maxFontSize: fontSize,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ),
                  category == null
                      ? Icon(Icons.chevron_right)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          if (isSelected && selectableMode && deselectBySeparateButton)
            DeselectButton(onDeselect: onDeselect, side: side),
        ],
      ),
    );
  }
}

class DeselectButton extends StatelessWidget {
  const DeselectButton(
      {super.key, required this.onDeselect, required this.side});

  final VoidCallback? onDeselect;
  final double side;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 6,
      top: 6,
      bottom: 6,
      child: GestureDetector(
        onTap: () {
          onDeselect?.call();
        },
        child: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
          child: SizedBox(
            height: side,
            width: side,
            child: Icon(Icons.remove, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class CreateCategoryButton extends StatelessWidget {
  const CreateCategoryButton({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: context.colors.categorySelectedBorder),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100)),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(100),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add),
              SizedBox(width: 8),
              Text(
                'Добавить',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
