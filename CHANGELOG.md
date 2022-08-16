# Release Note

## v0.2.0

- For future extensibility, fixed the specification of the `!as:` identifier. From this version, this identifier should specify **the name of the file to be generated**. The file name of the snake case specified by this identifier is converted to a camel case class name at runtime. ([#12](https://github.com/myConsciousness/freezer/issues/12))
- Fixed to ignore warnings when `@JsonKey` is used for a field. ([#11](https://github.com/myConsciousness/freezer/issues/11))

## v0.1.0

- Supported DartDoc for class object and field. ([#9](https://github.com/myConsciousness/freezer/issues/9))

## v0.0.2

- Fixed entry file name from `freezer.dart` to `main.dart`.

## v0.0.1

- First Release.
