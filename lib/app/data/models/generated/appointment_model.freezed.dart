// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../appointment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppointmentModel _$AppointmentModelFromJson(Map<String, dynamic> json) {
  return _AppointmentModel.fromJson(json);
}

/// @nodoc
mixin _$AppointmentModel {
  String? get id => throw _privateConstructorUsedError;
  String? get bid => throw _privateConstructorUsedError;
  String? get pid => throw _privateConstructorUsedError;
  @JsonKey(name: "timeslot_id")
  String? get timeslotId => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  @JsonKey(name: "is_visited")
  bool get isVisited => throw _privateConstructorUsedError;
  @JsonKey(fromJson: firestoreTimeStampToDateTime)
  DateTime? get visited_at => throw _privateConstructorUsedError;
  @JsonKey(fromJson: firestoreTimeStampToDateTime)
  DateTime? get created_at => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppointmentModelCopyWith<AppointmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppointmentModelCopyWith<$Res> {
  factory $AppointmentModelCopyWith(
          AppointmentModel value, $Res Function(AppointmentModel) then) =
      _$AppointmentModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? bid,
      String? pid,
      @JsonKey(name: "timeslot_id") String? timeslotId,
      DateTime? date,
      @JsonKey(name: "is_visited") bool isVisited,
      @JsonKey(fromJson: firestoreTimeStampToDateTime) DateTime? visited_at,
      @JsonKey(fromJson: firestoreTimeStampToDateTime) DateTime? created_at});
}

/// @nodoc
class _$AppointmentModelCopyWithImpl<$Res>
    implements $AppointmentModelCopyWith<$Res> {
  _$AppointmentModelCopyWithImpl(this._value, this._then);

  final AppointmentModel _value;
  // ignore: unused_field
  final $Res Function(AppointmentModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? bid = freezed,
    Object? pid = freezed,
    Object? timeslotId = freezed,
    Object? date = freezed,
    Object? isVisited = freezed,
    Object? visited_at = freezed,
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
      pid: pid == freezed
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as String?,
      timeslotId: timeslotId == freezed
          ? _value.timeslotId
          : timeslotId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isVisited: isVisited == freezed
          ? _value.isVisited
          : isVisited // ignore: cast_nullable_to_non_nullable
              as bool,
      visited_at: visited_at == freezed
          ? _value.visited_at
          : visited_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      created_at: created_at == freezed
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_AppointmentModelCopyWith<$Res>
    implements $AppointmentModelCopyWith<$Res> {
  factory _$$_AppointmentModelCopyWith(
          _$_AppointmentModel value, $Res Function(_$_AppointmentModel) then) =
      __$$_AppointmentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? bid,
      String? pid,
      @JsonKey(name: "timeslot_id") String? timeslotId,
      DateTime? date,
      @JsonKey(name: "is_visited") bool isVisited,
      @JsonKey(fromJson: firestoreTimeStampToDateTime) DateTime? visited_at,
      @JsonKey(fromJson: firestoreTimeStampToDateTime) DateTime? created_at});
}

/// @nodoc
class __$$_AppointmentModelCopyWithImpl<$Res>
    extends _$AppointmentModelCopyWithImpl<$Res>
    implements _$$_AppointmentModelCopyWith<$Res> {
  __$$_AppointmentModelCopyWithImpl(
      _$_AppointmentModel _value, $Res Function(_$_AppointmentModel) _then)
      : super(_value, (v) => _then(v as _$_AppointmentModel));

  @override
  _$_AppointmentModel get _value => super._value as _$_AppointmentModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? bid = freezed,
    Object? pid = freezed,
    Object? timeslotId = freezed,
    Object? date = freezed,
    Object? isVisited = freezed,
    Object? visited_at = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_$_AppointmentModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      bid: bid == freezed
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as String?,
      pid: pid == freezed
          ? _value.pid
          : pid // ignore: cast_nullable_to_non_nullable
              as String?,
      timeslotId: timeslotId == freezed
          ? _value.timeslotId
          : timeslotId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isVisited: isVisited == freezed
          ? _value.isVisited
          : isVisited // ignore: cast_nullable_to_non_nullable
              as bool,
      visited_at: visited_at == freezed
          ? _value.visited_at
          : visited_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      created_at: created_at == freezed
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppointmentModel extends _AppointmentModel
    with DiagnosticableTreeMixin {
  _$_AppointmentModel(
      {this.id,
      this.bid,
      this.pid,
      @JsonKey(name: "timeslot_id") this.timeslotId,
      this.date,
      @JsonKey(name: "is_visited") this.isVisited = false,
      @JsonKey(fromJson: firestoreTimeStampToDateTime) this.visited_at,
      @JsonKey(fromJson: firestoreTimeStampToDateTime) this.created_at})
      : super._();

  factory _$_AppointmentModel.fromJson(Map<String, dynamic> json) =>
      _$$_AppointmentModelFromJson(json);

  @override
  final String? id;
  @override
  final String? bid;
  @override
  final String? pid;
  @override
  @JsonKey(name: "timeslot_id")
  final String? timeslotId;
  @override
  final DateTime? date;
  @override
  @JsonKey(name: "is_visited")
  final bool isVisited;
  @override
  @JsonKey(fromJson: firestoreTimeStampToDateTime)
  final DateTime? visited_at;
  @override
  @JsonKey(fromJson: firestoreTimeStampToDateTime)
  final DateTime? created_at;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppointmentModel(id: $id, bid: $bid, pid: $pid, timeslotId: $timeslotId, date: $date, isVisited: $isVisited, visited_at: $visited_at, created_at: $created_at)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppointmentModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('bid', bid))
      ..add(DiagnosticsProperty('pid', pid))
      ..add(DiagnosticsProperty('timeslotId', timeslotId))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('isVisited', isVisited))
      ..add(DiagnosticsProperty('visited_at', visited_at))
      ..add(DiagnosticsProperty('created_at', created_at));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppointmentModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.bid, bid) &&
            const DeepCollectionEquality().equals(other.pid, pid) &&
            const DeepCollectionEquality()
                .equals(other.timeslotId, timeslotId) &&
            const DeepCollectionEquality().equals(other.date, date) &&
            const DeepCollectionEquality().equals(other.isVisited, isVisited) &&
            const DeepCollectionEquality()
                .equals(other.visited_at, visited_at) &&
            const DeepCollectionEquality()
                .equals(other.created_at, created_at));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(bid),
      const DeepCollectionEquality().hash(pid),
      const DeepCollectionEquality().hash(timeslotId),
      const DeepCollectionEquality().hash(date),
      const DeepCollectionEquality().hash(isVisited),
      const DeepCollectionEquality().hash(visited_at),
      const DeepCollectionEquality().hash(created_at));

  @JsonKey(ignore: true)
  @override
  _$$_AppointmentModelCopyWith<_$_AppointmentModel> get copyWith =>
      __$$_AppointmentModelCopyWithImpl<_$_AppointmentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppointmentModelToJson(this);
  }
}

abstract class _AppointmentModel extends AppointmentModel {
  factory _AppointmentModel(
      {final String? id,
      final String? bid,
      final String? pid,
      @JsonKey(name: "timeslot_id")
          final String? timeslotId,
      final DateTime? date,
      @JsonKey(name: "is_visited")
          final bool isVisited,
      @JsonKey(fromJson: firestoreTimeStampToDateTime)
          final DateTime? visited_at,
      @JsonKey(fromJson: firestoreTimeStampToDateTime)
          final DateTime? created_at}) = _$_AppointmentModel;
  _AppointmentModel._() : super._();

  factory _AppointmentModel.fromJson(Map<String, dynamic> json) =
      _$_AppointmentModel.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String? get bid => throw _privateConstructorUsedError;
  @override
  String? get pid => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "timeslot_id")
  String? get timeslotId => throw _privateConstructorUsedError;
  @override
  DateTime? get date => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "is_visited")
  bool get isVisited => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: firestoreTimeStampToDateTime)
  DateTime? get visited_at => throw _privateConstructorUsedError;
  @override
  @JsonKey(fromJson: firestoreTimeStampToDateTime)
  DateTime? get created_at => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AppointmentModelCopyWith<_$_AppointmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
