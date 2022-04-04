// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_form.state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DistrictFormState> _$districtFormStateSerializer =
    new _$DistrictFormStateSerializer();

class _$DistrictFormStateSerializer
    implements StructuredSerializer<DistrictFormState> {
  @override
  final Iterable<Type> types = const [DistrictFormState, _$DistrictFormState];
  @override
  final String wireName = 'DistrictFormState';

  @override
  Iterable<Object?> serialize(Serializers serializers, DistrictFormState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'address',
      serializers.serialize(object.address,
          specifiedType: const FullType(String)),
      'districtName',
      serializers.serialize(object.districtName,
          specifiedType: const FullType(String)),
      'districtUrl',
      serializers.serialize(object.districtUrl,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.districtNameError;
    if (value != null) {
      result
        ..add('districtNameError')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.districtUrlError;
    if (value != null) {
      result
        ..add('districtUrlError')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  DistrictFormState deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DistrictFormStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'districtName':
          result.districtName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'districtUrl':
          result.districtUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'districtNameError':
          result.districtNameError = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'districtUrlError':
          result.districtUrlError = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$DistrictFormState extends DistrictFormState {
  @override
  final String address;
  @override
  final String districtName;
  @override
  final String districtUrl;
  @override
  final String? districtNameError;
  @override
  final String? districtUrlError;

  factory _$DistrictFormState(
          [void Function(DistrictFormStateBuilder)? updates]) =>
      (new DistrictFormStateBuilder()..update(updates)).build();

  _$DistrictFormState._(
      {required this.address,
      required this.districtName,
      required this.districtUrl,
      this.districtNameError,
      this.districtUrlError})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        address, 'DistrictFormState', 'address');
    BuiltValueNullFieldError.checkNotNull(
        districtName, 'DistrictFormState', 'districtName');
    BuiltValueNullFieldError.checkNotNull(
        districtUrl, 'DistrictFormState', 'districtUrl');
  }

  @override
  DistrictFormState rebuild(void Function(DistrictFormStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DistrictFormStateBuilder toBuilder() =>
      new DistrictFormStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DistrictFormState &&
        address == other.address &&
        districtName == other.districtName &&
        districtUrl == other.districtUrl &&
        districtNameError == other.districtNameError &&
        districtUrlError == other.districtUrlError;
  }

  int? __hashCode;
  @override
  int get hashCode {
    return __hashCode ??= $jf($jc(
        $jc(
            $jc($jc($jc(0, address.hashCode), districtName.hashCode),
                districtUrl.hashCode),
            districtNameError.hashCode),
        districtUrlError.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DistrictFormState')
          ..add('address', address)
          ..add('districtName', districtName)
          ..add('districtUrl', districtUrl)
          ..add('districtNameError', districtNameError)
          ..add('districtUrlError', districtUrlError))
        .toString();
  }
}

class DistrictFormStateBuilder
    implements Builder<DistrictFormState, DistrictFormStateBuilder> {
  _$DistrictFormState? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _districtName;
  String? get districtName => _$this._districtName;
  set districtName(String? districtName) => _$this._districtName = districtName;

  String? _districtUrl;
  String? get districtUrl => _$this._districtUrl;
  set districtUrl(String? districtUrl) => _$this._districtUrl = districtUrl;

  String? _districtNameError;
  String? get districtNameError => _$this._districtNameError;
  set districtNameError(String? districtNameError) =>
      _$this._districtNameError = districtNameError;

  String? _districtUrlError;
  String? get districtUrlError => _$this._districtUrlError;
  set districtUrlError(String? districtUrlError) =>
      _$this._districtUrlError = districtUrlError;

  DistrictFormStateBuilder();

  DistrictFormStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _districtName = $v.districtName;
      _districtUrl = $v.districtUrl;
      _districtNameError = $v.districtNameError;
      _districtUrlError = $v.districtUrlError;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DistrictFormState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DistrictFormState;
  }

  @override
  void update(void Function(DistrictFormStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DistrictFormState build() {
    final _$result = _$v ??
        new _$DistrictFormState._(
            address: BuiltValueNullFieldError.checkNotNull(
                address, 'DistrictFormState', 'address'),
            districtName: BuiltValueNullFieldError.checkNotNull(
                districtName, 'DistrictFormState', 'districtName'),
            districtUrl: BuiltValueNullFieldError.checkNotNull(
                districtUrl, 'DistrictFormState', 'districtUrl'),
            districtNameError: districtNameError,
            districtUrlError: districtUrlError);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
