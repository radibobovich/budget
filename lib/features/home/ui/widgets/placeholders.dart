import 'package:budget/core/misc/extensions.dart';
import 'package:flutter/material.dart';

class NoTransactionsPlaceholder extends StatelessWidget {
  const NoTransactionsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.window.height * 0.15),
      child: Center(
          child: SizedBox(
        width: context.window.width * 0.75,
        child: Text(
          'Пока здесь пусто. Добавьте первую транзакцию, нажав кнопку ниже',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: context.colors.secondaryText),
        ),
      )),
    );
  }
}

class TransactionsNotFoundPlaceholder extends StatelessWidget {
  const TransactionsNotFoundPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.window.height * 0.15),
      child: Center(
          child: SizedBox(
        width: context.window.width * 0.75,
        child: Text(
          'Не найдено транзакций, удовлетворяющих выбранным фильтрам.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: context.colors.secondaryText),
        ),
      )),
    );
  }
}
