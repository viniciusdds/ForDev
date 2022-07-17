// @dart=2.9

abstract class FieldValidation {
  String get field;
  String validate(String value);
}