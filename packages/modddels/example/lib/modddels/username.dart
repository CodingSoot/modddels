import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

part 'username.freezed.dart';
part 'username.modddel.dart';

@Modddel(validationSteps: [
  ValidationStep([
    Validation('length', FailureType<UsernameLengthFailure>()),
    Validation('characters', FailureType<UsernameCharactersFailure>())
  ]),
  ValidationStep(
      [Validation('availability', FailureType<UsernameAvailabilityFailure>())])
])
class Username extends SingleValueObject<InvalidUsername, ValidUsername>
    with _$Username {
  Username._();

  factory Username(
    String value, {
    @dependencyParam required MyAvailabilityService availabilityService,
  }) {
    final sanitizedValue = value.trim();

    return _$Username._create(
      value: sanitizedValue,
      availabilityService: availabilityService,
    );
  }

  static const minLength = 5;

  static const maxLength = 20;

  static final _validCharactersRegex = RegExp(r'^[a-zA-Z0-9_]+$');

  @override
  Option<UsernameLengthFailure> validateLength(username) {
    if (username.value.isEmpty) {
      return some(UsernameLengthFailure.empty());
    }
    if (username.value.length < minLength) {
      return some(UsernameLengthFailure.tooShort(minLength: minLength));
    }
    if (username.value.length > maxLength) {
      return some(UsernameLengthFailure.tooLong(maxLength: maxLength));
    }
    return none();
  }

  @override
  Option<UsernameCharactersFailure> validateCharacters(username) {
    if (username.value.contains(RegExp(r'\s'))) {
      return some(UsernameCharactersFailure.hasWhiteSpace());
    }

    if (!_validCharactersRegex.hasMatch(username.value)) {
      return some(UsernameCharactersFailure.hasSpecialCharacters());
    }
    return none();
  }

  @override
  Option<UsernameAvailabilityFailure> validateAvailability(username) {
    final isAvailable =
        username.availabilityService.checkUsernameIsAvailable(username.value);

    return isAvailable
        ? none()
        : some(UsernameAvailabilityFailure.unavailable());
  }
}

@freezed
class UsernameLengthFailure extends ValueFailure with _$UsernameLengthFailure {
  const factory UsernameLengthFailure.empty() = _Empty;

  const factory UsernameLengthFailure.tooShort({required int minLength}) =
      _TooShort;

  const factory UsernameLengthFailure.tooLong({required int maxLength}) =
      _TooLong;
}

@freezed
class UsernameCharactersFailure extends ValueFailure
    with _$UsernameCharactersFailure {
  const factory UsernameCharactersFailure.hasWhiteSpace() = _HasWhiteSpace;
  const factory UsernameCharactersFailure.hasSpecialCharacters() =
      _HasSpecialCharacters;
}

@freezed
class UsernameAvailabilityFailure extends ValueFailure
    with _$UsernameAvailabilityFailure {
  const factory UsernameAvailabilityFailure.unavailable() = _Unavailable;
}

class MyAvailabilityService {
  bool checkUsernameIsAvailable(String username) {
    return true;
  }
}
