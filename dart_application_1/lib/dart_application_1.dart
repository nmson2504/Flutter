int calculate() {
  return 6 * 7;
}

void clear() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------------------"); // just to show where the cursor is
// http://en.wikipedia.org/wiki/ANSI_escape_code#CSI_codes
}
