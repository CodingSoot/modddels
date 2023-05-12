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
- 🧊 **Sealed class :** Your model is a sealed class, which union cases are the different states it can be (valid, invalid...). _For example, `Student` would be a sealed class with union-cases `ValidStudent` and `InvalidStudent`._
- 🚨 **Failures handling :** Your model, when invalid, holds the responsible failure(s), which you can access anytime anywhere.
- 🔒 **Value Equality and Immutability :** All models are immutable and override `operator ==` and `hashCode` for data equality.
- 🧪 **Unit-testing :** Easily test your models and the validation logic.

> **NB :** This package is NOT a data-class generator. It is meant to create models that are at the core of your app _(If you use DDD or Clean architecture, those would be in the "domain" layer)_. Therefore, you are meant to create separate classes for things like json serialization, either manually or with tools like [freezed](https://pub.dev/packages/freezed) and [json_serializable](https://pub.dev/packages/json_serializable) _(These classes are usually called "DataTransferObjects", "DTOs", or simply "models")_.

# Documentation

Check out [**modddels.dev**](https://www.modddels.dev/) for comprehensive documentation, examples, VS code snippets and more.

# Contributing

If you're interested in contributing, feel free to submit pull requests, report bugs, or suggest new features by creating an issue on the GitHub repository.

For those who want to dive deeper into the source code, you can refer to the [internal.md](https://github.com/CodingSoot/modddels/blob/master/docs/internal/internal.md) and [architecture.md](https://github.com/CodingSoot/modddels/blob/master/docs/internal/architecture.md) files to better understand the inner workings of the package.

# Sponsoring

Your support matters ! Help me continue working on my projects by [buying me a coffee](https://www.buymeacoffee.com/codingsoot). Thank you for your contribution !

<a href="https://www.buymeacoffee.com/codingsoot" target="_blank"><img src="https://raw.githubusercontent.com/CodingSoot/modddels/master/resources/images/buymeacoffee.svg" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

![sponsors](https://raw.githubusercontent.com/CodingSoot/modddels/master/resources/images/Sponsors%20list.png)
