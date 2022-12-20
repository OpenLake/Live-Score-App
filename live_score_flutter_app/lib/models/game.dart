class Game {
  String gameType;
  String nameTeam1;
  String nameTeam2;
  String scoreTeam1;
  String scoreTeam2;
  String description;

  Game(
      {required this.gameType,
      required this.nameTeam1,
      required this.nameTeam2,
      required this.scoreTeam1,
      required this.scoreTeam2,
      this.description=''});

      Map<String, dynamic> toMap() {
    return {
      'gameType': gameType,
      'nameTeam1': nameTeam1,
      'nameTeam2': nameTeam2,
      'scoreTeam1':scoreTeam1,
      'scoreTeam2':scoreTeam2,
      'description':description
    };
  }
}


