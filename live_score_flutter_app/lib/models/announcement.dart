class Announcement {
  String message;
  String creator;
  String creatorName;
  String collegeName;
  String createdOn;
  String id;

  Announcement(
      {this.message = '',
      this.creator = '',
      this.creatorName = '',
      this.collegeName = '',
      this.createdOn = '26-05-2003',// :)
      this.id = ''});

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "creator": creator,
      "creatorName": creatorName,
      "collegeName": collegeName,
      "createdOn": createdOn,
      "id": id,
    };
  }

  static Announcement fromJson(Map<String, dynamic> jsonData) {
    return Announcement(
      message: jsonData['message'],
      creator: jsonData['creator'],
      creatorName: jsonData['creatorName'],
      collegeName: jsonData['collegeName'],
      createdOn: jsonData['createdOn'],
      id: jsonData['id'],
    );
  }
}
