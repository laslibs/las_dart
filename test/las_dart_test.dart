import 'dart:io';

import 'package:las_dart/las_dart.dart';

import 'package:test/test.dart';

void main() {
  const files = ['example1.las', '1046943371.las', 'A10.las', 'C1.las'];

  group('LasDart', () {
    group("-> Version: Returns version of las file for", () {
      void checkVersion(String input, expected) {
        test("$input -> $expected", () async {
          var myLas =
              new LasDart("${Directory.current.path}/test/sample/$input");
          var version = await myLas.version();
          expect(version, expected);
        }, timeout: Timeout.factor(1));
      }

      for (var filename in files) checkVersion(filename, 2);
    });

    group("-> Blob : The decoded string shouldn't be empty for", () {
      void check(String input) {
        test("$input ->", () async {
          var myLas =
              new LasDart("${Directory.current.path}/test/sample/$input");
          var blob = await myLas.blobString;
          expect((blob as String).length, greaterThan(0));
        }, timeout: Timeout.factor(1));
      }

      for (var filename in files) check(filename);
    });

    group("-> Stripped Data : The dataStripped is List<dynamic> for", () {
      void check(String input) {
        test("$input ->", () async {
          var myLas =
              new LasDart("${Directory.current.path}/test/sample/$input");
          var dataStripped = await myLas.dataStripped();
          expect(dataStripped is List<dynamic>, true);
        }, timeout: Timeout.factor(1));
      }

      for (var filename in files) check(filename);
    });

    group("-> Header : The header is an non-empty Array for", () {
      void check(String input) {
        test("$input -> ", () async {
          var myLas =
              new LasDart("${Directory.current.path}/test/sample/$input");
          var header = await myLas.header();
          expect(header.length, greaterThan(0));
        }, timeout: Timeout.factor(1));
      }

      ;

      for (var filename in files) check(filename);
    });

    group(
        "-> Header and Description : The headerAndDescr is an non-empty object for",
        () {
      void check(
        String input,
      ) {
        test("$input -> ", () async {
          var myLas =
              new LasDart("${Directory.current.path}/test/sample/$input");
          var headerAndDescr = await myLas.headerAndDescr();
          expect((headerAndDescr as Map).length, greaterThan(0));
        }, timeout: Timeout.factor(1));
      }

      for (var filename in files) check(filename);
    });

    group("-> Wrap variant : wrap state must be a boolean for", () {
      void check(String input) {
        test("$input ->", () async {
          var myLas =
              new LasDart("${Directory.current.path}/test/sample/$input");
          var wrap = await myLas.wrap();
          expect(wrap is bool, true);
        }, timeout: Timeout.factor(1));
      }

      for (var filename in files) check(filename);
    });

    group("-> 'Well Parameters : well parameters are present for", () {
      void check(
        String input,
      ) {
        test("$input -> ", () async {
          var myLas =
              new LasDart("${Directory.current.path}/test/sample/$input");
          var well = await myLas.wellParams();
          for (var item in well) {
            expect(item.toJson().length, greaterThan(0));
          }
        }, timeout: Timeout.factor(1));
      }

      for (var filename in files) check(filename);
    });

    group("-> 'Log Parameters : log parameters are present for ", () {
      void check(
        String input,
      ) {
        test("$input -> ", () async {
          var myLas =
              new LasDart("${Directory.current.path}/test/sample/$input");
          var param = await myLas.logParams();
          print(param);
          for (var item in param) {
            expect(item.toJson().length, greaterThan(0));
          }
        }, timeout: Timeout.factor(1));
      }

      check(files[1]);
    });

    group("-> 'Rows: %s has more than zero rows", () {
      void check(
        String input,
      ) {
        test("$input -> ", () async {
          var myLas =
              new LasDart("${Directory.current.path}/test/sample/$input");
          var rowCount = await myLas.rowCount();
          expect(rowCount, greaterThan(0));
        }, timeout: Timeout.factor(1));
      }

      for (var filename in files) check(filename);
    });
    group("-> 'Column : %s has more than zero columns", () {
      void check(
        String input,
      ) {
        test("$input -> ", () async {
          var myLas =
              new LasDart("${Directory.current.path}/test/sample/$input");
          var columnCount = await myLas.columnCount();
          expect(columnCount, greaterThan(0));
        }, timeout: Timeout.factor(1));
      }

      for (var filename in files) check(filename);
    });
  });
}
