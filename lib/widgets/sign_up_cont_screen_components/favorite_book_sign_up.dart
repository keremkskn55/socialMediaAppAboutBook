import 'package:book_app/constants.dart';
import 'package:book_app/services/book_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class FavoriteBookSignUp extends StatefulWidget {
  Function callback;

  FavoriteBookSignUp({required this.callback});

  @override
  _FavoriteBookSignUpState createState() => _FavoriteBookSignUpState();
}

class _FavoriteBookSignUpState extends State<FavoriteBookSignUp> {
  TextEditingController _favoriteBookCtr = TextEditingController();
  List selectedFavoriteBookList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        /// Favorite Book Text
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 32.0),
            child: Text(
              'Favorite Books',
              style: Constants().r20white,
            ),
          ),
        ),

        /// SizedBox
        SizedBox(height: 10),

        /// TextField and Adding Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: size.width * 3 / 4,
              child: TypeAheadField<Book?>(
                // suggestionsCallback: (pattern) async {
                //   return await BookApi.getBookSuggestions(pattern);
                // },

                textFieldConfiguration: TextFieldConfiguration(
                  controller: _favoriteBookCtr,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.collections_bookmark,
                      color: Colors.black,
                    ),
                  ),
                ),
                suggestionsCallback: BookApi.getBookSuggestions,
                // noItemsFoundBuilder: (context) => Center(
                //   child: Text(
                //     'No Found Book',
                //     style: Constants().r20black,
                //   ),
                // ),
                itemBuilder: (context, Book? suggestion) {
                  final book = suggestion!;
                  print(suggestion.name);

                  return ListTile(
                    title: Text(book.name),
                  );
                },
                onSuggestionSelected: (Book? suggestion) {
                  if (suggestion!.name.isNotEmpty) {
                    _favoriteBookCtr.text = suggestion.name;
                  }
                },
              ),
            ),
            InkWell(
              onTap: () {
                print('favorite book is: ${_favoriteBookCtr.text}');
                setState(() {
                  selectedFavoriteBookList.add(_favoriteBookCtr.text);
                  widget.callback(selectedFavoriteBookList);
                });
              },
              child: Container(
                width: 40,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Color(0xFF3A6073),
                ),
                child: Center(
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        /// Show Favorite Book
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 50,
            width: size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedFavoriteBookList.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      height: 40,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF3A6073),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${selectedFavoriteBookList[index]}',
                          style: Constants().r16white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('delete fav book');
                        setState(() {
                          selectedFavoriteBookList.removeAt(index);
                          widget.callback(selectedFavoriteBookList);
                        });
                      },
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
