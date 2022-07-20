// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../timeslot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TimeslotModel _$TimeslotModelFromJson(Map<String, dynamic> json) {
  return _TimeslotModel.fromJson(json);
}

/// @nodoc
mixin _$TimeslotModel {
  String? get id => throw _privateConstructorUsedError;
  String? get bid => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  String? get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_time')
  String? get endTime => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;
  @JsonKey(fromJson: firestoreTimeStampToDateTime)
  DateTime? get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeslotModelCopyWith<TimeslotModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeslotModelCopyWith<$Res> {
  factory $TimeslotModelCopyWith(
          TimeslotModel value, $Res Function(TimeslotModel) then) =
      _$TimeslotModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? bid,
      @JsonKey(name: 'start_time') String? startTime,
      @JsonKey(name: 'end_time') String? endTime,
      int? capacity,
      @JsonKey(fromJson: firestoreTimeStampToDateTime) DateTime? created_at});
}

/// @nodoc
class _$TimeslotModelCopyWithImpl<$Res>
    implements $TimeslotModelCopyWith<$Res> {
  _$TimeslotModelCopyWithImpl(this._value, this._then);

  final TimeslotModel _value;
  // ignore: unused_field
  final $Res Function(TimeslotModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? bid = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? capacity = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      bid: bid == freezed
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      capacity: capacity == freezed
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      created_at: created_at == freezed
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_TimeslotModelCopyWith<$Res>
    implements $TimeslotModelCopyWith<$Res> {
  factory _$$_TimeslotModelCopyWith(
          _$_TimeslotModel value, $Res Function(_$_TimeslotModel) then) =
      __$$_TimeslotModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? bid,
      @JsonKey(name: 'start_time') String? startTime,
      @JsonKey(name: 'end_time') String? endTime,
      int? capacity,
      @JsonKey(fromJson: firestoreTimeStampToDateTime) DateTime? created_at});
}

/// @nodoc
class __$$_TimeslotModelCopyWithImpl<$Res>
    extends _$TimeslotModelCopyWithImpl<$Res>
    implements _$$_TimeslotModelCopyWith<$Res> {
  __$$_TimeslotModelCopyWithImpl(
      _$_TimeslotModel _value, $Res Function(_$_TimeslotModel) _then)
      : super(_value, (v) => _then(v as _$_TimeslotModel));

  @override
  _$_TimeslotModel get _value => super._value as _$_TimeslotModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? bid = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? capacity = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_$_TimeslotModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      bid: bid == freezed
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: startTime == freezed
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: endTime == freezed
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      capacity: capacity == freezed
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      created_at: created_at == freezed
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TimeslotModel extends _TimeslotModel with DiagnosticableTreeMixin {
  _$_TimeslotModel(
      {this.id,
      this.bid,
      @JsonKey(name: 'start_time') this.startTime,
      @JsonKey(name: 'end_time') this.endTime,
      this.capacity,
      @JsonKey(fromJson: firestoreTimeStampToDateTime) this.created_at})
      : super._();

  factory _$_TimeslotModel.fromJson(Map<String, dynamic> json) =>
      _$$_TimeslotModelFromJson(json);

  @override
  final String? id;
  @override
  final String? bid;
  @override
  @JsonKey(name: 'start_time')
  final String? startTime;
  @override
  @JsonKey(name: 'end_time')
  final String? endTime;
  @override
  final int? capacity;
  @override
  @JsonKey(fromJson: firestoreTimeStampToDateTime)
  final DateTime? created_at;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TimeslotModel(id: $id, bid: $bid, startTime: $startTime, endTime: $endTime, capacity: $capacity, created_at: $created_at)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TimeslotModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('bid', bid))
      ..add(DiagnosticsProperty('startTime', startTime))
      ..add(DiagnosticsProperty('endTime', endTime))
      ..add(DiagnosticsProperty('capacity', capacity))
      ..add(DiagnosticsProperty('created_at', created_at));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TimeslotModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.bid, bid) &&
            const DeepCollectionEquality().equals(other.startTime, startTime) &&
            const DeepCollectionEquality().equals(other.endTime, endTime) &&
            const DeepCollectionEquality().equals(other.capacity, capacity) &&
            const DeepCollectionEquality()
                .equals(other.created_at, created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(bid),
      const DeepCollectionEquality().hash(startTime),
      const DeepCollectionEquality().hash(endTime),
      const DeepCollectionEquality().hash(capacity),
      const DeepCollectionEquality().hash(created_at));

  @JsonKey(ignore: true)
  @override
  _$$_TimeslotModelCopyWith<_$_TimeslotModel> get copyWith =>
      __$$_TimeslotModelCopyWithImpl<_$_TimeslotModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TimeslotModelToJson(this);
  }
}

abstract class _TimeslotModel extends TimeslotModel {
  factory _TimeslotModel(
      {final String? id,
      final String? bid,
      @JsonKey(name: 'start_time')
          final String? startTime,
      @JsonKey(name: 'end_time')
          final String? endTime,
      final int? capacity,
      @JsonKey(fromJson: firestoreTimeStampToDateTime)
          final DateTime? created_at}) = _$_TimeslotModel;
  _TimeslotModel._() : super._();

  factory _TimeslotModel.fromJson(Map<String, dynamic> json) =
      _$_TimeslotModel.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get bid => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'start_time')
  String? get startTime => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'end_time')
  String? get endTime => throw _privateConstructorUsedError;
  @override
  int? get capacity => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: firestoreTimeStampToDateTime)
  DateTime? get created_at => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TimeslotModelCopyWith<_$_TimeslotModel> get copyWith =>
      throw _privateConstructorUsedError;
}
