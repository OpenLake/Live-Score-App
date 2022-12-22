class Game {
  String id;
  String creator;
  String creatorName;
  String college;
  String gameType;
  String team1;
  String team2;
  int score1;
  int score2;
  String winner;
  String description;
  List<dynamic> keyMoments;
  String createdOn;

  Game(
      {this.creator = '',
      this.creatorName='',
      this.college = '',
      this.gameType = '',
      this.team1 = '',
      this.team2 = '',
      this.score1 = 0,
      this.score2 = 0,
      this.id = '',
      this.winner = 'Draw',
      this.description = '',
      this.createdOn = '26-05-2003',
      this.keyMoments = const ['Game Started']});

  Map<String, dynamic> toJson(String Id) {
    id = Id;
    return {
      'id': id,
      'creator': creator,
      'creatorName':creatorName,
      'college': college,
      'gameType': gameType,
      'team1': team1,
      'team2': team2,
      'score1': score1,
      'score2': score2,
      'description': description,
      'createdOn': createdOn,
      'winner': winner,
      'keyMoments': keyMoments,
    };
  }

  static Game fromJson(Map<dynamic, dynamic> jsonData) {
    return Game(
        id: jsonData['id'],
        creator: jsonData['creator'],
        creatorName:jsonData['creatorName'],
        college: jsonData['college'],
        description: jsonData['description'],
        score1: jsonData['score1'],
        score2: jsonData['score2'],
        gameType: jsonData['gameType'],
        team1: jsonData['team1'],
        team2: jsonData['team2'],
        createdOn: jsonData['createdOn'],
        keyMoments: jsonData['keyMoments'],
        winner: jsonData['winner']);
  }
}
