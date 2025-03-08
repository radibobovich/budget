import 'package:auto_route/auto_route.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(
      {super.key, required this.tabsRouter, required this.height});
  final TabsRouter tabsRouter;
  final double height;
  @override
  Widget build(BuildContext context) {
    final verticalButtonInset = height * 0.1;
    return SizedBox(
      height: height,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: context.theme.canvasColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TabButton(
              icon: Icon(Icons.home),
              label: 'Главная',
              onTap: () => tabsRouter.setActiveIndex(0),
              isSelected: tabsRouter.activeIndex == 0,
              verticalInset: verticalButtonInset,
            ),
            TabButton(
              icon: Icon(Icons.analytics),
              label: 'Статистика',
              onTap: () => tabsRouter.setActiveIndex(1),
              isSelected: tabsRouter.activeIndex == 1,
              verticalInset: verticalButtonInset,
            )
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isSelected,
    required this.verticalInset,
  });
  final Icon icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final double verticalInset;
  @override
  Widget build(BuildContext context) {
    final window = MediaQuery.of(context).size;
    final width = window.width * 0.4;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalInset),
            child: Material(
              child: InkWell(
                onTap: () => onTap(),
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      if (isSelected) SizedBox(width: 8),
                      if (isSelected) Text(label)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
