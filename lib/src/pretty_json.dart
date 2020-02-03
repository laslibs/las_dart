import 'dart:convert';

jsonPretty(Object obj) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(obj);
  return prettyprint;
}
