void clearScreen() {
  print("\x1B[2J\x1B[0;0H"); // clear entire screen, move cursor to 0;0
  print("-------------------------"); // just to show where the cursor is
}

abstract mixin class Musician {
  // No 'on' clause, but an abstract method that other types must define if
  // they want to use (mix in or extend) Musician:
  void playInstrument(String instrumentName);

  void playPiano() {
    playInstrument('Piano');
  }

  void playFlute() {
    playInstrument('Flute');
  }
}

class Virtuoso with Musician {
  // Use Musician as a mixin
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName beautifully');
  }
}

class Novice extends Musician {
  // Use Musician as a class
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName poorly');
  }
}

void main() {
  var objA = Virtuoso();
  objA.playInstrument('alibaba');

  var objB = Novice();
  objB.playInstrument('cocoạmnoô');
  objA.playFlute();
  objA.playPiano();
}
