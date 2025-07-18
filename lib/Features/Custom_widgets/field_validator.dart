import 'package:flutter/material.dart';

class FieldValidator {
  BuildContext context;
  FieldValidator(this.context);
  String? nameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Name';
    } else {
      return null;
    }
  }

  String? emailValidate(String? value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.toString());
    if (value == null || value.isEmpty) {
      return 'Please Enter Email Address';
    } else if (!emailValid) {
      return 'Please Enter Valid Email Address';
    } else {
      return null;
    }
  }

  String? mobileValidate(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value == null || value.isEmpty) {
      return 'Please Enter Mobile Number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please Enter Valid Mobile Number';
    }
    return null;
  }

  String? passwordValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Password';
    } else if (value.length < 6) {
      return 'The password must be at least 6 characters.';
    } else {
      return null;
    }
  }

  String? confirmPasswordValidate1(String? value, String newPassword) {
    if (value == null || value.isEmpty) {
      return 'Please Enter confirm password';
    } else if (value.length < 6) {
      return 'The password must be at least 6 characters.';
    } else if (value != newPassword) {
      return 'Password and Confirm Password does not match';
    } else {
      return null;
    }
  }

  String? addressLine1(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please  Enter Address 1 Name';
    } else {
      return null;
    }
  }
   String? addressLine2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please  Enter Address 1 Name';
    } else {
      return null;
    }
  }

  String? postalCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Postal Code Name';
    } else if (value.length < 6) {
      return 'The password must be at least 6 characters.';
    } else {
      return null;
    }
  }

  String? area(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Area Name';
    } else {
      return null;
    }
  }

  String? flat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Flat Name';
    } else {
      return null;
    }
  }
  String? city(String? value){
    if(value ==null||value.isEmpty){
      return 'Please Enter City Name';
    }
    else {
      return null;
    }
  }
  String? state(String?value){
    if(value==null||value.isEmpty){
      return 'Please Enter State Name';
    }
    else {
      return null;
    }
  }
  String?country(String?value){
    if(value==null||value.isEmpty){
      return 'Please Enter Country Name';
    }
    else {
      return null;
    }
  }
  String?couponCode(String?value){
    if(value==null||value.isEmpty){
      return 'Please Enter Coupons/Promo Code';
    }
    else {
      return null;
    }
  }

//   String? name1Validate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Middle Name';
//     } else {
//       return null;
//     }
//   }
//   String? name3Validate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter  Name';
//     } else {
//       return null;
//     }
//   }
//   String? name2Validate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Last Name';
//     } else {
//       return null;
//     }
//   }
//   String? cnrValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter CNR Number';
//     }
//     else if (value.length < 16) {
//       return 'CNR Number must be at least 16';
//     }
//     else {
//       return null;
//     }
//   }
//   String? yearValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Year';
//     } else {
//       return null;
//     }
//   }
//   String? courtValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Court';
//     } else {
//       return null;
//     }
//   }
//   String? firstpartyValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter First Party';
//     } else {
//       return null;
//     }
//   }
//   String? oppositeValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Opposite Party';
//     } else {
//       return null;
//     }
//   }
//   String? typecaseValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Type Of Case';
//     } else {
//       return null;
//     }
//   }
//   String? undersectionValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Under Section';
//     } else {
//       return null;
//     }
//   }
//   String? firValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Fir Number';
//     } else {
//       return null;
//     }
//   }
//   String? commenteValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Comment';
//     } else {
//       return null;
//     }
//   }
//   String? referenceValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Reference';
//     } else {
//       return null;
//     }
//   }
//   String? casenumberValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Case Number';
//     } else {
//       return null;
//     }
//   }
//   String? courtnumberValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Court Number';
//     } else {
//       return null;
//     }
//   }
//   String? pscompanyValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter PS.Company';
//     } else {
//       return null;
//     }
//   }
//   String? fixedValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Fixed ';
//     } else {
//       return null;
//     }
//   }
//   String? judgeValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Judge';
//     } else {
//       return null;
//     }
//   }
//   String? enrollmentValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Enrollment No.';
//     } else {
//       return null;
//     }
//   }

//    String? officeNameValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Office Name';
//     } else {
//       return null;
//     }
//   }

//   String? mobileValidate(String? value) {
//     String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//     RegExp regExp = RegExp(patttern);
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Mobile Number';
//     } else if (!regExp.hasMatch(value)) {
//       return 'Please Enter Valid Mobile Number';
//     }
//     return null;
//   }

//   String? passwordValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Password';
//     } else if (value.length < 6) {
//       return 'The password must be at least 6 characters.';
//     } else {
//       return null;
//     }
//   }

//   String? oldPasswordValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Old Password';
//     } else if (value.length < 6) {
//       return 'The password must be at least 6 characters.';
//     } else {
//       return null;
//     }
//   }

//   String? newPasswordValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please New Password';
//     } else if (value.length < 6) {
//       return 'The password must be at least 6 characters.';
//     } else {
//       return null;
//     }
//   }

//   String? confirmPasswordValidate(String? value, String newPassword) {
//    if (value != newPassword) {
//       return 'New and Confirm Password does not match';
//     } else {
//       return null;
//     }
//   }

// String? confirmPasswordValidate1(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter confirm password';
//     } else if (value.length < 6) {
//       return 'The password must be at least 6 characters.';
//     } else {
//       return null;
//     }
//   }
//   String? emailValidate(String? value) {
//     bool emailValid = RegExp(
//             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//         .hasMatch(value.toString());
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Email Address';
//     } else if (!emailValid) {
//       return 'Please Enter Valid Email Address';
//     } else {
//       return null;
//     }
//   }

//   String? otpValidate(String? value) {
//     if (value!.length < 4) {
//       return 'Please Enter 4 Digit Valid OTP';
//     } else {
//       return null;
//     }
//   }

//    String? dairyNumber(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Dairy Number';
//     } else {
//       return null;
//     }
//   }
//   String? stage(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please Enter Stage';
//     } else {
//       return null;
//     }
//   }
}
