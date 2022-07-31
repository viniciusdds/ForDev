// @dart=2.9

import 'package:test/test.dart';

import 'package:fordev/validation/protocols/field_validation.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String value){
    return null;
  }
}


void main(){
  EmailValidation sut;

  setUp((){
     sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', (){
      expect(sut.validate(''), null);
  });

  test('Should return null if email is null', (){
    expect(sut.validate(null), null);
  });
}