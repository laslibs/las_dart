import 'dart:convert';
import 'dart:io';

import 'package:las_dart/models/well_props.dart';
import 'package:meta/meta.dart';

import 'error.dart';

import 'pretty_json.dart';

class LasDart {
  static chunk<T>(Iterable<dynamic> arr, num size) {
    List overall = [];
    List newOverall = [];
    var index = 0;
    while (index < arr.length) {
      overall.add(arr.toList().sublist(index, index + size));
      index += size;
    }

    //Removing decimal points for integers.
    overall.forEach((f) {
      var tempList = [];
      f.forEach((m) => tempList.add(m.remainder(1) == 0.0 ? m.toInt() : m));
      newOverall.add(tempList);
    });

    return newOverall;
  }

  static String removeComment(String str) {
    return str
        .trim()
        .split('\n')
        .map((val) => val.trimLeft())
        .where((f) => (f[0] != '#'))
        .join('\n');
  }

  static convertToValue(var s) {
    return double.parse(s) != null || RegExp(r'^0|0$').hasMatch(s)
        ? double.parse(s)
        : s;
  }

  String path;
  Future blobString;

  /// Creates an instance of Las.
  /// @param {string} path - Absolute path to las file
  /// @memberof Las

  LasDart(this.path) {
    this.blobString = this.initialize();
  }

  /// Returns a column in a las file
  /// @param {string} column - name of column
  /// @returns {(Future<List<dynamic>>)}
  /// @memberof Las

  column(String column) async {
    var hds = await this.header();
    var sB = await this.data();
    var index =
        hds.indexWhere((item) => item.toLowerCase() == column.toLowerCase());
    if (index < 0) {
      throw new ColumnError(column);
    }
    return sB.map((c) => c[index]).toList();
  }

  /// Returns a column in a las file stripped off null values
  /// @param {string} column - name of column
  /// @returns {(Future<List<dynamic>>)}
  /// @memberof Las

  Future columnStripped(String column) async {
    var hds = await this.header() as List;

    var sB = await this.dataStripped();

    var index =
        hds.indexWhere((item) => item.toLowerCase() == column.toLowerCase());

    if (index >= 0) {
      return sB.map((c) => c[index]).toList();
    } else {
      throw new ColumnError(column);
    }
  }

  /// Returns a csv File object in browser | writes csv file to current working driectory in Node
  /// @param {string} filename
  /// @returns {(Future<File>)}
  /// @memberof Las

  Future<File> toCsv({@required String filename}) async {
    try {
      var headers = await this.header();
      var data = await this.data();
      var rHd = headers.join(',') + '\n';
      var rData = data.map((d) => d.join(',')).join('\n');

      var file = new File("${filename}.csv").writeAsString(rHd + rData);
      if (await ((await file).exists())) {
        print("${filename}.csv has been saved to current working directory");
      }
      return file;
    } catch (error) {
      throw new CsvError();
    }
  }

  /// Returns a csv File object in browser and writes csv file to current working driectory in Node of data stripped of null values
  /// @param {string} filename
  /// @returns {(Future<File>)}
  /// @memberof Las

  Future<File> toCsvStripped({@required String filename}) async {
    try {
      var headers = await this.header();
      var data = await this.dataStripped();
      var rHd = headers.join(',') + '\n';
      var rData = data.map((d) => d.join(',')).join('\n');

      var file = new File("${filename}.csv").writeAsString(rHd + rData);
      if (await ((await file).exists())) {
        print("${filename}.csv has been saved to current working directory");
      }
      return file;
    } catch (error) {
      throw new CsvError();
    }
  }

  /// Returns the number of rows in a .las file
  /// @returns number
  /// @memberof Las

  Future<num> rowCount() async {
    var l = await this.data();
    return l.length;
  }

  /// Returns the number of columns in a .las file
  /// @returns number
  /// @memberof Las

  Future<num> columnCount() async {
    var l = await this.header();
    return l.length;
  }

  /// Returns a two-dimensional array of data in the log
  /// @returns {(Future<List<List<dynamic>>>)}
  /// @memberof Las

  data() async {
    try {
      var s = await this.blobString;
      var hds = await this.header();
      var totalheadersLength = hds.length;

      var sB = (s as String)
          .split(RegExp(r"~A(?:\w*\s*)*\n"))[1]
          .trim()
          .split(RegExp(r"\s+"))
          .map((m) {
        return LasDart.convertToValue(m.trim());
      });

      if (sB.length < 0) {
        throw new LasError('No data/~A section in the file');
      }
      return LasDart.chunk(sB, totalheadersLength);
    } catch (e) {
      print(e.toString());
    }
  }

  /// Returns a two-dimensional array of data in the log with all rows containing null values stripped off
  /// @returns {(Future<List<List<dynamic>>>)}
  /// @memberof Las

  dataStripped() async {
    var s = await this.blobString;
    var hds = await this.header();
    var well = await this.property('well');
    var nullValue = well?.nullValue;

    var totalheadersLength = hds.length;
    var sB = (s as String)
        .split(RegExp(r"~A(?:\w*\s*)*\n"))[1]
        .trim()
        .split(RegExp(r"\s+"))
        .map((m) => LasDart.convertToValue(m.trim()));

    if (sB.length < 0) {
      throw new LasError('No data/~A section in the file');
    }
    var con = LasDart.chunk(sB, totalheadersLength) as List;
    var conSet = con.toSet().toList();

    var conTwo = [];

    for (var f = 0; f < conSet.length; f++) {
      List<dynamic> k = conSet[f];

      for (var x = 0; x < k.length; x++) {
        if (double.parse(nullValue.value) != double.parse('${k[x]}')) {
          if (!(k).contains(double.parse(nullValue?.value))) {
            conTwo.add(k);
          }
        } else {}
      }
    }

    return conTwo.toSet().toList();
  }

  /// Returns the version number of the las file
  /// @returns {Future<num>}
  /// @memberof Las

  Future<num> version() async {
    var v = await this.metadata();
    return v[0];
  }

  /// Returns true if the las file is of wrapped variant and false otherwise
  /// @returns {Future<bool>}
  /// @memberof Las

  Future<bool> wrap() async {
    var v = await this.metadata();
    return v[1];
  }

  /// Returns an extra info about the well stored in ~others section
  /// @returns {Future<string>}
  /// @memberof Las

  Future<String> other() async {
    var s = await this.blobString;
    var som = (s as String).split(RegExp(r"~O(?:\w*\s*)*\n\s*i"))[1];
    var str = '';
    if (som != null) {
      var some =
          som.split('~')[0].replaceAll(new RegExp(r"/\n\s*/g"), ' ').trim();
      str = LasDart.removeComment(some);
    }
    if (str.length <= 0) {
      return '';
    }
    return str;
  }

  /// Returns an array of strings of the logs header/title
  /// @returns {Future<List<String>>}
  /// @memberof Las

  header() async {
    var s = await this.blobString;
    var sth =
        (s as String).split((RegExp(r"~C(?:\w*\s*)*\n\s*")))[1].split('~')[0];

    var uncommentedSth = LasDart.removeComment(sth).trim();
    if (uncommentedSth.length < 0) {
      throw new LasError('There is no header in the file');
    }
    return uncommentedSth
        .split('\n')
        .map((m) => m.trim().split(RegExp(r"\s+|[.]"))[0])
        .toList();
  }

  ///Returns an object, each well header and description as a key-value pair
  ///@returns {Future<Map>}
  ///asJson: true @returns {Future<String>}
  ///@memberof Las

  headerAndDescr({bool asJson = false}) async {
    Map cur = {};

    await this.property('curve');

    try {
      for (var item in props) {
        WellProps itemx = item.rebuild((x) => x..key = null);

        Map<dynamic, dynamic> l = json.decode((item).toJson());
        Map<dynamic, dynamic> ps = json.decode((itemx).toJson());

        cur.putIfAbsent(l["key"], () => ps["description"]);
      }
    } catch (e) {
      print(e.toString());
    }

    /* var hd = (cur).keys;
    var descr = (cur).map(
        (c, i) {
    
          return (cur[c]['description'] == 'none' ? hd.elementAt(i) : cur[c]);
        });
    

    hd.map((i) => (obj[hd.elementAt(i)] = descr[i])); */

    if (cur.length < 0) {
      throw new LasError('Poorly formatted ~curve section in the file');
    }

    return asJson ? jsonPretty(cur) : cur;
  }

  /// Returns details of  well parameters.
  /// @returns {Future<WellProps>}
  /// @memberof Las

  Future<List<WellProps>> wellParams() async {
    (await this.property('well'));
    return props;
  }

  /// Returns details of curve parameters.
  /// @returns {  Future<List<WellProps>>}
  /// @memberof Las

  Future<List<WellProps>> curveParams() async {
    (await this.property('curve'));
    return props;
  }

  /// Returns details of parameters of the well.
  /// @returns {Future<List<WellProps>>}
  /// @memberof Las

  Future<List<WellProps>> logParams() async {
    (await this.property('param'));
    return props;
  }

  ///Returns details of  metadata .
  ///@returns {Future<[num,bool]>}
  ///@memberof Las

  Future metadata() async {
    var str = await this.blobString;
    var sB = (str as String)
        .trim()
        .split(RegExp(r"~V(?:\w*\s*)*\n\s*"))[1]
        .split(RegExp(r"~"))[0];
    var sw = LasDart.removeComment(sB);
    var refined = sw
        .split('\n')
        .map((m) => m.split(RegExp(r"\s{2,}|\s*:")).sublist(0, 2))
        .where((f) => f != null);
    var res = refined.map((r) => r[1]);
    var wrap = res.toList()[1].toLowerCase() == 'yes' ? true : false;

    if ([double.parse(res.toList()[0]), wrap].length < 0) {
      throw new LasError("Couldn't get metadata");
    }

    return [double.parse(res.toList()[0]), wrap];
  }

  static List<WellProps> props = [];

  Future<WellProps> property(String p) async {
    var regDict = {
      "curve": '~C(?:\\w*\\s*)*\\n\\s*',
      "param": '~P(?:\\w*\\s*)*\\n\\s*',
      "well": '~W(?:\\w*\\s*)*\\n\\s*'
    };
    var regExp = new RegExp(regDict[p]);
    var str = await this.blobString;
    var substr = (str as String).split(regExp);
    var sw = '';
    if (substr.length > 1) {
      var res = substr[1].split(RegExp(r"~"))[0];
      sw = LasDart.removeComment(res);
    }

    if (sw.length > 0) {
      WellProps x = WellProps();
      sw.split('\n').forEach((c) {
        var obj = c.replaceAll(RegExp(r"\s*[.]\s+"), '   none   ');
        var title = obj.split(RegExp(r"[.]|\s+"))[0];

        var unit = obj
            .trim()
            .split(RegExp(r"^\w+\s*[.]*s*"))[1]
            .split(RegExp(r"\s+"))[0];

        var description = obj.split(RegExp(r"[:]"))[1].trim() != null &&
                obj
                    .split(RegExp(r"[:]"))[1]
                    .trim()
                    .replaceAll(' ', '')
                    .isNotEmpty
            ? obj.split(RegExp(r"[:]"))[1].trim()
            : 'none';
        var third =
            obj.split(RegExp(r"[:]"))[0].split(RegExp(r"\s{2,}\w*\s{2,}"));

        var value = third.length > 2 && third[third.length - 1] == null
            ? third[third.length - 2]
            : third[third.length - 1];

        var valueWell = third.length > 2 && third[third.length - 1] != null
            ? third[third.length - 2]
            : third[third.length - 1];

        value = p != 'well'
            ? (value.length > 0 ? value.trim() : value)
            : (valueWell.length > 0 ? valueWell.trim() : valueWell);

        props.add(WellProps().rebuild((g) {
          g..unit = unit;
          g..value = value;
          g..description = description;
          g..key = title;
        }));

        x = x.rebuild((g) {
          g..unit = unit;
          g..value = value;
          g..description = description;
        });

        if (description.contains('NULL') || description.contains('none')) {
          WellProps v = WellProps();

          v = v.rebuild((g) {
            g..unit = unit;
            g..value = value;
            g..description = description;
          });

          props.last = props.last.rebuild((b) {
            b..nullValue = v.toBuilder();
          });

          x = x.rebuild((b) {
            b..nullValue = v.toBuilder();
          });
        }
      });
      return x;
    } else {
      throw new PropertyError(p);
    }
  }

  Future initialize() async {
    try {
      /*  if (path != null) {
        var val = await http.get(this.path);
        var text = val.body;
        if (text.contains('404: Not Found')) {
          throw new PathError();
        }
        return text;
      } else {} */

      var file = File(path);
      var contents;

      if (await file.exists()) {
        // Read file
        contents = await file.readAsString();

        return contents;
      } else {
        throw new PathError().message;
      }
    } catch (error) {
      throw new PathError().message;
    }
  }
}
