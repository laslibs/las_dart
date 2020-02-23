  

# LasDart is a Dart library for parsing .Las file (Geophysical well log files).

  

### Currently supports only version 2.0 of LAS Specification. For more information about this format, see the Canadian Well Logging Society [web page](http://www.cwls.org/las/)

  

## How to use

  

- Installing

  

> Pub

  
Add dependency to pubspec.yaml
```sh

las_dart: latest_version

```

  

- Usage

```dart

import  'package:las_dart/las_dart.dart';

```

  

```dart

var  myLas  =  new  LasDart('A10.las'); 
```

  

- Read data

  

> Use LasDart.data to get a 2-dimensional array containing the readings of each log,

> Or LasDart.dataStripped to get the same as above but with all rows containing null values stripped off

  

```dart

read() async {

try {

var data =  await myLas.data();

print(data);

  

/*

  

[[2650.0, 177.825, -999.25, -999.25],

  

[2650.5, 182.5, -999.25,-999.25],

  

[2651.0,180.162, -999.25, -999.25],

  

[2651.5, 177.825, -999.25, -999.25],

  

[2652.0, 177.825, -999.25, -999.25] ...]

  

*/

  

var dataStripped =  await myLas.dataStripped();

  

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

```

  

- Get the log headers

  
  

```dart

// ...

var  headers  =  await  myLas.header();

print(headers);

// ['DEPTH', 'GR', 'NPHI', 'RHOB']

// ...

```

  

- Get the log headers descriptions

  
  

```dart

//...

var  headerAndDescr  =  await  myLas.headerAndDescr();

print(headerAndDescr);

// {DEPT: Measured Depth, CILD: Deep Induction R Conductivity, CALN: Compensated Neutron Caliper (Diameter)},

// ...

```

  

- Get a particular column, say Gamma Ray log

  
  

```dart

// ...

var  gammaRay  =  await  myLas.column('GR');

print(gammaRay);

// [-999.25, -999.25, -999.25, -999.25, -999.25, 122.03, 123.14, ...]

// ...

```

```dart

// ...

// get column with null values stripped

var  gammaRay  =  await  myLas.columnStripped('GR');

print(gammaRay);

// [61.61, 59.99, 54.02, 50.87, 54.68, 64.39, 77.96, ...]

// ...

```

> Note this returns the column, after all the data has been stripped off their null values, which means that valid data in a particular column would be stripped off if there is another column that has a null value at that particular row

  

- Get the Well Parameters

  

### Presents a way of accessing the details of individual well parameters.

  

### The details include the following:

  

1. descr - Description/ Full name of the well parameter

2. units - Its unit measurements

3. value - Value

  

```dart

// ...

var  well  =  await  myLas.wellParams()

/* returns
 [
   WellProps {
  unit=FEET,
  key=STRT,
  value=2363.20,
  nullValue=WellProps {
    unit=FEET,
    value=2363.20,
    description=none,
  },
  description=none,
}, WellProps {
  unit=FEET,
  key=STOP,
  value=2692.20,
  nullValue=WellProps {
    unit=FEET,
    value=2692.20,
    description=none,
  },
  description=none,
}
 ] */

// Any other well parameter present in the file, can be gotten with the same syntax above

// ...

```

  

- Get the Curve Parameters

  

### Presents a way of accessing the details of individual log columns.

  

### The details include the following:

  

1. descr - Description/ Full name of the log column

2. units - Unit of the log column measurements

3. value - API value of the log column

  

```dart

// ...

const  curve  =  await  myLas.curveParams()

/* returns 
[WellProps {
  unit=FEET,
  key=DEPT,
  value=00 001 00 00,
  description=Measured Depth,
}, WellProps {
  unit=mMHO,
  key=CILD,
  value=07 110 45 00,
  description=Deep Induction R Conductivity,
}, WellProps {
  unit=in,
  key=CALN,
  value=45 280 24 00,
  description=Compensated Neutron Caliper (Diameter),
}]
*/

// This is the same for all log column present in the file

// ...

```

  

- Get the Parameters of the well

  

### The details include the following:

  

1. descr - Description/ Full name of the log column

2. units - Unit of the log column measurements

3. value - API value of the log column

  

```dart

// ...

VAR  param  =  await  myLas.logParams(); 
/* returns
[WellProps {
  unit=none,
  key=BASE,
  value=TULSA, OK,
  description=Home base of logging unit,
}, WellProps {
  unit=none,
  key=ENG,
  value=SHELDON TYLER,
  description=Recording Engineer,
}, WellProps {
  unit=none,
  key=WIT,
  value=BILL STOUT,
  description=Witnessed by,
}]
*/

// This is the same for all well parameters present in the file

// ...

```

  

- Get the number of rows and columns

  
  

```dart

// ...

var  numRows  =  await  myLas.rowCount() // 4

var  numColumns  =  await  myLas.columnCount() // 3081

// ...

```

  

- Get the version and wrap

  
  

```dart

// ...

var  version  =  await  myLas.version() // '2.0'

var  wrap  =  await  myLas.wrap() // true

// ...

```

  

- Get other information

  

```dart

// ...

var  other  =  await  myLas.other()

print(other)

// Note: The logging tools became stuck at 625 metres causing the data between 625 metres and 615 metres to be invalid.

// ...

```

  

- Export to CSV


```dart

//...

await  myLas.toCsv('result')

// result.csv has been created Successfully!

//...

```

  

> result.csv

  

| DEPT | RHOB | GR | NPHI |

| ---- | ------- | ------- | ----- |

| 0.5 | -999.25 | -999.25 | -0.08 |

| 1.0 | -999.25 | -999.25 | -0.08 |

| 1.5 | -999.25 | -999.25 | -0.04 |

| ... | ... | ... | ... |

| 1.3 | -999.25 | -999.25 | -0.08 |

  

Or get the version of csv with null values stripped

  

```dart

// ...

await  myLas.toCsvStripped('clean')

// clean.csv has been created Successfully!

// ...

```

  

> clean.csv

  

| DEPT | RHOB | GR | NPHI |

| ---- | ----- | ---- | ----- |

| 80.5 | 2.771 | 18.6 | -6.08 |

| 81.0 | 2.761 | 17.4 | -6.0 |

| 81.5 | 2.752 | 16.4 | -5.96 |

| ... | ... | ... | ... |

| 80.5 | 2.762 | 16.2 | -5.06 |


-  ## Support

LasDart is an MIT-licensed open source project. You can help it grow by becoming a sponsor/supporter.[Become a Patron!](https://www.patreon.com/bePatron?u=19152008)
