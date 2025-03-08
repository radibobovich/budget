import 'package:auto_route/auto_route.dart';
import 'package:budget/core/widgets/close_button.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/category/domain/category_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef AddCategoryCallback = void Function(String name, Color color);

class CreateCategoryBottomSheet extends StatefulWidget {
  const CreateCategoryBottomSheet({super.key, required this.onAdd});
  final AddCategoryCallback onAdd;
  @override
  State<CreateCategoryBottomSheet> createState() =>
      _CreateCategoryBottomSheetState();
}

class _CreateCategoryBottomSheetState extends State<CreateCategoryBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final defaultColors = CategoryColors.defaultColors;
  Color currentColor = CategoryColors.pickRandom();

  late final focusNode = FocusNode()..requestFocus();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Создать категорию',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                CloseBackButton(onTap: () => context.router.pop())
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                CategoryColorCircle(
                    color: currentColor, isSelected: true, size: 40),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                      controller: nameController,
                      focusNode: focusNode,
                      cursorColor: context.colors.cursorColor,
                      textCapitalization: TextCapitalization.sentences,
                      maxLength: 24,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      autocorrect: false,
                      onSubmitted: (name) {
                        if (name.trim().isEmpty) {
                          focusNode.requestFocus();
                          return;
                        }
                        widget.onAdd(name, currentColor);
                        context.router.pop();
                      },
                      style: TextStyle(fontSize: 18),
                      decoration: _getInputDecoration('Название категории')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                  child: ColorCarousel(
                colors: CategoryColors.defaultColors,
                selected: currentColor,
                height: 40,
                onSelect: (color) {
                  setState(() => currentColor = color);
                },
              ))
            ],
          ),
          const SizedBox(height: 24)
        ],
      ),
    );
  }

  InputDecoration _getInputDecoration(String? hintText) {
    final border = UnderlineInputBorder(
        borderSide: BorderSide(color: context.colors.border, width: 2));
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
      counterText: '',
    );
  }
}

class CategoryColorCircle extends StatelessWidget {
  const CategoryColorCircle(
      {super.key,
      required this.color,
      required this.isSelected,
      this.onTap,
      required this.size});
  final Color color;
  final bool isSelected;
  final double size;
  final Function(Color color)? onTap;
  @override
  Widget build(BuildContext context) {
    assert(size > 8);
    final sizeWithBorder = isSelected ? size - 8 : size;
    return Container(
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: isSelected
            ? Border.all(
                width: 4,
                color: context.colors.categorySelectedBorder.withAlpha(144),
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: context.colors.colorChipSplash,
            borderRadius: BorderRadius.circular(100),
            onTap: onTap != null ? () => onTap?.call(color) : null,
            child: SizedBox(width: sizeWithBorder, height: sizeWithBorder)),
      ),
    );
  }
}

class ColorCarousel extends StatelessWidget {
  const ColorCarousel({
    super.key,
    required this.colors,
    required this.selected,
    required this.height,
    required this.onSelect,
  });
  final List<Color> colors;
  final Color selected;
  final double height;
  final Function(Color color) onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverToBoxAdapter(child: SizedBox(width: 16)),
          SliverList.separated(
            itemCount: colors.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final color = colors[index];
              return CategoryColorCircle(
                color: color,
                size: height,
                isSelected: color == selected,
                onTap: (color) => onSelect(color),
              );
            },
          ),
          SliverToBoxAdapter(child: const SizedBox(width: 16)),
        ],
      ),
    );
  }
}
