import 'package:intl_phone_field/phone_number.dart';

PhoneNumber convertToPhoneNumber(dynamic phoneDetails, dynamic country) {
  String isoCode = phoneDetails.substring(0, 3);
  String number = phoneDetails.substring(3, 13);
  PhoneNumber extractedPhoneNumber = PhoneNumber(
      countryISOCode: country,
      countryCode: isoCode,
      number: number);
  return extractedPhoneNumber;
}
