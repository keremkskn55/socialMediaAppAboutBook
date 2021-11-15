import 'package:book_app/constants.dart';
import 'package:book_app/services/book_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddingBookBookName extends StatelessWidget {
  TextEditingController bookNameCtr;
  Function callback;

  AddingBookBookName({required this.callback, required this.bookNameCtr});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width - 32,
      child: TypeAheadField<Book?>(
        // suggestionsCallback: (pattern) async {
        //   return await BookApi.getBookSuggestions(pattern);
        // },

        textFieldConfiguration: TextFieldConfiguration(
            controller: bookNameCtr,
            decoration: InputDecoration(
              hintText: 'Book Name',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              prefixIcon: Icon(
                Icons.collections_bookmark,
                color: Colors.black,
              ),
            ),
            onChanged: (val) {
              callback(bookNameCtr.text);
            }),
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
            bookNameCtr.text = suggestion.name;
            callback(bookNameCtr.text);
          }
        },
      ),
    );
  }
}
