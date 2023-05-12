class SharedProp {
  const SharedProp(
    this.type,
    this.name, {
    this.ignoreValidTransformation = false,
    this.ignoreNonNullTransformation = false,
    this.ignoreNullTransformation = false,
  });

  /// The type of the shared property.
  ///
  final String type;

  /// The name of the shared property.
  ///
  final String name;

  /// If true, the type (or modddel type(s)) of this shared property will never
  /// be narrowed down to be valid.
  ///
  /// Defaults to false.
  ///
  final bool ignoreValidTransformation;

  /// If true, the type (or modddel type(s)) of this shared property will never
  /// be narrowed down to be non-nullable.
  ///
  /// Defaults to false.
  ///
  final bool ignoreNonNullTransformation;

  /// If true, the type (or modddel type(s)) of this shared property will never
  /// be narrowed down to be "Null".
  ///
  /// Defaults to false.
  ///
  final bool ignoreNullTransformation;
}
