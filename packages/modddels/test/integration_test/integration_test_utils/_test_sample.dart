import 'integration_test_utils.dart';

/* -------------------------------------------------------------------------- */
/*                                Sample values                               */
/* -------------------------------------------------------------------------- */

/// The base class for the SampleValues of a test sample.
///
/// If you need to create SampleValues for a test sample for :
///
/// - [ModddelsTestSupport] : Use [ModddelSampleValues]
/// - [ValueObjectsTestSupport] : Use [ValueObjectSampleValues]
/// - [EntitiesTestSupport] : Use [EntitySampleValues]
///
abstract class SampleValuesBase<P extends SampleParamsBase> {}

/// In a test sample, holds the values that will be used to instantiate
/// the tested modddels.
///
class ModddelSampleValues<P extends SampleParamsBase>
    extends SampleValuesBase<P> {
  ModddelSampleValues({
    required this.singleValueObject,
    required this.multiValueObject,
    required this.simpleEntity,
    required this.iterableEntity,
    required this.iterable2Entity,
  });

  final P singleValueObject;

  final P multiValueObject;

  final P simpleEntity;

  final P iterableEntity;

  final P iterable2Entity;
}

/// Same as [ModddelSampleValues], but for ValueObjects only.
///
class ValueObjectSampleValues<P extends SampleParamsBase>
    extends SampleValuesBase<P> {
  ValueObjectSampleValues({
    required this.singleValueObject,
    required this.multiValueObject,
  });

  final P singleValueObject;

  final P multiValueObject;
}

/// Same as [ModddelSampleValues], but for Entities only.
///
class EntitySampleValues<P extends SampleParamsBase>
    extends SampleValuesBase<P> {
  EntitySampleValues({
    required this.simpleEntity,
    required this.iterableEntity,
    required this.iterable2Entity,
  });

  final P simpleEntity;

  final P iterableEntity;

  final P iterable2Entity;
}

/// Holds the parameters of the modddels.
///
/// This should be extended so as to add the properties that represent
/// the different parameters of the modddels.
///
/// For example :
///
/// ```dart
/// class MyParams extends SampleParamsBase {
///   MyParams(this.param, this.dependency);
///
///   final ParamWithSource param;
///   final ParamWithSource dependency;
/// }
/// ```
///
abstract class SampleParamsBase {}

class NoSampleParams extends SampleParamsBase {}

/// This class holds a parameter [value] and its [src] code.
///
class ParamWithSource<T> {
  const ParamWithSource(this.value, this.src);

  final T value;

  final String src;
}

/* -------------------------------------------------------------------------- */
/*                                SampleOptions                               */
/* -------------------------------------------------------------------------- */

/// In a test sample, allows to customize the created modddels. This class
/// should be extended so as to add the options for your specific usecase.
///
/// Example :
///
/// ```dart
/// class MySampleOptions extends SampleOptionsBase {
///   MySampleOptions(super.name, {required this.lengthValidationPasses});
///
///   final bool lengthValidationPasses;
/// }
/// ```
///

abstract class SampleOptionsBase {
  SampleOptionsBase(this.name);

  /// The name of the test sample.
  ///
  final String name;
}

class NoSampleOptions extends SampleOptionsBase {
  NoSampleOptions(super.name);
}
