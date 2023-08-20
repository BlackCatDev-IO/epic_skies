extension StringExtension on String {
  String get capitalizeFirst {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get splitPascalCase {
    if (isEmpty) {
      return '';
    }

    final stringBuffer = StringBuffer();

    for (var i = 0; i < length; i++) {
      if (i > 0 &&
          this[i].toUpperCase() == this[i] &&
          this[i - 1] != ' ' &&
          !this[i - 1].toUpperCase().contains(RegExp('[A-Z]'))) {
        stringBuffer.write(' ');
      }
      stringBuffer.write(this[i]);
    }

    return stringBuffer.toString();
  }
}
