import 'package:example/modddels/age.dart';
import 'package:example/modddels/user.dart';
import 'package:example/modddels/username.dart';

void main() {
  final username =
      Username('dash_the_bird', availabilityService: MyAvailabilityService());

  final age = Age(20);

  final user = User.appUser(username: username, age: age);

  user.map(
    valid: (valid) => greetUser(valid),
    invalidMid: (invalidMid) => redirectToProfileInfoScreen(invalidMid),
  );
}

void greetUser(ValidUser user) {
  final username = user.username.value;

  final greeting = user.mapUser(
      appUser: (validAppUser) => 'Hey $username ! Enjoy our app.',
      moderator: (validModerator) =>
          'Hello $username ! Thanks for being a great moderator.');

  print(greeting);
}

void redirectToProfileInfoScreen(InvalidUserMid user) {
  print('Redirecting to profile ...');

  user.age.mapOrNull(
    invalidValue: (invalidAgeValue) => invalidAgeValue.legalFailure.map(
      minor: (_) => print('You should be 18 to use our app.'),
    ),
  );

  user.username.map(
    valid: (validUsername) {},
    invalidValue1: (invalidUsernameValue1) {
      if (invalidUsernameValue1.hasLengthFailure) {
        final errorMessage = invalidUsernameValue1.lengthFailure!.map(
          empty: (value) => 'The username can\'t be empty.',
          tooShort: (value) =>
              'The username must be at least ${value.minLength} characters long.',
          tooLong: (value) =>
              'The username must be less than ${value.maxLength} characters long.',
        );
        print(errorMessage);
      }

      if (invalidUsernameValue1.hasCharactersFailure) {
        final errorMessage = invalidUsernameValue1.charactersFailure!.map(
          hasWhiteSpace: (hasWhiteSpace) =>
              'The username can\'t contain any whitespace character.',
          hasSpecialCharacters: (hasSpecialCharacters) =>
              'The username can only contain letters, numbers and dashes.',
        );
        print(errorMessage);
      }
    },
    invalidValue2: (invalidUsernameValue2) {
      final errorMessage = invalidUsernameValue2.availabilityFailure.map(
        unavailable: (unavailable) => 'The username is already taken.',
      );

      print(errorMessage);
    },
  );
}
