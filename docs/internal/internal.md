
# Terminology

- **IterablesEntity :** General term that includes both IterableEntity and Iterable2Entity
- **A modddel type :** In an Entity, a member parameter can either be a modddel (SimpleEntity), or a collection of modddels (IterableEntity / Iterable2Entity). We call a "modddel type" the type of the modddel(s) represented by a member parameter of an Entity.
  
  Let's take these member parameters as examples :
  - For a SimpleEntity that has the member parameter `Age age` : The modddel type of this parameter is `Age`.
  - For a ListEntity that has the member parameter `List<Name> name` : The modddel type is `Name`.
  - For a MapEntity that has the member parameter `Map<Username, Age> ageMap` : The modddel types are `Username` and `Age`.

- **Shared Parameter = Shared property :** Every parameter maps to a property, so both terms are used interchangeably.
- Prefer using the compound **validationStep** instead of **validation step**.
- **Param transformation :** Short form = "transformation"
- **Super-sealed :** Describes a sealed class that has multiple modddels as union-cases (these are called **"case-modddels"**). Abreviation is "ssealed". When not specifying which class we're talking about, we often refer to the annotated super-sealed class (Example : SSealedClassInfo - ssealedClassName - the 'ssealed' folders...).
- We refer to the class annotated with '@Modddel' as the 'annotated class'. It can either be **super-sealed** or **solo** :
  - Annotated super-sealed class : Contains multiple union-cases called **case-modddels**, each one being a **modddel**.
  - Annotated solo class : Represents a single **modddel**
  
  As a result, when using the term "modddel" (Ex : ModddelClassInfo, ValidModddelTemplate...), it can refer to either an annotated super-sealed class's case-modddel, or the annotated solo class itself.
- There are two kinds of pattern matching methods :
  - **Validness pattern matching :** Pattern matching between the different union-cases that represent the "validness" state of a modddel (or of the annotated ssealed class) : Valid, Invalid, etc...

    Example : `map`, `maybeMap`, `mapInvalid`...

  - **Modddel pattern matching :** Also called "Case-modddels pattern matching". Pattern matching between the different case-modddels of a ssealed class.

    Example : `mapWeather`, `maybeMapWeather`...

# Packages structure

Code generators typically consist of two packages, such as "freezed" and "freezed_annotation":

- The primary package (like "freezed") contains the code generation logic and tools needed to process annotated elements. This package is added in the developer's project as a dev dependency because it is required only during development and code generation.
- The accompanying package (like "freezed_annotation") contains the annotations and helper classes for annotating and configuring elements in the developer's code to be processed by the code generator. This lightweight package has fewer dependencies and is added as a regular dependency in the developer's project.

In our case, the classes that you extend to create a modddel (`SingleValueObject`, `IterableEntity`...), their superclasses, as well as the unit-testing classes, they all depend on a functional programming package (fpdart or dartz). To support both functional programming packages, we split the accompanying package into two:

- `modddels_annotation_fpdart` : For developers using "fpdart"
- `modddels_annotation_dartz` : For developers using "dartz"

In order to have a single generator compatible with both packages, and minimize duplicated code, we added a third **internal** package : `modddels_annotation_internal`. This package contains all the annotations required for the code generator to work, as well as other elements that do not depend on the functional programming package. It is intended for internal use only and should not be imported by developers.

The primary package, `modddels`, depends only on `modddels_annotation_internal` and generates the same code regardless of whether developers use `modddels_annotation_fpdart` or `modddels_annotation_dartz`. To ensure compatibility between the two functional programming packages, we use extensions.

## Dartz & FpDart Compatibility

**For `Either`**:

- Same syntax between fpdart and dartz :
  - `Either<L,R>` type
  - `left<L,R>()` function
  - `right<L,R>()` function
  - `fold` method

- Added to Dartz via extensions
  - `getLeft` method

**For `Option`**:

- Same syntax between fpdart and dartz :
  - `Option<A>` type
  - `toNullable()` method

**For `Tuple2`**:

- Same syntax between fpdart and dartz :
  - `Tuple2<T1,T2>` type

- Added to Dartz via extensions
  - `Tuple2.first` getter
  - `Tuple2.second` getter

# Folder Structure

- `core` : This folder contains the core components of the package :
  - `identifiers` : Contains classes for the identifiers (class names, method names...) needed in the generated code.
  - `info` : Contains classes that store information about various aspects of the modddel / annotated ssealed class :
    - `class_info` : Information about the class (modddel or ssealed), such as identifiers and constructor details.
    - `parameter_type_info` : Information about the types of the factory parameters
    - `parameters_info` : Information about the factory parameters
    - `validation_info` : Information about the validation aspect of the modddel / annotated ssealed class.
  - `parsed_annotations` : Contains classes that represent the parsed annotations like `@Modddel`, `@NullFailure`...
  - `templates` : Contains templates for generic reusable elements such as arguments, parameters, class members...
  - `tools` : Contains various utilities.
- `generation_templates` : Contains templates of chunks of the generated file such as mixins, classes... These are explored in detail in [`architecture.md`](architecture.md).
- `generators` : Contains the code generators for the different modddel kinds.

> **NB 1 :** Frequently, you will notice that a folder has two subfolders named "modddel" and "ssealed." This is done to appropriately organize and separate the code related to modddels and annotated super-sealed classes.
>
> **NB 2 :** In the `info` subfolders, we use "Resolvers". A resolver is a class responsible for validating, transforming and organizing input data (elements from the annotated class) into the a specific output (the "info"), through a factory constructor called "resolve".

# Style guide

- Nested comments such as comments inside a function start with '//'.
- "Private files", a.k.a files that are only meant to be accessed in their directory (including subdirectories), have names that start with "_".
- For documentation, avoid broad terms. For example :
  - Instead of "corresponds to", use : "consists of", "represents", "matches", "is related to", "equals"...
