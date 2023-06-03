import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen_test/annotations.dart';

import '_common.dart';

/* -------------------------------------------------------------------------- */
/*                    Must have a private empty constructor                   */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'The class "NoPrivateConstructor" is decorated with @Modddel and thus '
  'should have a single non-factory constructor, without parameters, '
  'and named NoPrivateConstructor._()',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NoPrivateConstructor extends SimpleEntity {}

@ShouldThrow(
  'The class "DefaultConstructor" is decorated with @Modddel and thus '
  'should have a single non-factory constructor, without parameters, '
  'and named DefaultConstructor._()',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class DefaultConstructor extends SimpleEntity {
  DefaultConstructor();
}

@ShouldThrow(
  'The class "NamedConstructor" is decorated with @Modddel and thus '
  'should have a single non-factory constructor, without parameters, '
  'and named NamedConstructor._()',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NamedConstructor extends SimpleEntity {
  NamedConstructor._named();
}

@ShouldThrow(
  'The class "PrivateConstructorWithParams" is decorated with @Modddel and thus '
  'should have a single non-factory constructor, without parameters, '
  'and named PrivateConstructorWithParams._()',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class PrivateConstructorWithParams extends SimpleEntity {
  PrivateConstructorWithParams._(AClass param);
}

/* -------------------------------------------------------------------------- */
/*       Can't have a non-factory constructor other than the private one      */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'The class "ExtraDefaultConstructor1" is decorated with @Modddel and thus '
  'cannot have a non-factory constructor other than the private '
  'constructor "ExtraDefaultConstructor1._()"',
  element: '',
)
@Modddel(validationSteps: noVSteps)
class ExtraDefaultConstructor1 extends SimpleEntity {
  ExtraDefaultConstructor1();

  // ignore: unused_element
  ExtraDefaultConstructor1._();
}

@ShouldThrow(
  'The class "ExtraDefaultConstructor2" is decorated with @Modddel and thus '
  'cannot have a non-factory constructor other than the private '
  'constructor "ExtraDefaultConstructor2._()"',
  element: '',
)
@Modddel(validationSteps: noVSteps)
class ExtraDefaultConstructor2 extends SimpleEntity {
  // ignore: unused_element
  ExtraDefaultConstructor2._();

  ExtraDefaultConstructor2();
}

@ShouldThrow(
  'The class "ExtraDefaultConstructorWithParams" is decorated with @Modddel and thus '
  'cannot have a non-factory constructor other than the private '
  'constructor "ExtraDefaultConstructorWithParams._()"',
  element: '',
)
@Modddel(validationSteps: noVSteps)
class ExtraDefaultConstructorWithParams extends SimpleEntity {
  // ignore: unused_element
  ExtraDefaultConstructorWithParams._();

  ExtraDefaultConstructorWithParams(AClass param1, {required AClass param2});
}

@ShouldThrow(
  'The class "ExtraNamedConstructor" is decorated with @Modddel and thus '
  'cannot have a non-factory constructor other than the private '
  'constructor "ExtraNamedConstructor._()"',
  element: 'named',
)
@Modddel(validationSteps: noVSteps)
class ExtraNamedConstructor extends SimpleEntity {
  ExtraNamedConstructor.named();

  // ignore: unused_element
  ExtraNamedConstructor._();
}

@ShouldThrow(
  'The class "ExtraNamedConstructorWithParams" is decorated with @Modddel and thus '
  'cannot have a non-factory constructor other than the private '
  'constructor "ExtraNamedConstructorWithParams._()"',
  element: 'named',
)
@Modddel(validationSteps: noVSteps)
class ExtraNamedConstructorWithParams extends SimpleEntity {
  // ignore: unused_element
  ExtraNamedConstructorWithParams._();

  ExtraNamedConstructorWithParams.named({
    required AClass param1,
    required AClass param2,
  });
}

@ShouldThrow(
  'The class "ExtraPrivateNamedConstructor" is decorated with @Modddel and thus '
  'cannot have a non-factory constructor other than the private '
  'constructor "ExtraPrivateNamedConstructor._()"',
  element: '_named',
)
@Modddel(validationSteps: noVSteps)
class ExtraPrivateNamedConstructor extends SimpleEntity {
  // ignore: unused_element
  ExtraPrivateNamedConstructor._();

  // ignore: unused_element
  ExtraPrivateNamedConstructor._named();
}

@ShouldThrow(
  'The class "ExtraPrivateNamedConstructorWithParams" is decorated with @Modddel and thus '
  'cannot have a non-factory constructor other than the private '
  'constructor "ExtraPrivateNamedConstructorWithParams._()"',
  element: '_named',
)
@Modddel(validationSteps: noVSteps)
class ExtraPrivateNamedConstructorWithParams extends SimpleEntity {
  // ignore: unused_element
  ExtraPrivateNamedConstructorWithParams._();

  // ignore: unused_element
  ExtraPrivateNamedConstructorWithParams._named({
    required AClass param1,
    required AClass param2,
  });
}

@ShouldThrow(
  'The class "MultipleExtraConstructors1" is decorated with @Modddel and thus '
  'cannot have a non-factory constructor other than the private '
  'constructor "MultipleExtraConstructors1._()"',
  element: '',
)
@Modddel(validationSteps: noVSteps)
class MultipleExtraConstructors1 extends SimpleEntity {
  // ignore: unused_element
  MultipleExtraConstructors1._();

  // ignore: unused_element
  MultipleExtraConstructors1();

  // ignore: unused_element
  MultipleExtraConstructors1.named();

  // ignore: unused_element
  MultipleExtraConstructors1._named();
}

@ShouldThrow(
  'The class "MultipleExtraConstructors2" is decorated with @Modddel and thus '
  'cannot have a non-factory constructor other than the private '
  'constructor "MultipleExtraConstructors2._()"',
  element: 'named',
)
@Modddel(validationSteps: noVSteps)
class MultipleExtraConstructors2 extends SimpleEntity {
  // ignore: unused_element
  MultipleExtraConstructors2.named();

  // ignore: unused_element
  MultipleExtraConstructors2();

  // ignore: unused_element
  MultipleExtraConstructors2._();

  // ignore: unused_element
  MultipleExtraConstructors2._named();
}

/* -------------------------------------------------------------------------- */
/*                      At least one factory constructor                      */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'Marked NoFactory with @Modddel, but there is no factory constructor.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NoFactory extends SimpleEntity {
  NoFactory._();
}

/* -------------------------------------------------------------------------- */
/*                       Valid factory constructor usage                      */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'A Modddel cannot have private factory constructors.',
  element: '_name',
)
@Modddel(validationSteps: noVSteps)
class PrivateFactory extends SimpleEntity {
  PrivateFactory._();

  // ignore: unused_element
  factory PrivateFactory._name() => PrivateFactory._();
}

@ShouldThrow(
  'A Modddel cannot have const factory constructors.',
  element: 'name',
)
@Modddel(validationSteps: noVSteps)
class ConstFactory extends SimpleEntity {
  // ignore: unused_element
  ConstFactory._();

  const factory ConstFactory.name() = _ConstFactory;
}

class _ConstFactory implements ConstFactory {
  const _ConstFactory();
}

@ShouldThrow(
  'A Modddel cannot have redirecting factory constructors.',
  element: 'name',
)
@Modddel(validationSteps: noVSteps)
class RedirectingFactory extends SimpleEntity {
  // ignore: unused_element
  RedirectingFactory._();

  factory RedirectingFactory.name() = _RedirectedFactory;
}

class _RedirectedFactory implements RedirectingFactory {
  _RedirectedFactory();
}

/* -------------------------------------------------------------------------- */
/*                       Valid factory constructor names                      */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'The name of the factory constructor "defaultConflictingFactoryName" conflicts '
  'with the default factory constructor.',
  element: 'defaultConflictingFactoryName',
)
@Modddel(validationSteps: noVSteps)
class ConflictingFactoryName extends SimpleEntity {
  // ignore: unused_element
  ConflictingFactoryName._();

  factory ConflictingFactoryName() => ConflictingFactoryName._();

  factory ConflictingFactoryName.defaultConflictingFactoryName() =>
      ConflictingFactoryName._();
}
