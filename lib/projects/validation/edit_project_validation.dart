

String? joinCodeFieldValidation(String? value) {

    if (value == null || value == "") {
        return "Join code can not be empty";
    } 
    else if (value.length < 6) {
        return "Join code must be 6 or more characters";
    }
    else if (value.length > 10) {
        return "Join code must be 10 or less characters";
    }

    bool? regexOutcome = regexJoinCodeField(value);

    if (regexOutcome == true) {
        return null;
    } 
    else {
        return "It must contain at least one number or symbol";
    }

}

bool? regexJoinCodeField(String value)  {
    RegExp regex = RegExp("[0-9.@!]");
    bool? regMatches = regex.hasMatch(value);


    //temp
    return regMatches;

}

/* 

*/
String? projectNameFieldValidation(String? value) {

    if (value == "" || value == null) {
        return "Project name must not be empty";
    }
    else if (value.length > 50) {
        return "Project name must be 50 or less characters";
    }
    else {
        return null;
    }

}