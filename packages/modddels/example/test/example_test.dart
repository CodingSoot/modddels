import 'package:example/modddels/age.dart';
import 'package:example/modddels/user.dart';
import 'package:example/modddels/username.dart';
import 'package:modddels_annotation_fpdart/modddels_annotation_fpdart.dart';

void main() {
  group('Age tests :', () {
    final testAge = TestAge();

    testAge.isValid(AgeParams(18));

    testAge.isValid(AgeParams(26));

    testAge.isInvalidValue(AgeParams(6), legalFailure: AgeLegalFailure.minor());

    testAge.isInvalidValue(AgeParams(17),
        legalFailure: AgeLegalFailure.minor());
  });

  group('User tests :', () {
    final testUser = TestUser();

    testUser.isValid(
      UserParams.appUser(
          username: Username('dash_the_bird',
              availabilityService: MyAvailabilityService()),
          age: Age(18)),
    );

    testUser.isInvalidMid(
        UserParams.appUser(
          username: Username('dash_the_bird',
              availabilityService: MyAvailabilityService()),
          age: Age(5),
        ),
        contentFailure: ContentFailure([
          ModddelInvalidMember(
            member: Age(5) as InvalidAgeValue,
            description: 'age',
          )
        ]));
  });
}
