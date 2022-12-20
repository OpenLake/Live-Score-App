class Game {
  String id;
  String creator;
  String college;
  String gameType;
  String team1;
  String team2;
  int score1;
  int score2;
  String winner;
  String description;
  List<dynamic> keyMoments;

  Game(
      {required this.creator,
      required this.college,
      required this.gameType,
      required this.team1,
      required this.team2,
      this.score1 = 0,
      this.score2 = 0,
      this.id = '',
      this.winner = 'Draw',
      this.description = '',
      this.keyMoments = const ['Game Started']});

  Map<String, dynamic> toJson(String Id) {
    id = Id;
    return {
      'id': id,
      'creator': creator,
      'college': college,
      'gameType': gameType,
      'team1': team1,
      'team2': team2,
      'score1': score1,
      'score2': score2,
      'description': description,
      'winner': winner,
      'keyMoments': keyMoments,
    };
  }

  static Game fromJson(Map<String, dynamic> jsonData) {
    return Game(
        id: jsonData['id'],
        creator: jsonData['creator'],
        college: jsonData['college'],
        description: jsonData['description'],
        score1: jsonData['score1'],
        score2: jsonData['score2'],
        gameType: jsonData['gameType'],
        team1: jsonData['team1'],
        team2: jsonData['team2'],
        keyMoments: jsonData['keyMoments'],
        winner: jsonData['winner']);
  }
}
