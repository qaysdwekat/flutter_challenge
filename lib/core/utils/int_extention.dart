extension IntExtension on int {
  bool get isPrime {
    if (this <= 1) return false;
    if (this == 2) return true;
    if (this % 2 == 0) return false;

    for (int i = 3; i * i <= this; i += 2) {
      if (this % i == 0) return false;
    }
    return true;
  }
}
