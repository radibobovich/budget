import 'dart:async';

import 'package:budget/core/data/transactions_repository.dart';
import 'package:budget/features/transaction/ui/bloc/events.dart';
import 'package:budget/features/transaction/ui/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionsRepository _transactionsRepo;
  int? _id;
  TransactionBloc(this._transactionsRepo, this._id)
      : super(TransactionLoading()) {
    on<TransactionTypeInitialized>(_initializeWithTransactionType);
    on<TransactionFetched>(_fetch);
    on<TransactionSaved>(_createOrModify);
    on<TransactionTypeToggled>(_toggleType);
    on<TransactionDeleted>(
      _delete,
      transformer: (events, mapper) {
        return events.take(1).asyncExpand(mapper);
      },
    );
    on<TransactionCategorySet>(_onCategorySet);
    on<TransactionDateSet>(_onDateSet);
    on<TransactionGotError>(_onGetError);
  }

  bool isBusy = false;

  void _initializeWithTransactionType(
      TransactionTypeInitialized event, Emitter emit) {
    emit(TransactionDraft(
        title: '', isIncome: event.createAsIncome, date: DateTime.now()));
  }

  Future<void> _fetch(event, Emitter emit) async {
    if (_id == null) return;
    try {
      final transaction =
          await _transactionsRepo.getTransactionWithCategory(_id!);
      emit(TransactionDraft.fromTransaction(transaction));
    } catch (e) {
      add(TransactionGotReadError(e, _id));
    }
  }

  Future<void> _createOrModify(TransactionSaved event, Emitter emit) async {
    if (state is! TransactionDraft) return;
    if (isBusy) return;
    isBusy = true;

    final currentDraft = state as TransactionDraft;

    try {
      if (_id != null) {
        await _transactionsRepo.updateTransaction(
          id: _id!,
          title: event.title,
          valueKopecks: event.valueKopecks,
          isIncome: currentDraft.isIncome,
          date: currentDraft.date,
          categoryIdSetter: () => currentDraft.category?.id,
        );
        return;
      }

      final transaction = await _transactionsRepo.addTransaction(
        title: event.title,
        valueKopecks: event.valueKopecks,
        isIncome: currentDraft.isIncome,
        date: currentDraft.date,
        categoryId: currentDraft.category?.id,
      );
      _id = transaction.id;
    } catch (e) {
      add(TransactionGotWriteError(e, _id));
      isBusy = false;
      return;
    }
    add(TransactionFetched());
    isBusy = false;
  }

  void _toggleType(event, Emitter emit) async {
    if (state is TransactionDraft) {
      final isIncomeCurrently = (state as TransactionDraft).isIncome;
      emit((state as TransactionDraft).copyWith(
        isIncome: !isIncomeCurrently,
        category: (state as TransactionDraft).category,
      ));
    }
  }

  void _onCategorySet(TransactionCategorySet event, Emitter emit) {
    if (state is! TransactionDraft) return;
    emit((state as TransactionDraft).copyWith(category: event.category));
  }

  void _onDateSet(TransactionDateSet event, Emitter emit) {
    if (state is! TransactionDraft) return;
    emit((state as TransactionDraft).copyWith(date: event.date));
  }

  Future<void> _delete(TransactionDeleted event, Emitter emit) async {
    isBusy = true;
    if (state is TransactionDraft) {
      final id = (state as TransactionDraft).id;
      if (id != null) {
        await _transactionsRepo.removeTransaction(id);
      }
      event.onDeleted();
    }
  }

  void _onGetError(TransactionGotError event, Emitter emit) async {
    emit(TransactionError(event.e, event.reason, event.reasonUI));
  }
}
