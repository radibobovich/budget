import 'package:auto_route/auto_route.dart';
import 'package:budget/core/routing/app_router.gr.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/navigation/widgets/add_transaction_button.dart';
import 'package:budget/features/navigation/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  bool isMenuOpen = false;

  void closeMenu() {
    setState(() => isMenuOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    const grayAlpha = 192;
    return AutoTabsScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        fit: StackFit.loose,
        children: [
          isMenuOpen
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    color: Colors.black.withAlpha(grayAlpha),
                    height: context.mediaQuery.size.height,
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () => closeMenu(),
                    ),
                  ))
              : SizedBox.shrink(),
          AddTransactionButton(
              isOpen: isMenuOpen,
              onToggle: (isOpen) {
                setState(() {
                  isMenuOpen = isOpen;
                });
              }),
        ],
      ),
      routes: [
        HomeWrapperRoute(),
        StatsWrapperRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return Opacity(
          opacity: isMenuOpen ? (255 - grayAlpha) / 255 : 1,
          child: SafeArea(
            child:
                CustomBottomNavigationBar(tabsRouter: tabsRouter, height: 50),
          ),
        );
      },
    );
  }
}
