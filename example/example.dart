import 'package:las_dart/las_dart.dart';

main() {
  var myLas = new LasDart('example1.las');

  read() async {
    try {
      /*  var data = await myLas.data();
      print(data); */

      /*

          [[2650.0, 177.825, -999.25, -999.25],

          [2650.5, 182.5, -999.25,-999.25],

          [2651.0,180.162, -999.25, -999.25],

          [2651.5, 177.825, -999.25, -999.25],

          [2652.0, 177.825, -999.25, -999.25] ...]

          */

      var dataStripped = await myLas.wellParams();

      print(dataStripped);

      /* [[2657.5, 212.002, 0.16665, 1951.74597],

          [2658.0, 201.44, 0.1966, 1788.50696],

          [2658.5, 204.314, 0.21004, 1723.21204],

          [2659.0, 212.075, 0.22888, 1638.328],

          [2659.5, 243.536, 0.22439, 1657.91699]...]

          */

    } catch (error) {
      print(error.toString());
    }
  }

  read();
}
