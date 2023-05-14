import 'package:example/modddels/age.dart';
import 'package:example/modddels/user.dart';
import 'package:example/modddels/username.dart';

// In this example, [Username], [Age] and [User] are all "modddels".
void main() {
  final username =
      Username('dash_the_bird', availabilityService: MyAvailabilityService());

  final age = Age(20);

  final user = User.appUser(username: username, age: age);

  // Map over the different validation states of the user.
  user.map(
    valid: (valid) => greetUser(valid),
    invalidMid: (invalidMid) => redirectToProfileInfoScreen(invalidMid),
  );
}

// This method can only accept a [ValidUser], i.e a valid instance of [User].
void greetUser(ValidUser user) {
  final username = user.username.value;

  // Map over the different types of users ([AppUser] or [Moderator])
  final greeting = user.mapUser(
      appUser: (validAppUser) => 'Hey $username ! Enjoy our app.',
      moderator: (validModerator) =>
          'Hello $username ! Thanks for being a great moderator.');

  print(greeting);
}

// This method can only accept an [InvalidUserMid], i.e an invalid instance of
// [User] specifically because of a failure in the validationStep named "mid".
void redirectToProfileInfoScreen(InvalidUserMid user) {
  print('Redirecting to profile ...');

  // Checking if the `age` is invalid, and handling the only possible failure.
  user.age.mapOrNull(
    invalidValue: (invalidAgeValue) => invalidAgeValue.legalFailure.map(
      minor: (_) => print('You should be 18 to use our app.'),
    ),
  );

  // Checking if the `username` is invalid, and handling its possible failures.
  user.username.map(
    valid: (validUsername) {},
    invalidValue1: (invalidUsernameValue1) {
      // Handling failures of the "length" validation.
      if (invalidUsernameValue1.hasLengthFailure) {
        final errorMessage = invalidUsernameValue1.lengthFailure!.map(
          empty: (value) => 'Username can\'t be empty.',
          tooShort: (value) =>
              'Username must be at least ${value.minLength} characters long.',
          tooLong: (value) =>
              'Username must be less than ${value.maxLength} characters long.',
        );
        print(errorMessage);
      }

      // Handling failures of the "characters" validation.
      if (invalidUsernameValue1.hasCharactersFailure) {
        final errorMessage = invalidUsernameValue1.charactersFailure!.map(
          hasWhiteSpace: (hasWhiteSpace) =>
              'Username can\'t contain any whitespace character.',
          hasSpecialCharacters: (hasSpecialCharacters) =>
              'Username can only contain letters, numbers and dashes.',
        );
        print(errorMessage);
      }
    },
    invalidValue2: (invalidUsernameValue2) {
      // Handling failures of the "availability" validation. This validation is
      // part of a separate validationStep than the two previous ones for
      // optimization purposes.
      final errorMessage = invalidUsernameValue2.availabilityFailure.map(
        unavailable: (unavailable) => 'Username is already taken.',
      );

      print(errorMessage);
    },
  );
}
