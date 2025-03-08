import 'package:auto_route/auto_route.dart';
import 'package:budget/core/routing/app_router.gr.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:flutter/material.dart';

class AddTransactionButton extends StatefulWidget {
  const AddTransactionButton(
      {super.key, required this.onToggle, required this.isOpen});
  final Function(bool isOpen) onToggle;
  final bool isOpen;
  @override
  State<AddTransactionButton> createState() => _AddTransactionButtonState();
}

class _AddTransactionButtonState extends State<AddTransactionButton>
    with SingleTickerProviderStateMixin {
  @override
  void didUpdateWidget(covariant AddTransactionButton oldWidget) {
    if (!widget.isOpen) colorController.reverse();
    super.didUpdateWidget(oldWidget);
  }

  final animationDuration = Durations.short3;
  late final colorController =
      AnimationController(vsync: this, duration: animationDuration);
  final backgroundColorTween = ColorTween(begin: null, end: Colors.white);
  final iconColorTween = ColorTween(begin: Colors.white, end: Colors.grey);

  void toggleMenu() {
    setState(() {
      colorController.toggle();
      widget.onToggle(!widget.isOpen);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isOpen = widget.isOpen;
    final buttonsSpacing = context.window.width * 0.2;
    return SizedBox(
      height: 200,
      child: Stack(children: [
        Positioned(
          bottom: 75,
          left: 0,
          right: 0,
          child: TransactionTypeSelector(
            isOpen: isOpen,
            animationDuration: animationDuration,
            buttonsSpacing: buttonsSpacing,
            closeMenu: () => toggleMenu(),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: AnimatedRotation(
              turns: isOpen ? 1 / 8 : 0,
              curve: Curves.easeOut,
              duration: animationDuration,
              child: AnimatedBuilder(
                  animation: colorController,
                  builder: (context, _) {
                    return FloatingActionButton(
                      shape: CircleBorder(),
                      backgroundColor:
                          backgroundColorTween.evaluate(colorController),
                      foregroundColor: iconColorTween.evaluate(colorController),
                      onPressed: () => toggleMenu(),
                      child: Icon(Icons.add, size: 30),
                    );
                  }),
            ),
          ),
        )
      ]),
    );
  }
}

class TransactionTypeSelector extends StatelessWidget {
  const TransactionTypeSelector({
    super.key,
    required this.isOpen,
    required this.animationDuration,
    required this.buttonsSpacing,
    required this.closeMenu,
  });

  final bool isOpen;
  final Duration animationDuration;
  final double buttonsSpacing;
  final VoidCallback closeMenu;
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      alignment: Alignment.bottomCenter,
      scale: isOpen ? 1 : 0,
      duration: animationDuration,
      curve: Curves.decelerate,
      child: AnimatedAlign(
        alignment: isOpen ? Alignment.topCenter : Alignment.bottomCenter,
        duration: animationDuration,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TransactionTypeButton(
              label: 'Добавить доход',
              gradient: context.colors.incomeGradient,
              icon: Icon(Icons.download, size: 30),
              onTap: () {
                closeMenu();
                context.router.push(TransactionWrapperRoute(
                    transactionId: null, createAsIncome: true));
              }),
          AnimatedSize(
              duration: animationDuration,
              child: SizedBox(width: isOpen ? buttonsSpacing : 0)),
          TransactionTypeButton(
              label: 'Добавить расход',
              gradient: context.colors.expenseGradient.withOpacity(0.9),
              icon: Icon(Icons.upload, size: 30),
              onTap: () {
                closeMenu();
                context.router.push(TransactionWrapperRoute(
                    transactionId: null, createAsIncome: false));
              })
        ]),
      ),
    );
  }
}

class TransactionTypeButton extends StatelessWidget {
  const TransactionTypeButton({
    super.key,
    required this.label,
    required this.gradient,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final LinearGradient gradient;
  final Icon icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
            heroTag: label,
            backgroundColor: Colors.black,
            shape: CircleBorder(),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, gradient: gradient),
                child: icon),
            onPressed: () => onTap()),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () => onTap(),
          child: SizedBox(
              width: 80,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height: 4),
      ],
    );
  }
}
