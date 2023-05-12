import 'package:modddels_annotation_internal/modddels_annotation_internal.dart';
import 'package:source_gen_test/annotations.dart';

import '_common.dart';

/* -------------------------------------------------------------------------- */
/*              The number of TypeTemplate annotations is correct             */
/* -------------------------------------------------------------------------- */

/* ------------------ Should have a TypeTemplate annotation ----------------- */

class _NoAnnotationIterable extends IterableEntity {}

class _NoAnnotationIterable2 extends Iterable2Entity {}

@ShouldThrow(
  'No TypeTemplate annotation found.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NoTypeTemplate1 extends IterableEntity {
  NoTypeTemplate1._();

  factory NoTypeTemplate1() => NoTypeTemplate1._();
}

@ShouldThrow(
  'No TypeTemplate annotation found.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NoTypeTemplate2 extends _NoAnnotationIterable {
  NoTypeTemplate2._();

  factory NoTypeTemplate2.named() => NoTypeTemplate2._();
}

@ShouldThrow(
  'No TypeTemplate annotation found.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NoTypeTemplate3 extends Iterable2Entity {
  NoTypeTemplate3._();

  factory NoTypeTemplate3() => NoTypeTemplate3._();
}

@ShouldThrow(
  'No TypeTemplate annotation found.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class NoTypeTemplate4 extends _NoAnnotationIterable2 {
  NoTypeTemplate4._();

  factory NoTypeTemplate4() => NoTypeTemplate4._();
}

/* -------------- Can't have multiple TypeTemplate annotations -------------- */

@TypeTemplate('first')
@TypeTemplate('second')
class _MultipleAnnotationsIterable extends IterableEntity {}

@TypeTemplate('first')
@TypeTemplate('second')
class _MultipleAnnotationsIterable2 extends Iterable2Entity {}

@ShouldThrow(
  'A class can\'t have more than one TypeTemplate annotation.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
@TypeTemplate('first')
@TypeTemplate('second')
class MultipleTypeTemplates1 extends IterableEntity {
  MultipleTypeTemplates1._();

  factory MultipleTypeTemplates1() => MultipleTypeTemplates1._();
}

@ShouldThrow(
  'A class can\'t have more than one TypeTemplate annotation.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
@TypeTemplate('first')
@TypeTemplate('second')
@TypeTemplate('third')
class MultipleTypeTemplates2 extends IterableEntity {
  MultipleTypeTemplates2._();

  factory MultipleTypeTemplates2() => MultipleTypeTemplates2._();
}

@ShouldThrow(
  'A class can\'t have more than one TypeTemplate annotation.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class MultipleTypeTemplates3 extends _MultipleAnnotationsIterable {
  MultipleTypeTemplates3._();

  factory MultipleTypeTemplates3() => MultipleTypeTemplates3._();
}

@ShouldThrow(
  'A class can\'t have more than one TypeTemplate annotation.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
@TypeTemplate('first')
@TypeTemplate('second')
class MultipleTypeTemplates4 extends Iterable2Entity {
  MultipleTypeTemplates4._();

  factory MultipleTypeTemplates4() => MultipleTypeTemplates4._();
}

@ShouldThrow(
  'A class can\'t have more than one TypeTemplate annotation.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
@TypeTemplate('first')
@TypeTemplate('second')
@TypeTemplate('third')
class MultipleTypeTemplates5 extends Iterable2Entity {
  MultipleTypeTemplates5._();

  factory MultipleTypeTemplates5() => MultipleTypeTemplates5._();
}

@ShouldThrow(
  'A class can\'t have more than one TypeTemplate annotation.',
  element: null,
)
@Modddel(validationSteps: noVSteps)
class MultipleTypeTemplates6 extends _MultipleAnnotationsIterable2 {
  MultipleTypeTemplates6._();

  factory MultipleTypeTemplates6() => MultipleTypeTemplates6._();
}

/* -------------------------------------------------------------------------- */
/*                     The TypeTemplate syntax is correct                     */
/* -------------------------------------------------------------------------- */

/* ------------------ The # character is reserved for masks ----------------- */

@ShouldThrow(
  'TypeTemplateSyntaxError: The "#" character is reserved for masks, and must '
  'be followed by a number.\n'
  'Invalid TypeTemplate : "List<#a1>"\n',
  element: null,
)
@TypeTemplate('List<#a1>')
@Modddel(validationSteps: noVSteps)
class HashWithoutNumber1 extends IterableEntity {
  HashWithoutNumber1._();

  factory HashWithoutNumber1() => HashWithoutNumber1._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The "#" character is reserved for masks, and must '
  'be followed by a number.\n'
  'Invalid TypeTemplate : "AClass<#,#2>"\n',
  element: null,
)
@TypeTemplate('AClass<#,#2>')
@Modddel(validationSteps: noVSteps)
class HashWithoutNumber2 extends IterableEntity {
  HashWithoutNumber2._();

  factory HashWithoutNumber2() => HashWithoutNumber2._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The "#" character is reserved for masks, and must '
  'be followed by a number.\n'
  'Invalid TypeTemplate : "#.9"\n',
  element: null,
)
@TypeTemplate('#.9')
@Modddel(validationSteps: noVSteps)
class HashWithoutNumber3 extends Iterable2Entity {
  HashWithoutNumber3._();

  factory HashWithoutNumber3() => HashWithoutNumber3._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The "#" character is reserved for masks, and must '
  'be followed by a number.\n'
  'Invalid TypeTemplate : "Map<#1,#>"\n',
  element: null,
)
@TypeTemplate('Map<#1,#>')
@Modddel(validationSteps: noVSteps)
class HashWithoutNumber4 extends Iterable2Entity {
  HashWithoutNumber4._();

  factory HashWithoutNumber4() => HashWithoutNumber4._();
}

/* ---------------- The * character is reserved for wildcards --------------- */

@ShouldThrow(
  'TypeTemplateSyntaxError: The "*" character is reserved for wildcards, and '
  'should not be followed by a number.\n'
  'Invalid TypeTemplate : "List<*1>"\n',
  element: null,
)
@TypeTemplate('List<*1>')
@Modddel(validationSteps: noVSteps)
class AsteriskWithNumber1 extends IterableEntity {
  AsteriskWithNumber1._();

  factory AsteriskWithNumber1() => AsteriskWithNumber1._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The "*" character is reserved for wildcards, and '
  'should not be followed by a number.\n'
  'Invalid TypeTemplate : "AClass<#1,*2>"\n',
  element: null,
)
@TypeTemplate('AClass<#1,*2>')
@Modddel(validationSteps: noVSteps)
class AsteriskWithNumber2 extends IterableEntity {
  AsteriskWithNumber2._();

  factory AsteriskWithNumber2() => AsteriskWithNumber2._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The "*" character is reserved for wildcards, and '
  'should not be followed by a number.\n'
  'Invalid TypeTemplate : "*10"\n',
  element: null,
)
@TypeTemplate('*10')
@Modddel(validationSteps: noVSteps)
class AsteriskWithNumber3 extends Iterable2Entity {
  AsteriskWithNumber3._();

  factory AsteriskWithNumber3() => AsteriskWithNumber3._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The "*" character is reserved for wildcards, and '
  'should not be followed by a number.\n'
  'Invalid TypeTemplate : "Map<*1,*>"\n',
  element: null,
)
@TypeTemplate('Map<*1,*>')
@Modddel(validationSteps: noVSteps)
class AsteriskWithNumber4 extends Iterable2Entity {
  AsteriskWithNumber4._();

  factory AsteriskWithNumber4() => AsteriskWithNumber4._();
}

/* ---------------------- The @ character is forbidden ---------------------- */

@ShouldThrow(
  'TypeTemplateSyntaxError: The "@" character is reserved and should not be used.\n'
  'Invalid TypeTemplate : "List<@1>"\n',
  element: null,
)
@TypeTemplate('List<@1>')
@Modddel(validationSteps: noVSteps)
class AtSymbol1 extends IterableEntity {
  AtSymbol1._();

  factory AtSymbol1() => AtSymbol1._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The "@" character is reserved and should not be used.\n'
  'Invalid TypeTemplate : "AClass<#1,@>"\n',
  element: null,
)
@TypeTemplate('AClass<#1,@>')
@Modddel(validationSteps: noVSteps)
class AtSymbol2 extends IterableEntity {
  AtSymbol2._();

  factory AtSymbol2() => AtSymbol2._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The "@" character is reserved and should not be used.\n'
  'Invalid TypeTemplate : "@3"\n',
  element: null,
)
@TypeTemplate('@3')
@Modddel(validationSteps: noVSteps)
class AtSymbol3 extends Iterable2Entity {
  AtSymbol3._();

  factory AtSymbol3() => AtSymbol3._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The "@" character is reserved and should not be used.\n'
  'Invalid TypeTemplate : "Map<@2,#1>"\n',
  element: null,
)
@TypeTemplate('Map<@2,#1>')
@Modddel(validationSteps: noVSteps)
class AtSymbol4 extends Iterable2Entity {
  AtSymbol4._();

  factory AtSymbol4() => AtSymbol4._();
}

/* --------------- The mask nbs should be numbered from 1 to N -------------- */

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks should be numbered from 1 to N.\n'
  'Invalid TypeTemplate : "List<#0>"\n',
  element: null,
)
@TypeTemplate('List<#0>')
@Modddel(validationSteps: noVSteps)
class NonConsecutive1 extends IterableEntity {
  NonConsecutive1._();

  factory NonConsecutive1() => NonConsecutive1._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks should be numbered from 1 to N.\n'
  'Invalid TypeTemplate : "AClass<#0,#1>"\n',
  element: null,
)
@TypeTemplate('AClass<#0,#1>')
@Modddel(validationSteps: noVSteps)
class NonConsecutive2 extends IterableEntity {
  NonConsecutive2._();

  factory NonConsecutive2() => NonConsecutive2._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks should be numbered from 1 to N.\n'
  'Invalid TypeTemplate : "AClass<#1,#3>"\n',
  element: null,
)
@TypeTemplate('AClass<#1,#3>')
@Modddel(validationSteps: noVSteps)
class NonConsecutive3 extends IterableEntity {
  NonConsecutive3._();

  factory NonConsecutive3() => NonConsecutive3._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks should be numbered from 1 to N.\n'
  'Invalid TypeTemplate : "Map<#2,#3>"\n',
  element: null,
)
@TypeTemplate('Map<#2,#3>')
@Modddel(validationSteps: noVSteps)
class NonConsecutive4 extends Iterable2Entity {
  NonConsecutive4._();

  factory NonConsecutive4() => NonConsecutive4._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks should be numbered from 1 to N.\n'
  'Invalid TypeTemplate : "AClass<#3,#2,#4>"\n',
  element: null,
)
@TypeTemplate('AClass<#3,#2,#4>')
@Modddel(validationSteps: noVSteps)
class NonConsecutive5 extends Iterable2Entity {
  NonConsecutive5._();

  factory NonConsecutive5() => NonConsecutive5._();
}

/* ----------- Masks & wildcards are separated by "<", ">" or "," ----------- */

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks and wildcards in the TypeTemplate must be '
  'separated by a sequence of characters that includes "<", ">" or ",".\n'
  'Invalid TypeTemplate : "AClass<#1*>"\n',
  element: null,
)
@TypeTemplate('AClass<#1*>')
@Modddel(validationSteps: noVSteps)
class NonSeparated1 extends IterableEntity {
  NonSeparated1._();

  factory NonSeparated1() => NonSeparated1._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks and wildcards in the TypeTemplate must be '
  'separated by a sequence of characters that includes "<", ">" or ",".\n'
  'Invalid TypeTemplate : "AClass<#1#2>"\n',
  element: null,
)
@TypeTemplate('AClass<#1#2>')
@Modddel(validationSteps: noVSteps)
class NonSeparated2 extends IterableEntity {
  NonSeparated2._();

  factory NonSeparated2() => NonSeparated2._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks and wildcards in the TypeTemplate must be '
  'separated by a sequence of characters that includes "<", ">" or ",".\n'
  'Invalid TypeTemplate : "AClass<#2 #1>"\n',
  element: null,
)
@TypeTemplate('AClass<#2 #1>')
@Modddel(validationSteps: noVSteps)
class NonSeparated3 extends IterableEntity {
  NonSeparated3._();

  factory NonSeparated3() => NonSeparated3._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks and wildcards in the TypeTemplate must be '
  'separated by a sequence of characters that includes "<", ">" or ",".\n'
  'Invalid TypeTemplate : "AClass<#1Another\$Class?*>"\n',
  element: null,
)
@TypeTemplate('AClass<#1Another\$Class?*>')
@Modddel(validationSteps: noVSteps)
class NonSeparated4 extends IterableEntity {
  NonSeparated4._();

  factory NonSeparated4() => NonSeparated4._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks and wildcards in the TypeTemplate must be '
  'separated by a sequence of characters that includes "<", ">" or ",".\n'
  'Invalid TypeTemplate : "Map<#1,**>"\n',
  element: null,
)
@TypeTemplate('Map<#1,**>')
@Modddel(validationSteps: noVSteps)
class NonSeparated5 extends Iterable2Entity {
  NonSeparated5._();

  factory NonSeparated5() => NonSeparated5._();
}

@ShouldThrow(
  'TypeTemplateSyntaxError: The masks and wildcards in the TypeTemplate must be '
  'separated by a sequence of characters that includes "<", ">" or ",".\n'
  'Invalid TypeTemplate : "Map<* _My #1>"\n',
  element: null,
)
@TypeTemplate('Map<* _My #1>')
@Modddel(validationSteps: noVSteps)
class NonSeparated6 extends Iterable2Entity {
  NonSeparated6._();

  factory NonSeparated6() => NonSeparated6._();
}

/* -------------------------------------------------------------------------- */
/*            The TypeTemplate contains the correct number of masks           */
/* -------------------------------------------------------------------------- */

@ShouldThrow(
  'The TypeTemplate should contain 1 mask(s).',
  element: null,
)
@TypeTemplate('List<String>')
@Modddel(validationSteps: noVSteps)
class NoMaskIterableEntity1 extends IterableEntity {
  NoMaskIterableEntity1._();

  factory NoMaskIterableEntity1() => NoMaskIterableEntity1._();
}

@ShouldThrow(
  'The TypeTemplate should contain 1 mask(s).',
  element: null,
)
@TypeTemplate('MyClass<String,*>')
@Modddel(validationSteps: noVSteps)
class NoMaskIterableEntity2 extends IterableEntity {
  NoMaskIterableEntity2._();

  factory NoMaskIterableEntity2() => NoMaskIterableEntity2._();
}

@ShouldThrow(
  'The TypeTemplate should contain 1 mask(s).',
  element: null,
)
@TypeTemplate('MyClass<#1,#2>')
@Modddel(validationSteps: noVSteps)
class TooManyMasksIterableEntity1 extends IterableEntity {
  TooManyMasksIterableEntity1._();

  factory TooManyMasksIterableEntity1() => TooManyMasksIterableEntity1._();
}

@ShouldThrow(
  'The TypeTemplate should contain 1 mask(s).',
  element: null,
)
@TypeTemplate('MyClass<#2,*,#1>')
@Modddel(validationSteps: noVSteps)
class TooManyMasksIterableEntity2 extends IterableEntity {
  TooManyMasksIterableEntity2._();

  factory TooManyMasksIterableEntity2() => TooManyMasksIterableEntity2._();
}

@ShouldThrow(
  'The TypeTemplate should contain 2 mask(s).',
  element: null,
)
@TypeTemplate('Map<String,String>')
@Modddel(validationSteps: noVSteps)
class NotEnoughMasksIterable2Entity1 extends Iterable2Entity {
  NotEnoughMasksIterable2Entity1._();

  factory NotEnoughMasksIterable2Entity1() =>
      NotEnoughMasksIterable2Entity1._();
}

@ShouldThrow(
  'The TypeTemplate should contain 2 mask(s).',
  element: null,
)
@TypeTemplate('MyClass<*,#1>')
@Modddel(validationSteps: noVSteps)
class NotEnoughMasksIterable2Entity2 extends Iterable2Entity {
  NotEnoughMasksIterable2Entity2._();

  factory NotEnoughMasksIterable2Entity2() =>
      NotEnoughMasksIterable2Entity2._();
}

@ShouldThrow(
  'The TypeTemplate should contain 2 mask(s).',
  element: null,
)
@TypeTemplate('MyClass<#1,#2,#3>')
@Modddel(validationSteps: noVSteps)
class TooManyMasksIterable2Entity1 extends Iterable2Entity {
  TooManyMasksIterable2Entity1._();

  factory TooManyMasksIterable2Entity1() => TooManyMasksIterable2Entity1._();
}

@ShouldThrow(
  'The TypeTemplate should contain 2 mask(s).',
  element: null,
)
@TypeTemplate('MyClass<#2,*,#1,#3>')
@Modddel(validationSteps: noVSteps)
class TooManyMasksIterable2Entity2 extends Iterable2Entity {
  TooManyMasksIterable2Entity2._();

  factory TooManyMasksIterable2Entity2() => TooManyMasksIterable2Entity2._();
}
