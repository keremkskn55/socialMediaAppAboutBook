class User {
  String username;
  String profilePhotoUrl;
  String name;
  String surname;
  String email;
  String password;
  List sharing;
  List saved;
  List favoriteBooks;
  List interestedCategories;

  User({
    required this.username,
    required this.name,
    required this.password,
    required this.email,
    required this.surname,
    required this.favoriteBooks,
    required this.profilePhotoUrl,
    required this.saved,
    required this.sharing,
    required this.interestedCategories,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'profilePhotoUrl': profilePhotoUrl,
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'sharing': sharing,
      'saved': saved,
      'favoriteBooks': favoriteBooks,
      'interestedCategories': interestedCategories,
    };
  }

  factory User.fromMap(Map map) {
    return User(
      username: map['username'],
      name: map['name'],
      surname: map['surname'],
      profilePhotoUrl: map['profilePhotoUrl'],
      email: map['email'],
      favoriteBooks: map['favoriteBooks'],
      password: map['password'],
      saved: map['saved'],
      sharing: map['sharing'],
      interestedCategories: map['interestedCategories'],
    );
  }
}
