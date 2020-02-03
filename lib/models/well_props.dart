library well_props;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'well_props.g.dart';

abstract class WellProps implements Built<WellProps, WellPropsBuilder> {
  WellProps._();

  factory WellProps([updates(WellPropsBuilder b)]) = _$WellProps;

  @nullable
  @BuiltValueField(wireName: 'unit')
  String get unit;

  @nullable
  @BuiltValueField(wireName: 'key')
  String get key;

  @nullable
  @BuiltValueField(wireName: 'value')
  String get value;

  @nullable
  @BuiltValueField(wireName: 'nullValue')
  WellProps get nullValue;

  @nullable
  @BuiltValueField(wireName: 'description')
  String get description;
  String toJson() {
    return json.encode(serializers.serializeWith(WellProps.serializer, this));
  }

  static WellProps fromJson(String jsonString) {
    return serializers.deserializeWith(
        WellProps.serializer, json.decode(jsonString));
  }

  static Serializer<WellProps> get serializer => _$wellPropsSerializer;
}
