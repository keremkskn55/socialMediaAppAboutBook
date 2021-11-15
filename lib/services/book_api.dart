import 'dart:convert';
import 'package:http/http.dart' as http;

class Book {
  String id;
  String name;

  Book({required this.name, required this.id});

  // static Book fromJson(Map<String, dynamic> json) => Book(
  //       name: json['name'],
  //       photoUrl: json['photoUrl'],
  //       id: json['id'],
  //       author: json['author'],
  //     );
}

class BookApi {
  static Future<List<Book>> getBookSuggestions(String query) async {
    print('query: $query');
    final url =
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query');
    final response = await http.get(url);
    List<Book> resultBookList = [];

    print('before response status');
    if (response.statusCode == 200) {
      print('in response status');
      final Map books = json.decode(response.body);

      String tempId;
      String tempName;

      for (int i = 0; i < 5; i++) {
        tempId = books['items'][i]['id'];
        print('$i : $tempId');
        tempName = books['items'][i]['volumeInfo']['title'];
        print('$i : $tempName');
        resultBookList.add(Book(name: tempName, id: tempId));
      }
      print(resultBookList);
    }
    return resultBookList;
  }
}
