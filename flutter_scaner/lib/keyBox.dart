import 'package:crypto/crypto.dart';
import 'dart:convert' show utf8;
import 'package:encrypt/encrypt.dart';

class encryptModule {
  String? schoolKey;
  var encrypter;
  var iv = IV.fromLength(16);

  encryptModule();
  void registerKey(String plainText) {
    var bytes = utf8.encode(plainText);
    var digest = sha256.convert(bytes);
    schoolKey = digest.toString().substring(5, 29);
    encrypter = Encrypter(AES(Key.fromUtf8(schoolKey!), padding: null));
  }

  String encryptText(String plainText) {
    if (schoolKey!.isNotEmpty) {
      return encrypter.encrypt(plainText, iv: iv).base64 +
          schoolKey!.substring(0, 5);
    }
    return "";
  }

  String decryptText(String plainText) {
    if (schoolKey!.isNotEmpty && plainText != "") {
      if (plainText.substring(plainText.length - 5) ==
          schoolKey!.substring(0, 5)) {
        plainText = plainText.substring(0, plainText.length - 5);
        return encrypter.decrypt(Encrypted.fromBase64(plainText), iv: iv);
      } else {
        return "-1";
      }
    }
    return "";
  }
}

// void main() {
//   var bytes = utf8.encode("용수철중학교"); // data being hashed
//
//   var digest = sha256.convert(bytes);
//
//   print("Digest as bytes: ${digest.bytes}");
//   print("Digest as hex string: $digest");
//
//   var trimDigest = digest.toString().substring(5, 29);
//
//   // final plainText =
//   //     "43211902-23640164%LCD패널또는모니터%액정모니터,엘지전자, CN/24EA430V, 60.4cm%교육행정실%교육행정실%#%2021-07-08%M000018701%183,000%5";
//   // final key = Key.fromUtf8(trim_digest);
//   // final iv = IV.fromLength(16);
//   //
//   // final encrypter = Encrypter(AES(key, padding: null));
//   //
//   // final encrypted = encrypter.encrypt(plainText, iv: iv);
//   // print("encrypted : type = ${encrypted.base64.runtimeType}");
//   // final decrypted =
//   //     encrypter.decrypt(Encrypted.fromBase64(encrypted.base64), iv: iv);
//   // print("decrypted : type = ${decrypted.runtimeType}");
//   // print(encrypted.base64);
//   // print(decrypted);
//
//   final plainText =
//       "43211902-23640164%LCD패널또는모니터%액정모니터,엘지전자, CN/24EA430V, 60.4cm%교육행정실%교육행정실%#%2021-07-08%M000018701%183,000%5";
//   final key = Key.fromUtf8(trimDigest);
//   final iv = IV.fromLength(16);
//
//   final encrypted = encrypter.encrypt(plainText, iv: iv);
//   print("encrypted : type = ${encrypted.base64.runtimeType}");
//   final decrypted =
//       encrypter.decrypt(Encrypted.fromBase64(encrypted.base64), iv: iv);
//   print("decrypted : type = ${decrypted.runtimeType}");
//   print(encrypted.base64);
//   print(decrypted);
// }
