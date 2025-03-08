import 'package:auto_route/auto_route.dart';
import 'package:budget/core/data/categories_repository.dart';
import 'package:budget/core/data/db/database.dart';
import 'package:budget/core/widgets/custom_cupertino_button.dart';
import 'package:budget/core/misc/extensions.dart';
import 'package:budget/features/category/ui/bloc/category_selector_bloc.dart';
import 'package:budget/features/category/ui/bloc/events.dart';
import 'package:budget/features/category/ui/category_selector_bottom_sheet.dart';
import 'package:budget/features/transaction/ui/bloc/events.dart';
import 'package:budget/features/transaction/ui/bloc/value_controller.dart';
import 'package:budget/features/category/ui/category_button.dart';
import 'package:budget/features/transaction/ui/widgets/app_bar.dart';
import 'package:budget/features/transaction/ui/bloc/states.dart';
import 'package:budget/features/transaction/ui/bloc/transaction_bloc.dart';
import 'package:budget/features/transaction/ui/widgets/date_picker.dart';
import 'package:budget/features/transaction/ui/widgets/value_bottom_sheet.dart';
import 'package:budget/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key, required this.isNewTransaction});
  final bool isNewTransaction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TransactionAppBar(),
        body: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is TransactionError) {
              return Center(child: Text(state.reason));
            }
            if (state is TransactionDraft) {
              return TransactionFormScreen(
                  state: state, isNewTransaction: isNewTransaction);
            }
            throw UnimplementedError('Unimplemented state');
          },
        ));
  }
}

class TransactionFormScreen extends StatefulWidget {
  const TransactionFormScreen(
      {super.key, required this.state, required this.isNewTransaction});
  final TransactionDraft state;
  final bool isNewTransaction;
  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  late final TextEditingController titleController;
  late final ValueController valueController;
  final titleFocusNode = FocusNode();

  bool didShowValueSheet = false;
  bool didShowCategorySheet = false;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: state.title);
    valueController = ValueController(state.value);
    didShowValueSheet = !widget.isNewTransaction;
    didShowCategorySheet = !widget.isNewTransaction;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!didShowValueSheet) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final completed = _showValueSheet();
        didShowValueSheet = true;
        completed.then((_) {
          if (didShowCategorySheet) return;
          if (context.mounted) {
            // ignore: use_build_context_synchronously
            _showCategorySheet(context, state.category);
            didShowCategorySheet = true;
          }
        });
      });
    }
  }

  Future<void> _showValueSheet() {
    final completed = showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return BlocProvider.value(
            value: context.read<TransactionBloc>(),
            child: ValueBottomSheet(valueController: valueController),
          );
        });
    return completed;
  }

  @override
  void dispose() {
    valueController.dispose();
    super.dispose();
  }

  TransactionDraft get state => widget.state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            focusNode: titleFocusNode,
            controller: titleController,
            decoration: _getInputDecoration('Название'),
            style: TextStyle(fontSize: 28),
            cursorColor: context.colors.cursorColor,
            autocorrect: false,
            textCapitalization: TextCapitalization.sentences,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLength: 120,
            onTapOutside: (_) => titleFocusNode.unfocus(),
          ),
          SizedBox(height: 16),
          CategoryButtonBuilder(
              category: widget.state.category,
              showModalSheet: () =>
                  _showCategorySheet(context, state.category)),
          SizedBox(height: 16),
          DatePicker(date: state.date),
          SizedBox(height: 8),
          SizedBox(height: context.window.height * 0.1),
          ValueWidget(
            valueController: valueController,
            onTap: () => _showValueSheet(),
          ),
          Spacer(),
          SafeArea(child: Center(child: CustomCupertinoButton(
            onTap: () async {
              final value = await valueController.valueKopecks.first;
              if (context.mounted) {
                if (_maybeShowZeroSumWarningSnackbar(context, value)) {
                  return;
                }
                final bloc = context.read<TransactionBloc>();
                bloc.add(TransactionSaved(
                    title: titleController.text, valueKopecks: value));
                context.router.pop();
              }
            },
          ))),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  bool _maybeShowZeroSumWarningSnackbar(BuildContext context, int value) {
    if (value == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: context.theme.canvasColor,
          duration: Duration(seconds: 1),
          content: Text(
            'Укажите сумму больше 0',
            style: TextStyle(
                color: context.colors.contrast,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )));
      return true;
    }
    return false;
  }

  void _showCategorySheet(
      BuildContext context, Category? maybeInitialCategory) {
    final selectedEvent = showModalBottomSheet<CategorySelected?>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<TransactionBloc>()),
              BlocProvider<CategorySelectorBloc>(
                create: (context) {
                  return CategorySelectorBloc(getIt.get<CategoriesRepository>())
                    ..add(SubscribedToCategories(maybeInitialCategory));
                },
              ),
            ],
            child: CategorySelectorBottomSheet(),
          );
        });

    selectedEvent.then((event) {
      if (!context.mounted) return;
      // user dismissed the bottom sheet
      if (event == null) return;
      context
          .read<TransactionBloc>()
          .add(TransactionCategorySet(event.selected));
    });
  }

  InputDecoration _getInputDecoration(String? hintText) {
    final border = UnderlineInputBorder(
        borderSide: BorderSide(color: context.colors.border, width: 2));
    return InputDecoration(
      hintText: hintText,
      counterText: '',
      hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      border: border,
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border,
      focusedErrorBorder: border,
    );
  }
}
