import 'package:auto_route/auto_route.dart';
import 'package:budget/core/data/transactions_repository.dart';
import 'package:budget/features/transaction/ui/bloc/events.dart';
import 'package:budget/features/transaction/ui/bloc/transaction_bloc.dart';
import 'package:budget/features/transaction/ui/transaction_screen.dart';
import 'package:budget/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TransactionWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const TransactionWrapperScreen(
      {super.key,
      @pathParam required this.transactionId,
      @pathParam this.createAsIncome});
  final int? transactionId;
  final bool? createAsIncome;
  @override
  Widget build(BuildContext context) {
    return TransactionScreen(isNewTransaction: transactionId == null);
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<TransactionBloc>(
      create: (_) {
        final bloc =
            TransactionBloc(getIt.get<TransactionsRepository>(), transactionId);
        if (createAsIncome != null) {
          bloc.add(TransactionTypeInitialized(createAsIncome!));
        } else {
          bloc.add(TransactionFetched());
        }
        return bloc;
      },
      child: this,
    );
  }
}
