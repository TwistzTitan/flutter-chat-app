import 'package:flutter_test/flutter_test.dart';
import 'package:flash_chat/controllers/validator.dart';

void main(){
  group('Validate the email and password fillment',(){
      test('Return false if email is empty', () {
        String email = '';
        String password = '123546';
        expect(ValidatorEmailPassword(email,password).validar(),false);
      });

      test('Return false if email is null', () {
        String email = null;
        String password ='134567';
        expect(ValidatorEmailPassword(email,password).validar(),false);
      });
      test('Return false if password is empty', () {
        String email = 'exemplo@email.com.br';
        String password = '';
        expect(ValidatorEmailPassword(email,password).validar(),false);
      });

      test('Return false if password is null', () {
        String email = 'exemplo@email.com.br';
        String password = null;
        expect(ValidatorEmailPassword(email,password).validar(),false);
      });
      test('Return false if password lenght is less than 5 characters', () {
        String email = 'exemplo@email.com.br';
        String password = '1234';
        expect(ValidatorEmailPassword(email,password).validar(),false);
      });
      test('Return false if password is correct but email is null', () {
        String email = null;
        String password = '123456';
        expect(ValidatorEmailPassword(email,password).validar(),false);
      });
      test('Return true if password is bigger than 5 characters and email aren\'t empty ', () {
        String email = 'exemplo@email.com.br';
        String password = '123456';
        expect(ValidatorEmailPassword(email,password).validar(),true);
      });
  });
}