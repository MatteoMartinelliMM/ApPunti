class Giocatore {
  String name;
  int points;

  Giocatore(this.name, this.points);

  Giocatore.newGiocatore(String name) {
    this.name = name;
    points = 0;
  }

  @override
  bool operator ==(other) {
    return this.name == other.name;
  }
}
