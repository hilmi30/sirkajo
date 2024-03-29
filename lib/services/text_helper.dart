class TextHelper {
  String validateEmail(String value) {
    if (value == null || value == '') {
      return 'Email tidak boleh kosong';
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Email anda tidak valid';
    }
    return null;
  }

  String validateRequired(String val, fieldName) {
    if (val == null || val == '') {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }

  String validateUsername(String val, fieldName) {
    if (val == null || val == '') {
      return '$fieldName tidak boleh kosong';
    } else if (val.contains(' ')) {
      return '$fieldName tidak boleh ada spasi';
    }
    return null;
  }

  String validateLength(String val, fieldName, int length) {
    if (val == null || val == '') {
      return '$fieldName tidak boleh kosong';
    } else if (val.length < length) {
      return '$fieldName harus lebih dari $length karakter';
    }
    return null;
  }

  String match(String val1, val2, fieldName) {
    if (val1 != val2) {
      return '$fieldName tidak sama';
    }
    return null;
  }
}