import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

part 'permissions.freezed.dart';
part 'permissions.modddel.dart';

@Modddel(validationSteps: [
  ValidationStep(
      [Validation('conflict', FailureType<PermissionsConflictFailure>())])
])
class Permissions extends MultiValueObject<InvalidPermissions, ValidPermissions>
    with _$Permissions {
  Permissions._();

  factory Permissions({
    required bool canViewUserList,
    required bool canBanUsers,
  }) {
    return _$Permissions._create(
      canViewUserList: canViewUserList,
      canBanUsers: canBanUsers,
    );
  }

  @override
  Option<PermissionsConflictFailure> validateConflict(permissions) {
    if (permissions.canBanUsers && !permissions.canViewUserList) {
      return some(PermissionsConflictFailure.accessConflict());
    }
    return none();
  }
}

@freezed
class PermissionsConflictFailure extends ValueFailure
    with _$PermissionsConflictFailure {
  const factory PermissionsConflictFailure.accessConflict() = _AccessConflict;
}
