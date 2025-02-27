import "input_field_containers.dart";
// validates the email input box
String? emailInputValidator(String value) {
  if (value.isEmpty) {
    return "Can not leave this field empty";
  }
  return null;
}

// validates the password input box
String? passwordInputValidator(String value) {
  if (value.isEmpty) {
    return "Can not leave this field empty";
  }
  else if (value.length < 8) {
    return "less than 8 characters";
  }
  // need to add condition using regex to check for digits and special characters
  // refer to iteration 1 for more detail
  return null;
}

// validates the username input box
String? usernameInputValidator(String value) {
  if (value.isEmpty) {
    return "Can not leave this field empty";
  }
  return null;
}