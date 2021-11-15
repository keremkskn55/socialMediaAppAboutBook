class Sharing {
  String idNum;
  String username;
  String photoUrl;
  String mainComments;
  String bookName;
  String sharingTime;
  List categories;
  List favs;
  List saved;
  List comments;

  Sharing({
    required this.idNum,
    required this.username,
    required this.photoUrl,
    required this.mainComments,
    required this.categories,
    required this.favs,
    required this.saved,
    required this.comments,
    required this.bookName,
    required this.sharingTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'idNum': idNum,
      'username': username,
      'photoUrl': photoUrl,
      'mainComments': mainComments,
      'categories': categories,
      'favs': favs,
      'saved': saved,
      'comments': comments,
      'bookName': bookName,
      'sharingTime': sharingTime,
    };
  }

  factory Sharing.fromMap(Map map) {
    return Sharing(
      idNum: map['idNum'],
      username: map['username'],
      photoUrl: map['photoUrl'],
      mainComments: map['mainComments'],
      favs: map['favs'],
      saved: map['saved'],
      comments: map['comments'],
      categories: map['categories'],
      bookName: map['bookName'],
      sharingTime: map['sharingTime'],
    );
  }
}
