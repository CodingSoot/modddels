import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'age.modddel.dart';
part 'age.freezed.dart';

@Modddel(
  validationSteps: [
    ValidationStep([Validation('legal', FailureType<AgeLegalFailure>())]),
  ],
  generateTestClasses: true,
)
class Age extends SingleValueObject<InvalidAge, ValidAge> with _$Age {
  Age._();

  factory Age(int value) {
    return _$Age._create(
      value: value,
    );
  }

  @override
  Option<AgeLegalFailure> validateLegal(age) {
    if (age.value < 18) {
      return some(const AgeLegalFailure.minor());
    }
    return none();
  }
}

@freezed
class AgeLegalFailure extends ValueFailure with _$AgeLegalFailure {
  const factory AgeLegalFailure.minor() = _Minor;
}
