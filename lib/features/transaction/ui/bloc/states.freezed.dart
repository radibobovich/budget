// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionDraft {
  String get title => throw _privateConstructorUsedError;
  bool get isIncome => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  int? get value => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  /// Create a copy of TransactionDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionDraftCopyWith<TransactionDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionDraftCopyWith<$Res> {
  factory $TransactionDraftCopyWith(
          TransactionDraft value, $Res Function(TransactionDraft) then) =
      _$TransactionDraftCopyWithImpl<$Res, TransactionDraft>;
  @useResult
  $Res call(
      {String title,
      bool isIncome,
      DateTime date,
      Category? category,
      int? value,
      int? id});
}

/// @nodoc
class _$TransactionDraftCopyWithImpl<$Res, $Val extends TransactionDraft>
    implements $TransactionDraftCopyWith<$Res> {
  _$TransactionDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? isIncome = null,
    Object? date = null,
    Object? category = freezed,
    Object? value = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isIncome: null == isIncome
          ? _value.isIncome
          : isIncome // ignore: cast_nullable_to_non_nullable
              as bool,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionDraftImplCopyWith<$Res>
    implements $TransactionDraftCopyWith<$Res> {
  factory _$$TransactionDraftImplCopyWith(_$TransactionDraftImpl value,
          $Res Function(_$TransactionDraftImpl) then) =
      __$$TransactionDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      bool isIncome,
      DateTime date,
      Category? category,
      int? value,
      int? id});
}

/// @nodoc
class __$$TransactionDraftImplCopyWithImpl<$Res>
    extends _$TransactionDraftCopyWithImpl<$Res, _$TransactionDraftImpl>
    implements _$$TransactionDraftImplCopyWith<$Res> {
  __$$TransactionDraftImplCopyWithImpl(_$TransactionDraftImpl _value,
      $Res Function(_$TransactionDraftImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? isIncome = null,
    Object? date = null,
    Object? category = freezed,
    Object? value = freezed,
    Object? id = freezed,
  }) {
    return _then(_$TransactionDraftImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isIncome: null == isIncome
          ? _value.isIncome
          : isIncome // ignore: cast_nullable_to_non_nullable
              as bool,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$TransactionDraftImpl implements _TransactionDraft {
  const _$TransactionDraftImpl(
      {required this.title,
      required this.isIncome,
      required this.date,
      this.category,
      this.value,
      this.id});

  @override
  final String title;
  @override
  final bool isIncome;
  @override
  final DateTime date;
  @override
  final Category? category;
  @override
  final int? value;
  @override
  final int? id;

  @override
  String toString() {
    return 'TransactionDraft(title: $title, isIncome: $isIncome, date: $date, category: $category, value: $value, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionDraftImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isIncome, isIncome) ||
                other.isIncome == isIncome) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, title, isIncome, date, category, value, id);

  /// Create a copy of TransactionDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionDraftImplCopyWith<_$TransactionDraftImpl> get copyWith =>
      __$$TransactionDraftImplCopyWithImpl<_$TransactionDraftImpl>(
          this, _$identity);
}

abstract class _TransactionDraft implements TransactionDraft {
  const factory _TransactionDraft(
      {required final String title,
      required final bool isIncome,
      required final DateTime date,
      final Category? category,
      final int? value,
      final int? id}) = _$TransactionDraftImpl;

  @override
  String get title;
  @override
  bool get isIncome;
  @override
  DateTime get date;
  @override
  Category? get category;
  @override
  int? get value;
  @override
  int? get id;

  /// Create a copy of TransactionDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionDraftImplCopyWith<_$TransactionDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
