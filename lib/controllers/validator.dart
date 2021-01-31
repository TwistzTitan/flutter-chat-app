abstract class Validator {
  bool validar();
}

class ValidatorEmailPassword extends Validator{
  String _email;
  String _password;
  ValidatorEmailPassword(String email, String pass){
    _email = email;
    _password = pass;
  }
  @override
  bool validar(){
    if((_email == null) || (_password == null)){
      return false;
    }
    else if(_email.isEmpty || _password.isEmpty){
      return false;
    }
    else if (_password.length < 5){
      return false;
    }
    return true;
  }

}
