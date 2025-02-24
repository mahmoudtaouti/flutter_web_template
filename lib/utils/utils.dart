int _extractNumberFromName(String name) {
  final match = RegExp(r'\d+$').firstMatch(name);
  return match != null ? int.parse(match.group(0)!) : 0;
}