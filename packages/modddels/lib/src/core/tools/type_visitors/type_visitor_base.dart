import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_visitor.dart';
import 'package:modddels/src/core/tools/element.dart';
import 'package:modddels/src/core/tools/type_visitors/invalid_type_exception.dart';

extension DartTypeX on DartType {
  /// Whether this type is a type alias (= declared with typedef).
  ///
  bool get isTypeAlias => alias != null;
}

/// If [invalidTypeThrows] is true, throws an [InvalidTypeException] if an
/// [InvalidType] is encountered. Otherwise, the [InvalidType] is considered as
/// a [DynamicType].
///
abstract class BaseStringTypeVisitor extends TypeVisitor<String> {
  /// The origin library where the [DartType] is used. This is mainly used for
  /// the [DartTypeStringBuilder.writePrefix] method.
  ///
  LibraryElement get originLibrary;

  /// Whether encountering an [InvalidType] throws an [InvalidTypeException], or
  /// it is considered as a [DynamicType].
  bool get invalidTypeThrows;

  /// Creates a new instance of this type visitor.
  ///
  BaseStringTypeVisitor newInstance();

  @override
  String visitInvalidType(InvalidType type) {
    if (invalidTypeThrows) {
      throw InvalidTypeException();
    }
    return 'dynamic';
  }

  @override
  String visitDynamicType(DynamicType type) {
    return 'dynamic';
  }

  @override
  String visitFunctionType(FunctionType type) {
    final buffer = DartTypeStringBuilder(originLibrary, newInstance);

    buffer.writeType(type.returnType);
    buffer.write(' Function');
    buffer.writeTypeParameters(type.typeFormals);
    buffer.writeFunctionParameters(type.parameters);
    buffer.writeNullability(type.nullabilitySuffix);

    return buffer.toString();
  }

  @override
  String visitInterfaceType(InterfaceType type) {
    final buffer = DartTypeStringBuilder(originLibrary, newInstance);

    buffer.writePrefix(type.element);
    buffer.write(type.element.name);
    buffer.writeTypeArguments(type.typeArguments);
    buffer.writeNullability(type.nullabilitySuffix);

    return buffer.toString();
  }

  @override
  String visitNeverType(NeverType type) {
    final buffer = DartTypeStringBuilder(originLibrary, newInstance);

    buffer.write('Never');
    buffer.writeNullability(type.nullabilitySuffix);

    return buffer.toString();
  }

  @override
  String visitTypeParameterType(TypeParameterType type) {
    final buffer = DartTypeStringBuilder(originLibrary, newInstance);

    buffer.writePrefix(type.element);
    buffer.write(type.element.name);
    buffer.writeNullability(type.nullabilitySuffix);

    return buffer.toString();
  }

  @override
  String visitVoidType(VoidType type) {
    return 'void';
  }

  @override
  String visitRecordType(RecordType type) {
    // TODO: implement Record types once they are fully supported.
    throw UnimplementedError('Record types are not implemented yet');
  }
}

/// This is a StringBuilder to help make Strings that represent the declaration
/// code of a [DartType].
///
/// This is inspired by the class "ElementDisplayStringBuilder" in the analyzer
/// package.
///
class DartTypeStringBuilder {
  DartTypeStringBuilder(this.originLibrary, this.newTypeVisitorInstance);

  /// The origin library where the [DartType] is used. This is mainly used for
  /// the [writePrefix] method.
  ///
  final LibraryElement originLibrary;

  /// The constructor of the [BaseStringTypeVisitor] that will be used for
  /// constructing the String of a type (via the [writeType] method).
  ///
  final BaseStringTypeVisitor Function() newTypeVisitorInstance;

  final StringBuffer _buffer = StringBuffer();

  @override
  String toString() {
    return _buffer.toString();
  }

  /// Writes the [string].
  ///
  void write(String string) {
    _buffer.write(string);
  }

  /// Writes the string matching the [nullabilitySuffix].
  ///
  void writeNullability(NullabilitySuffix nullabilitySuffix) {
    if (nullabilitySuffix == NullabilitySuffix.question) {
      write('?');
    }
  }

  /// Writes the string representing [type], using the typeVisitor made with
  /// [newTypeVisitorInstance].
  ///
  void writeType(DartType type) {
    write(type.accept(newTypeVisitorInstance()));
  }

  /// Writes the string representing the [typeArguments].
  ///
  /// For example : '<String, Car>'
  ///
  /// NB : A type parameter is the blueprint or placeholder for a type declared
  /// in generic. A type argument is the actual type used to parametrize
  /// the generic.
  ///
  void writeTypeArguments(List<DartType> typeArguments) {
    if (typeArguments.isEmpty) {
      return;
    }

    // TODO : We could optionally skip writing type arguments if they're all
    // dynamic. For now we'll just write them all.

    write('<');
    for (var i = 0; i < typeArguments.length; i++) {
      if (i != 0) {
        write(', ');
      }
      writeType(typeArguments[i]);
    }
    write('>');
  }

  /// Writes the string representing the [typeParameter].
  ///
  /// For example : 'T extends List<String>'
  ///
  /// NB : A type parameter is the blueprint or placeholder for a type declared
  /// in generic. A type argument is the actual type used to parametrize
  /// the generic.
  ///
  void writeTypeParameter(TypeParameterElement typeParameter) {
    // We're ignoring the type parameter's variance since it's still
    // experimental, and not accessible from [TypeParameterElement].
    //
    // For more info about variance, see :
    // https://medium.com/dartlang/dart-declaration-site-variance-5c0e9c5f18a5

    write(typeParameter.name);

    var bound = typeParameter.bound;
    if (bound != null) {
      write(' extends ');
      writeType(bound);
    }
  }

  /// Writes the string representing the [typeParameters].
  ///
  /// For example : '<T extends List<String>, V>'
  ///
  /// NB : A type parameter is the blueprint or placeholder for a type declared
  /// in generic. A type argument is the actual type used to parametrize
  /// the generic.
  ///
  void writeTypeParameters(List<TypeParameterElement> typeParameters) {
    if (typeParameters.isEmpty) return;

    write('<');
    for (var i = 0; i < typeParameters.length; i++) {
      if (i != 0) {
        write(', ');
      }
      writeTypeParameter(typeParameters[i]);
    }
    write('>');
  }

  /// Writes the string representing the [parameter] of a [FunctionType].
  ///
  /// Example : 'String text' or 'required Car car'
  ///
  /// NB : Parameters in a function type can't have a default value, so it's
  /// always omitted.
  ///
  void writeFunctionParameter(ParameterElement parameter) {
    if (parameter.isRequiredNamed) {
      write('required ');
    }

    writeType(
      parameter.type,
    );

    // The name of a functionType's parameter can be empty.
    // For example : 'void Function(String, int)'
    if (parameter.name.isNotEmpty) {
      write(' ');
      write(parameter.name);
    }
  }

  /// Writes the string representing the [parameters] of a [FunctionType].
  ///
  /// Example : '(String text, {required Car car})'
  ///
  /// NB : Parameters in a function type can't have a default value, so it's
  /// always omitted.
  ///
  void writeFunctionParameters(List<ParameterElement> parameters) {
    var separator = ', ';

    write('(');

    _WriteFunctionParameterKind? lastKind;
    var lastClose = '';

    void openGroup(
        _WriteFunctionParameterKind kind, String open, String close) {
      if (lastKind != kind) {
        write(lastClose);
        write(open);
        lastKind = kind;
        lastClose = close;
      }
    }

    for (var i = 0; i < parameters.length; i++) {
      if (i != 0) {
        write(separator);
      }

      var parameter = parameters[i];
      if (parameter.isRequiredPositional) {
        openGroup(_WriteFunctionParameterKind.requiredPositional, '', '');
      } else if (parameter.isOptionalPositional) {
        openGroup(_WriteFunctionParameterKind.optionalPositional, '[', ']');
      } else if (parameter.isNamed) {
        openGroup(_WriteFunctionParameterKind.named, '{', '}');
      }

      writeFunctionParameter(parameter);
    }
    write(lastClose);
    write(')');
  }

  /// Writes the prefix (= import alias) that the [element] of the type has in
  /// the [originLibrary] (If any).
  ///
  /// The only types that have an associated element, and thus that can have a
  /// prefix, are [TypeParameterType] and [InterfaceType].
  ///
  void writePrefix(Element element) {
    final prefix = getPrefix(originLibrary, element);
    if (prefix != null) {
      write('${prefix.name}.');
    }
  }
}

/// The three kinds of Function parameters which have different opening and
/// closing characters.
///
enum _WriteFunctionParameterKind {
  requiredPositional,
  optionalPositional,
  named,
}
