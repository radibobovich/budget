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
mixin _$CategoriesLoaded {
  List<Category> get categories => throw _privateConstructorUsedError;
  Category? get selected => throw _privateConstructorUsedError;
  bool get didCreateNew => throw _privateConstructorUsedError;

  /// Create a copy of CategoriesLoaded
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoriesLoadedCopyWith<CategoriesLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoriesLoadedCopyWith<$Res> {
  factory $CategoriesLoadedCopyWith(
          CategoriesLoaded value, $Res Function(CategoriesLoaded) then) =
      _$CategoriesLoadedCopyWithImpl<$Res, CategoriesLoaded>;
  @useResult
  $Res call({List<Category> categories, Category? selected, bool didCreateNew});
}

/// @nodoc
class _$CategoriesLoadedCopyWithImpl<$Res, $Val extends CategoriesLoaded>
    implements $CategoriesLoadedCopyWith<$Res> {
  _$CategoriesLoadedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoriesLoaded
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? selected = freezed,
    Object? didCreateNew = null,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      selected: freezed == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as Category?,
      didCreateNew: null == didCreateNew
          ? _value.didCreateNew
          : didCreateNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoriesLoadedImplCopyWith<$Res>
    implements $CategoriesLoadedCopyWith<$Res> {
  factory _$$CategoriesLoadedImplCopyWith(_$CategoriesLoadedImpl value,
          $Res Function(_$CategoriesLoadedImpl) then) =
      __$$CategoriesLoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Category> categories, Category? selected, bool didCreateNew});
}

/// @nodoc
class __$$CategoriesLoadedImplCopyWithImpl<$Res>
    extends _$CategoriesLoadedCopyWithImpl<$Res, _$CategoriesLoadedImpl>
    implements _$$CategoriesLoadedImplCopyWith<$Res> {
  __$$CategoriesLoadedImplCopyWithImpl(_$CategoriesLoadedImpl _value,
      $Res Function(_$CategoriesLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategoriesLoaded
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? selected = freezed,
    Object? didCreateNew = null,
  }) {
    return _then(_$CategoriesLoadedImpl(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      selected: freezed == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as Category?,
      didCreateNew: null == didCreateNew
          ? _value.didCreateNew
          : didCreateNew // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CategoriesLoadedImpl implements _CategoriesLoaded {
  const _$CategoriesLoadedImpl(
      {required final List<Category> categories,
      this.selected,
      this.didCreateNew = false})
      : _categories = categories;

  final List<Category> _categories;
  @override
  List<Category> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final Category? selected;
  @override
  @JsonKey()
  final bool didCreateNew;

  @override
  String toString() {
    return 'CategoriesLoaded(categories: $categories, selected: $selected, didCreateNew: $didCreateNew)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.didCreateNew, didCreateNew) ||
                other.didCreateNew == didCreateNew));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_categories), selected, didCreateNew);

  /// Create a copy of CategoriesLoaded
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesLoadedImplCopyWith<_$CategoriesLoadedImpl> get copyWith =>
      __$$CategoriesLoadedImplCopyWithImpl<_$CategoriesLoadedImpl>(
          this, _$identity);
}

abstract class _CategoriesLoaded implements CategoriesLoaded {
  const factory _CategoriesLoaded(
      {required final List<Category> categories,
      final Category? selected,
      final bool didCreateNew}) = _$CategoriesLoadedImpl;

  @override
  List<Category> get categories;
  @override
  Category? get selected;
  @override
  bool get didCreateNew;

  /// Create a copy of CategoriesLoaded
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoriesLoadedImplCopyWith<_$CategoriesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
