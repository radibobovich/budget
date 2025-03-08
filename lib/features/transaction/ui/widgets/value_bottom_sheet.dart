import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:budget/core/widgets/bottom_actions.dart';
import 'package:budget/core/widgets/close_button.dart';
import 'package:budget/core/widgets/confirm_button.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/transaction/ui/bloc/states.dart';
import 'package:budget/features/transaction/ui/bloc/transaction_bloc.dart';
import 'package:budget/features/transaction/ui/bloc/value_controller.dart';
import 'package:budget/features/transaction/ui/widgets/value_numpad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValueBottomSheet extends StatelessWidget {
  const ValueBottomSheet({super.key, required this.valueController});
  final ValueController valueController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24),
          Text('Сумма',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              )),
          ValueWidget(valueController: valueController),
          SizedBox(height: 8),
          Center(child: ValueNumpad(controller: valueController)),
          SizedBox(height: 32),
          BottomActions(
            closeButton: CloseBackButton.forBottomActions(
                onTap: () => context.router.pop()),
            actionButton: LongButton.confirm(
                gradient: context.colors.incomeGradient,
                onTap: () => context.router.pop()),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

class ValueWidget extends StatelessWidget {
  const ValueWidget({super.key, required this.valueController, this.onTap});
  final ValueController valueController;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading || state is TransactionError) {
          return const SizedBox.shrink();
        }
        if (state is TransactionDraft) {
          return Center(
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              child: SizedBox(
                width: context.window.width * 0.7,
                height: 80,
                child: Center(
                  child: ValueBuilder(
                      controller: valueController,
                      builder: (context, value) {
                        return AutoSizeText(value,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            minFontSize: 9,
                            maxFontSize: 36,
                            style: TextStyle(
                                fontSize: 36, fontWeight: FontWeight.w800));
                      }),
                ),
              ),
            ),
          );
        }
        throw UnimplementedError();
      },
    );
  }
}

class ValueBuilder extends StatelessWidget {
  const ValueBuilder(
      {super.key, required this.controller, required this.builder});
  final ValueController controller;
  final Widget Function(BuildContext context, String value) builder;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.valueFormatted,
        builder: (context, snapshot) {
          final connection = snapshot.connectionState;
          if (connection == ConnectionState.active) {
            return builder(context, snapshot.data!);
          }
          return builder(context, '0');
        });
  }
}
