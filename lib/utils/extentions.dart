extension StringExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String capitalize() => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}

extension IntExtension on int {
  String ordinal() {
    int value = this;

    int tempValue;
    dynamic templates;
    String finalValue;

    List valueSpecial = [11, 12, 13];

    if (valueSpecial.contains(value % 100)) {
      return "${value}th";
    } else if (value.toString().length == 1) {
      templates = [
        "0",
        "1st",
        "2nd",
        "3rd",
        "4th",
        "5th",
        "6th",
        "7th",
        "8th",
        "9th",
      ];
      finalValue = templates[value];
    } else {
      tempValue = value % 10;
      templates = {
        // Ordinal format when value ends with 0, e.g. 80th
        "$tempValue": "${value}th",
        // Ordinal format when value ends with 1, e.g. 81st, except 11.
        "$tempValue": "${value}st",
        // Ordinal format when value ends with 2, e.g. 82nd, except 12.
        "$tempValue": "${value}nd",
        // Ordinal format when value ends with 3, e.g. 83rd, except 13.
        "$tempValue": "${value}rd",
        // Ordinal format when value ends with 4, e.g. 84th.
        "$tempValue": "${value}th",
        // Ordinal format when value ends with 5, e.g. 85th.
        "$tempValue": "${value}th",
        // Ordinal format when value ends with 6, e.g. 86th.
        "$tempValue": "${value}th",
        // Ordinal format when value ends with 7, e.g. 87th.
        "$tempValue": "${value}th",
        // Ordinal format when value ends with 8, e.g. 88th.
        "$tempValue": "${value}th",
        // Ordinal format when value ends with 9, e.g. 89th.
        "$tempValue": "${value}th",
      };
      finalValue = templates["$tempValue"];
    }
    return finalValue;
  }

  static const List<int> _arabianRomanNumbers = [
    1000,
    900,
    500,
    400,
    100,
    90,
    50,
    40,
    10,
    9,
    5,
    4,
    1
  ];

  static const List<String> _romanNumbers = [
    "M",
    "CM",
    "D",
    "CD",
    "C",
    "XC",
    "L",
    "XL",
    "X",
    "IX",
    "V",
    "IV",
    "I"
  ];

  String toRoman() {
    var num = this;

    if (num < 0) {
      return "";
    } else if (num == 0) {
      return "nulla";
    }

    final builder = StringBuffer();
    for (var a = 0; a < _arabianRomanNumbers.length; a++) {
      final times = (num / _arabianRomanNumbers[a])
          .truncate(); // equals 1 only when arabianRomanNumbers[a] = num
      // executes n times where n is the number of times you have to add
      // the current roman number value to reach current num.
      builder.write(_romanNumbers[a] * times);
      num -= times *
          _arabianRomanNumbers[
              a]; // subtract previous roman number value from num
    }

    return builder.toString();
  }
}
