## Structure of las libraries - Guideline for adding new libraries

### Each library/package for a specific language has the following attributes:

> [Las 2.0 Specification](http://www.cwls.org/wp-content/uploads/2017/02/Las2_Update_Feb2017.pdf)

- Exports a class/factory function/struct called **Las** that can be used for initialising the parser
  taking path/blob of the _las_ as its only argument.

- Attached to **Las** are the following public instance methods/equivalents depending on the language.

```dart
class Las {
  // instance variables - private


	String path;
	Future blobString;

	/**
	* Creates an instance of Las.
	* @param  {string}  path - Absolute path to las file
	* @memberof  Las
	*/

	LasDart(this.path) {
	this.blobString =  this.initialize();
	}


   /**
   * Returns a column in a las file
   * @param {string} column - name of column
   * @returns {(Future<List<dynamic>>)}
   * @memberof Las
   */
  column(String column);


  /**
   * Returns a column in a las file stripped off null values
   * @param {string} column - name of column
   * @returns {(Future<List<dynamic>>)}
   * @memberof Las
   */
  Future columnStripped(String column);


  /**
   * Returns a csv File object in browser | writes csv file to current working driectory in Node
   * @param {string} filename
   * @returns {(Future<File>)}
   * @memberof Las
   */
  Future<File> toCsv({@required String filename});


 /**
   * Returns a csv File object in browser and writes csv file to current working driectory in Node of data stripped of null values
   * @param {string} filename
   * @returns {(Future<File>)}
   * @memberof Las
   */
  Future<File> toCsvStripped({@required String filename});


  /**
   * Returns the number of rows in a .las file
   * @returns number
   * @memberof Las
   */
  Future<num> rowCount();


  /**
   * Returns the number of columns in a .las file
   * @returns number
   * @memberof Las
   */
  Future<num> columnCount();


  /**
   * Returns a two-dimensional array of data in the log
   * @returns {(Future<List<List<dynamic>>>)}
   * @memberof Las
   */
  data();


  /**
   * Returns a two-dimensional array of data in the log with all rows containing null values stripped off
   * @returns {(Future<List<List<dynamic>>>)}
   * @memberof Las
   */
  dataStripped();


  /**
   * Returns the version number of the las file
   * @returns {Future<num>}
   * @memberof Las
   */
  Future<num> version();


   /**
   * Returns true if the las file is of wrapped variant and false otherwise
   * @returns {Future<bool>}
   * @memberof Las
   */
  Future<bool> wrap();


   /**
   * Returns an extra info about the well stored in ~others section
   * @returns {Future<string>}
   * @memberof Las
   */
  Future<String> other();


 /**
   * Returns an array of strings of the logs header/title
   * @returns {Future<List<String>>}
   * @memberof Las
   */
  header()({bool asJson = false});


  /**
   * Returns an object, each well header and description as a key-value pair
   * @returns {Future<Map>}
   * asJson: true @returns {Future<String>}
   * @memberof Las
   */
  headerAndDescr({bool asJson = false});


  /**
   * Returns details of  well parameters.
   * @returns {Promise<WellProps>}
   * @memberof Las
   */
  wellParams(): Promise<WellProps>;


  /**
   * Returns details of  well parameters.
   * @returns {Future<WellProps>}
   * @memberof Las
   */
  Future<List<WellProps>> wellParams();


  /**
   * Returns details of  curve parameters.
   * @returns {  Future<List<WellProps>>}
   * @memberof Las
   */
  Future<List<WellProps>> curveParams();


  /**
   * Returns details of  parameters of the well.
   * @returns {Future<List<WellProps>>}
   * @memberof Las
   */
  Future<List<WellProps>> logParams()
}
```

An example of implementation of the above methods in Typescript can be found in [Here](/src/index.ts)
The methods uses pattern matching(Regular Expresion) to target path of the file they want to extract and parse. Check Las 2.0 specification for more - link above.

- Customs errors that can be thrown at different situations are:

```dart

class LasError {
  String name, message;

  LasError(this.message, {this.name = 'LasError'});
}

class ColumnError {
  String message, name, column;

  ColumnError(
    this.column, {
    this.name = 'ColumnError',
  }) : message = "Column ${column} doesn't exist in the file";
}

class PathError {
  String message, name;

  PathError({this.name = 'PathError', this.message = 'Path is invalid'});
}

class CsvError {
  String message, name;

  CsvError(
      {this.name = 'CsvError', this.message = "Couldn't convert file to CSV"});
}

class PropertyError {
  String message, name, property;

  PropertyError(
    this.property, {
    this.name = 'PropertyError',
  }) : message = "Property ${property} doesn't exist";
}


```

An example of implementation of the errors in Typescript can be found in [Here](/src/error.ts)
