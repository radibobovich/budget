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
mixin _$HomeLoaded {
  List<TransactionWithCategory> get transactionsWithCategory =>
      throw _privateConstructorUsedError;
  List<Category> get categories => throw _privateConstructorUsedError;
  Set<int> get categoriesIdFilter => throw _privateConstructorUsedError;
  DateTime? get startDateFilter => throw _privateConstructorUsedError;
  DateTime? get endDateFilter => throw _privateConstructorUsedError;

  /// Create a copy of HomeLoaded
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeLoadedCopyWith<HomeLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeLoadedCopyWith<$Res> {
  factory $HomeLoadedCopyWith(
          HomeLoaded value, $Res Function(HomeLoaded) then) =
      _$HomeLoadedCopyWithImpl<$Res, HomeLoaded>;
  @useResult
  $Res call(
      {List<TransactionWithCategory> transactionsWithCategory,
      List<Category> categories,
      Set<int> categoriesIdFilter,
      DateTime? startDateFilter,
      DateTime? endDateFilter});
}

/// @nodoc
class _$HomeLoadedCopyWithImpl<$Res, $Val extends HomeLoaded>
    implements $HomeLoadedCopyWith<$Res> {
  _$HomeLoadedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeLoaded
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionsWithCategory = null,
    Object? categories = null,
    Object? categoriesIdFilter = null,
    Object? startDateFilter = freezed,
    Object? endDateFilter = freezed,
  }) {
    return _then(_value.copyWith(
      transactionsWithCategory: null == transactionsWithCategory
          ? _value.transactionsWithCategory
          : transactionsWithCategory // ignore: cast_nullable_to_non_nullable
              as List<TransactionWithCategory>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      categoriesIdFilter: null == categoriesIdFilter
          ? _value.categoriesIdFilter
          : categoriesIdFilter // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      startDateFilter: freezed == startDateFilter
          ? _value.startDateFilter
          : startDateFilter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDateFilter: freezed == endDateFilter
          ? _value.endDateFilter
          : endDateFilter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeLoadedImplCopyWith<$Res>
    implements $HomeLoadedCopyWith<$Res> {
  factory _$$HomeLoadedImplCopyWith(
          _$HomeLoadedImpl value, $Res Function(_$HomeLoadedImpl) then) =
      __$$HomeLoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TransactionWithCategory> transactionsWithCategory,
      List<Category> categories,
      Set<int> categoriesIdFilter,
      DateTime? startDateFilter,
      DateTime? endDateFilter});
}

/// @nodoc
class __$$HomeLoadedImplCopyWithImpl<$Res>
    extends _$HomeLoadedCopyWithImpl<$Res, _$HomeLoadedImpl>
    implements _$$HomeLoadedImplCopyWith<$Res> {
  __$$HomeLoadedImplCopyWithImpl(
      _$HomeLoadedImpl _value, $Res Function(_$HomeLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeLoaded
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionsWithCategory = null,
    Object? categories = null,
    Object? categoriesIdFilter = null,
    Object? startDateFilter = freezed,
    Object? endDateFilter = freezed,
  }) {
    return _then(_$HomeLoadedImpl(
      transactionsWithCategory: null == transactionsWithCategory
          ? _value._transactionsWithCategory
          : transactionsWithCategory // ignore: cast_nullable_to_non_nullable
              as List<TransactionWithCategory>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      categoriesIdFilter: null == categoriesIdFilter
          ? _value._categoriesIdFilter
          : categoriesIdFilter // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      startDateFilter: freezed == startDateFilter
          ? _value.startDateFilter
          : startDateFilter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDateFilter: freezed == endDateFilter
          ? _value.endDateFilter
          : endDateFilter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$HomeLoadedImpl extends _HomeLoaded with DiagnosticableTreeMixin {
  _$HomeLoadedImpl(
      {required final List<TransactionWithCategory> transactionsWithCategory,
      required final List<Category> categories,
      final Set<int> categoriesIdFilter = const {},
      this.startDateFilter = null,
      this.endDateFilter = null})
      : _transactionsWithCategory = transactionsWithCategory,
        _categories = categories,
        _categoriesIdFilter = categoriesIdFilter,
        super._();

  final List<TransactionWithCategory> _transactionsWithCategory;
  @override
  List<TransactionWithCategory> get transactionsWithCategory {
    if (_transactionsWithCategory is EqualUnmodifiableListView)
      return _transactionsWithCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactionsWithCategory);
  }

  final List<Category> _categories;
  @override
  List<Category> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final Set<int> _categoriesIdFilter;
  @override
  @JsonKey()
  Set<int> get categoriesIdFilter {
    if (_categoriesIdFilter is EqualUnmodifiableSetView)
      return _categoriesIdFilter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_categoriesIdFilter);
  }

  @override
  @JsonKey()
  final DateTime? startDateFilter;
  @override
  @JsonKey()
  final DateTime? endDateFilter;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomeLoaded(transactionsWithCategory: $transactionsWithCategory, categories: $categories, categoriesIdFilter: $categoriesIdFilter, startDateFilter: $startDateFilter, endDateFilter: $endDateFilter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomeLoaded'))
      ..add(DiagnosticsProperty(
          'transactionsWithCategory', transactionsWithCategory))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('categoriesIdFilter', categoriesIdFilter))
      ..add(DiagnosticsProperty('startDateFilter', startDateFilter))
      ..add(DiagnosticsProperty('endDateFilter', endDateFilter));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeLoadedImpl &&
            const DeepCollectionEquality().equals(
                other._transactionsWithCategory, _transactionsWithCategory) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._categoriesIdFilter, _categoriesIdFilter) &&
            (identical(other.startDateFilter, startDateFilter) ||
                other.startDateFilter == startDateFilter) &&
            (identical(other.endDateFilter, endDateFilter) ||
                other.endDateFilter == endDateFilter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_transactionsWithCategory),
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_categoriesIdFilter),
      startDateFilter,
      endDateFilter);

  /// Create a copy of HomeLoaded
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeLoadedImplCopyWith<_$HomeLoadedImpl> get copyWith =>
      __$$HomeLoadedImplCopyWithImpl<_$HomeLoadedImpl>(this, _$identity);
}

abstract class _HomeLoaded extends HomeLoaded {
  factory _HomeLoaded(
      {required final List<TransactionWithCategory> transactionsWithCategory,
      required final List<Category> categories,
      final Set<int> categoriesIdFilter,
      final DateTime? startDateFilter,
      final DateTime? endDateFilter}) = _$HomeLoadedImpl;
  _HomeLoaded._() : super._();

  @override
  List<TransactionWithCategory> get transactionsWithCategory;
  @override
  List<Category> get categories;
  @override
  Set<int> get categoriesIdFilter;
  @override
  DateTime? get startDateFilter;
  @override
  DateTime? get endDateFilter;

  /// Create a copy of HomeLoaded
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeLoadedImplCopyWith<_$HomeLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
