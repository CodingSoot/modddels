[![Build](https://github.com/CodingSoot/modddels/actions/workflows/build.yml/badge.svg)](https://github.com/CodingSoot/modddels/actions/workflows/build.yml)
[![pub package](https://img.shields.io/pub/v/modddels.svg)](https://pub.dartlang.org/packages/modddels)

![banner](https://raw.githubusercontent.com/CodingSoot/modddels/master/resources/images/Modddels%20banner%20-%20light.png)

**Introducing MODDDELS:** A powerful code generator that allows you to create self-validated models with compile-safe states, seamless failure handling, and easy unit-testing.

# Motivation

Let's say you want to model a `Student` object. The `Student` has a name, an age, and an email. You may create your class/data-class this way :

```dart
class Student {
  Student({
    required this.name,
    required this.age,
    required this.email,
  });

  final String name;
  final int age;
  final String email;
}
```

You will then need to validate the `name`, `age` and `email` in various parts of your app. The `Student` model will be used in different places : for example, a widget that displays a student profile, or a function `addStudent(Student newStudent)`, etc...

**There are several problems with this approach :**

- Where should you validate the `name`, `age` and `email` ?
- After validation is done, how can you distinguish between a valid `Student` instance and an invalid one ?
- How can you ensure that valid `Student` instances are passed to functions or widgets that require them, and likewise, invalid instances are passed to those that specifically handle them?
- How to handle an invalid `Student` differently based on what field is invalid and why it's invalid, all this in various parts of the app ?
- If you have, for example, a widget that displays the `email` of a `Student`. How can you prevent any random string from being passed to the widget ?

**All these problems (and more) can be resolved by using this package.**

![meme](https://raw.githubusercontent.com/CodingSoot/modddels/master/resources/images/Meme.jpg)

The **_Modddels_** package offers a way to validate your models and deal with its different states (valid, invalid...) in a _type-safe_ and _compile-safe_ way.

- 🔎 **Self-Validation :** Your models are validated upon creation. This way, you'll never deal with non-validated models.
- 🧊 **Sealed class :** Your model is a sealed class (compatible with previous versions of Dart) which has union-cases for the different states it can be in (valid, invalid...). _For example, `Student` would be a sealed class with union-cases `ValidStudent` and `InvalidStudent`._
- 🚨 **Failures handling :** Your model, when invalid, holds the responsible failure(s), which you can access anytime anywhere.
- 🔒 **Value Equality and Immutability :** All models are immutable and override `operator ==` and `hashCode` for data equality.
- 🧪 **Unit-testing :** Easily test your models and the validation logic.

> **NB :** This package is NOT a data-class generator. It is meant to create models that are at the core of your app _(If you use DDD or Clean architecture, those would be in the "domain" layer)_. Therefore, you are meant to create separate classes for things like json serialization, either manually or with tools like [freezed](https://pub.dev/packages/freezed) and [json_serializable](https://pub.dev/packages/json_serializable) _(These classes are usually called "DataTransferObjects", "DTOs", or simply "models")_.

# Documentation

Check out [**modddels.dev**](https://www.modddels.dev/) for comprehensive documentation, examples, VS code snippets and more.

# Example

Here is a sneak peek at what you can do with **modddels**. You can find the full example in the [`example` folder](https://github.com/CodingSoot/modddels/tree/master/packages/modddels/example).

```dart
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
```

# Contributing

If you're interested in contributing, feel free to submit pull requests, report bugs, or suggest new features by creating an issue on the GitHub repository.

For those who want to dive deeper into the source code, you can refer to the [internal.md](https://github.com/CodingSoot/modddels/blob/master/docs/internal/internal.md) and [architecture.md](https://github.com/CodingSoot/modddels/blob/master/docs/internal/architecture.md) files to better understand the inner workings of the package.

# Sponsoring

Your support matters ! Help me continue working on my projects by [buying me a coffee](https://www.buymeacoffee.com/codingsoot). Thank you for your contribution !

<a href="https://www.buymeacoffee.com/codingsoot" target="_blank"><img src="https://raw.githubusercontent.com/CodingSoot/modddels/master/resources/images/buymeacoffee.png" alt="Buy Me A Coffee" style="height: 42px !important;width: 171px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

![sponsors](https://raw.githubusercontent.com/CodingSoot/modddels/master/resources/images/Sponsors%20list.png)
