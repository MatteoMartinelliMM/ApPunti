class Giocatore {
  String name;
  int points;
  double pointDouble;

  Giocatore(this.name, this.points, this.pointDouble);

  Giocatore.newGiocatore(String name) {
    this.name = name;
    points = 0;
    this.pointDouble = 0.0;
  }

  @override
  bool operator ==(other) {
    return this.name == other.name;
  }
}
