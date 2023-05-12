import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen_test/annotations.dart';

import '_common.dart';

/* -------------------------------------------------------------------------- */
/*                    Must have a private empty constructor                   */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'Classes decorated with @Modddel should have a single non-factory '
  'constructor, without parameters, and named NoPrivateConstructor._()',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NoPrivateConstructor extends SimpleEntity {}

@ShouldThrow(
  'Classes decorated with @Modddel should have a single non-factory '
  'constructor, without parameters, and named DefaultConstructor._()',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class DefaultConstructor extends SimpleEntity {
  DefaultConstructor();
}

@ShouldThrow(
  'Classes decorated with @Modddel should have a single non-factory '
  'constructor, without parameters, and named NamedConstructor._()',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NamedConstructor extends SimpleEntity {
  NamedConstructor._named();
}

@ShouldThrow(
  'Classes decorated with @Modddel should have a single non-factory '
  'constructor, without parameters, and named PrivateConstructorWithParams._()',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class PrivateConstructorWithParams extends SimpleEntity {
  PrivateConstructorWithParams._(AClass param);
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
