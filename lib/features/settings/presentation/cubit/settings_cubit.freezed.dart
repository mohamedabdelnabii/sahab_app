// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 bool get isCelsius; String get windUnit; String get pressureUnit; String get language; bool get isNotificationsEnabled; bool get isDarkMode;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.isCelsius, isCelsius) || other.isCelsius == isCelsius)&&(identical(other.windUnit, windUnit) || other.windUnit == windUnit)&&(identical(other.pressureUnit, pressureUnit) || other.pressureUnit == pressureUnit)&&(identical(other.language, language) || other.language == language)&&(identical(other.isNotificationsEnabled, isNotificationsEnabled) || other.isNotificationsEnabled == isNotificationsEnabled)&&(identical(other.isDarkMode, isDarkMode) || other.isDarkMode == isDarkMode));
}


@override
int get hashCode => Object.hash(runtimeType,isCelsius,windUnit,pressureUnit,language,isNotificationsEnabled,isDarkMode);

@override
String toString() {
  return 'SettingsState(isCelsius: $isCelsius, windUnit: $windUnit, pressureUnit: $pressureUnit, language: $language, isNotificationsEnabled: $isNotificationsEnabled, isDarkMode: $isDarkMode)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 bool isCelsius, String windUnit, String pressureUnit, String language, bool isNotificationsEnabled, bool isDarkMode
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isCelsius = null,Object? windUnit = null,Object? pressureUnit = null,Object? language = null,Object? isNotificationsEnabled = null,Object? isDarkMode = null,}) {
  return _then(_self.copyWith(
isCelsius: null == isCelsius ? _self.isCelsius : isCelsius // ignore: cast_nullable_to_non_nullable
as bool,windUnit: null == windUnit ? _self.windUnit : windUnit // ignore: cast_nullable_to_non_nullable
as String,pressureUnit: null == pressureUnit ? _self.pressureUnit : pressureUnit // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,isNotificationsEnabled: null == isNotificationsEnabled ? _self.isNotificationsEnabled : isNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,isDarkMode: null == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isCelsius,  String windUnit,  String pressureUnit,  String language,  bool isNotificationsEnabled,  bool isDarkMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.isCelsius,_that.windUnit,_that.pressureUnit,_that.language,_that.isNotificationsEnabled,_that.isDarkMode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isCelsius,  String windUnit,  String pressureUnit,  String language,  bool isNotificationsEnabled,  bool isDarkMode)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.isCelsius,_that.windUnit,_that.pressureUnit,_that.language,_that.isNotificationsEnabled,_that.isDarkMode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isCelsius,  String windUnit,  String pressureUnit,  String language,  bool isNotificationsEnabled,  bool isDarkMode)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.isCelsius,_that.windUnit,_that.pressureUnit,_that.language,_that.isNotificationsEnabled,_that.isDarkMode);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState implements SettingsState {
  const _SettingsState({this.isCelsius = true, this.windUnit = 'km/h', this.pressureUnit = 'mbar', this.language = 'English', this.isNotificationsEnabled = true, this.isDarkMode = true});
  

@override@JsonKey() final  bool isCelsius;
@override@JsonKey() final  String windUnit;
@override@JsonKey() final  String pressureUnit;
@override@JsonKey() final  String language;
@override@JsonKey() final  bool isNotificationsEnabled;
@override@JsonKey() final  bool isDarkMode;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.isCelsius, isCelsius) || other.isCelsius == isCelsius)&&(identical(other.windUnit, windUnit) || other.windUnit == windUnit)&&(identical(other.pressureUnit, pressureUnit) || other.pressureUnit == pressureUnit)&&(identical(other.language, language) || other.language == language)&&(identical(other.isNotificationsEnabled, isNotificationsEnabled) || other.isNotificationsEnabled == isNotificationsEnabled)&&(identical(other.isDarkMode, isDarkMode) || other.isDarkMode == isDarkMode));
}


@override
int get hashCode => Object.hash(runtimeType,isCelsius,windUnit,pressureUnit,language,isNotificationsEnabled,isDarkMode);

@override
String toString() {
  return 'SettingsState(isCelsius: $isCelsius, windUnit: $windUnit, pressureUnit: $pressureUnit, language: $language, isNotificationsEnabled: $isNotificationsEnabled, isDarkMode: $isDarkMode)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isCelsius, String windUnit, String pressureUnit, String language, bool isNotificationsEnabled, bool isDarkMode
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isCelsius = null,Object? windUnit = null,Object? pressureUnit = null,Object? language = null,Object? isNotificationsEnabled = null,Object? isDarkMode = null,}) {
  return _then(_SettingsState(
isCelsius: null == isCelsius ? _self.isCelsius : isCelsius // ignore: cast_nullable_to_non_nullable
as bool,windUnit: null == windUnit ? _self.windUnit : windUnit // ignore: cast_nullable_to_non_nullable
as String,pressureUnit: null == pressureUnit ? _self.pressureUnit : pressureUnit // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,isNotificationsEnabled: null == isNotificationsEnabled ? _self.isNotificationsEnabled : isNotificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,isDarkMode: null == isDarkMode ? _self.isDarkMode : isDarkMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
