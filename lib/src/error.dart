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
