class Validation{
  static String? validationFunction(String value){
    if(value == ''){
      return 'Field is empty.';
    }

    if(int.parse(value) > 100){
      return "Number can't be greater than 100.";
    }

    return null;
  }
}
