import 'package:example/modddels/age.dart';
import 'package:example/modddels/permissions.dart';
import 'package:example/modddels/username.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

part 'user.modddel.dart';

@Modddel(
  validationSteps: [
    ValidationStep([contentValidation])
  ],
  sharedProps: [
    SharedProp('Username', 'username'),
    SharedProp('Age', 'age'),
  ],
  generateTestClasses: true,
)
class User extends SimpleEntity<InvalidUser, ValidUser> with _$User {
  User._();

  factory User.appUser({
    required Username username,
    required Age age,
  }) {
    return _$User._createAppUser(
      username: username,
      age: age,
    );
  }

  factory User.moderator({
    required Username username,
    required Age age,
    required Permissions permissions,
  }) {
    return _$User._createModerator(
      username: username,
      age: age,
      permissions: permissions,
    );
  }
}
