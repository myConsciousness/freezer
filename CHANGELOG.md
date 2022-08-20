# Release Note

## v0.4.0

- Supported Enum generating and mapping from JSON file. ([#6](https://github.com/myConsciousness/freezer/issues/6))
- Improved `README.md`. ([#29](https://github.com/myConsciousness/freezer/issues/29))

## v0.3.0

- Supported not nested list structure like `List<String>`. This will automatically perform type identification when the generator is executed. However, be sure to include values of a specific type in the list defined in the JSON file. ([#7](https://github.com/myConsciousness/freezer/issues/7))

## v0.2.0

- For future extensibility, fixed the specification of the `!as:` identifier. From this version, this identifier should specify **the name of the file to be generated**. The file name of the snake case specified by this identifier is converted to a camel case class name at runtime. ([#12](https://github.com/myConsciousness/freezer/issues/12))
- Added the `.!name:` identifier to specify the name of the field. `@JsonKey` will be used if this identifier is specified. ([#13](https://github.com/myConsciousness/freezer/issues/13))
- Fixed to ignore warnings when `@JsonKey` is used for a field. ([#11](https://github.com/myConsciousness/freezer/issues/11))

## v0.1.0

- Supported DartDoc for class object and field. ([#9](https://github.com/myConsciousness/freezer/issues/9))

## v0.0.2

- Fixed entry file name from `freezer.dart` to `main.dart`.

## v0.0.1

- First Release.
