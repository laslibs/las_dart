// GENERATED CODE - DO NOT MODIFY BY HAND

part of well_props;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WellProps> _$wellPropsSerializer = new _$WellPropsSerializer();

class _$WellPropsSerializer implements StructuredSerializer<WellProps> {
  @override
  final Iterable<Type> types = const [WellProps, _$WellProps];
  @override
  final String wireName = 'WellProps';

  @override
  Iterable<Object> serialize(Serializers serializers, WellProps object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.unit != null) {
      result
        ..add('unit')
        ..add(serializers.serialize(object.unit,
            specifiedType: const FullType(String)));
    }
    if (object.key != null) {
      result
        ..add('key')
        ..add(serializers.serialize(object.key,
            specifiedType: const FullType(String)));
    }
    if (object.value != null) {
      result
        ..add('value')
        ..add(serializers.serialize(object.value,
            specifiedType: const FullType(String)));
    }
    if (object.nullValue != null) {
      result
        ..add('nullValue')
        ..add(serializers.serialize(object.nullValue,
            specifiedType: const FullType(WellProps)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  WellProps deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WellPropsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'unit':
          result.unit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'key':
          result.key = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nullValue':
          result.nullValue.replace(serializers.deserialize(value,
              specifiedType: const FullType(WellProps)) as WellProps);
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$WellProps extends WellProps {
  @override
  final String unit;
  @override
  final String key;
  @override
  final String value;
  @override
  final WellProps nullValue;
  @override
  final String description;

  factory _$WellProps([void Function(WellPropsBuilder) updates]) =>
      (new WellPropsBuilder()..update(updates)).build();

  _$WellProps._(
      {this.unit, this.key, this.value, this.nullValue, this.description})
      : super._();

  @override
  WellProps rebuild(void Function(WellPropsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WellPropsBuilder toBuilder() => new WellPropsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WellProps &&
        unit == other.unit &&
        key == other.key &&
        value == other.value &&
        nullValue == other.nullValue &&
        description == other.description;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, unit.hashCode), key.hashCode), value.hashCode),
            nullValue.hashCode),
        description.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WellProps')
          ..add('unit', unit)
          ..add('key', key)
          ..add('value', value)
          ..add('nullValue', nullValue)
          ..add('description', description))
        .toString();
  }
}

class WellPropsBuilder implements Builder<WellProps, WellPropsBuilder> {
  _$WellProps _$v;

  String _unit;
  String get unit => _$this._unit;
  set unit(String unit) => _$this._unit = unit;

  String _key;
  String get key => _$this._key;
  set key(String key) => _$this._key = key;

  String _value;
  String get value => _$this._value;
  set value(String value) => _$this._value = value;

  WellPropsBuilder _nullValue;
  WellPropsBuilder get nullValue =>
      _$this._nullValue ??= new WellPropsBuilder();
  set nullValue(WellPropsBuilder nullValue) => _$this._nullValue = nullValue;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  WellPropsBuilder();

  WellPropsBuilder get _$this {
    if (_$v != null) {
      _unit = _$v.unit;
      _key = _$v.key;
      _value = _$v.value;
      _nullValue = _$v.nullValue?.toBuilder();
      _description = _$v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WellProps other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WellProps;
  }

  @override
  void update(void Function(WellPropsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WellProps build() {
    _$WellProps _$result;
    try {
      _$result = _$v ??
          new _$WellProps._(
              unit: unit,
              key: key,
              value: value,
              nullValue: _nullValue?.build(),
              description: description);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'nullValue';
        _nullValue?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WellProps', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
