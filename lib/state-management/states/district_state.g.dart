// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DistrictState> _$districtStateSerializer =
    new _$DistrictStateSerializer();

class _$DistrictStateSerializer implements StructuredSerializer<DistrictState> {
  @override
  final Iterable<Type> types = const [DistrictState, _$DistrictState];
  @override
  final String wireName = 'DistrictState';

  @override
  Iterable<Object?> serialize(Serializers serializers, DistrictState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'listDistrict',
      serializers.serialize(object.listDistrict,
          specifiedType:
              const FullType(List, const [const FullType(DistrictModel)])),
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'currentDistrict',
      serializers.serialize(object.currentDistrict,
          specifiedType: const FullType(DistrictModel)),
    ];

    return result;
  }

  @override
  DistrictState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DistrictStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'listDistrict':
          result.listDistrict = serializers.deserialize(value,
                  specifiedType: const FullType(
                      List, const [const FullType(DistrictModel)]))
              as List<DistrictModel>;
          break;
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'currentDistrict':
          result.currentDistrict = serializers.deserialize(value,
              specifiedType: const FullType(DistrictModel)) as DistrictModel;
          break;
      }
    }

    return result.build();
  }
}

class _$DistrictState extends DistrictState {
  @override
  final List<DistrictModel> listDistrict;
  @override
  final bool isLoading;
  @override
  final DistrictModel currentDistrict;

  factory _$DistrictState([void Function(DistrictStateBuilder)? updates]) =>
      (new DistrictStateBuilder()..update(updates)).build();

  _$DistrictState._(
      {required this.listDistrict,
      required this.isLoading,
      required this.currentDistrict})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listDistrict, 'DistrictState', 'listDistrict');
    BuiltValueNullFieldError.checkNotNull(
        isLoading, 'DistrictState', 'isLoading');
    BuiltValueNullFieldError.checkNotNull(
        currentDistrict, 'DistrictState', 'currentDistrict');
  }

  @override
  DistrictState rebuild(void Function(DistrictStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DistrictStateBuilder toBuilder() => new DistrictStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DistrictState &&
        listDistrict == other.listDistrict &&
        isLoading == other.isLoading &&
        currentDistrict == other.currentDistrict;
  }

  int? __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc($jc(0, listDistrict.hashCode), isLoading.hashCode),
        currentDistrict.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DistrictState')
          ..add('listDistrict', listDistrict)
          ..add('isLoading', isLoading)
          ..add('currentDistrict', currentDistrict))
        .toString();
  }
}

class DistrictStateBuilder
    implements Builder<DistrictState, DistrictStateBuilder> {
  _$DistrictState? _$v;

  List<DistrictModel>? _listDistrict;
  List<DistrictModel>? get listDistrict => _$this._listDistrict;
  set listDistrict(List<DistrictModel>? listDistrict) =>
      _$this._listDistrict = listDistrict;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  DistrictModel? _currentDistrict;
  DistrictModel? get currentDistrict => _$this._currentDistrict;
  set currentDistrict(DistrictModel? currentDistrict) =>
      _$this._currentDistrict = currentDistrict;

  DistrictStateBuilder();

  DistrictStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _listDistrict = $v.listDistrict;
      _isLoading = $v.isLoading;
      _currentDistrict = $v.currentDistrict;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DistrictState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DistrictState;
  }

  @override
  void update(void Function(DistrictStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DistrictState build() {
    final _$result = _$v ??
        new _$DistrictState._(
            listDistrict: BuiltValueNullFieldError.checkNotNull(
                listDistrict, 'DistrictState', 'listDistrict'),
            isLoading: BuiltValueNullFieldError.checkNotNull(
                isLoading, 'DistrictState', 'isLoading'),
            currentDistrict: BuiltValueNullFieldError.checkNotNull(
                currentDistrict, 'DistrictState', 'currentDistrict'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
