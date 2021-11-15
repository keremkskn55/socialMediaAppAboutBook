import 'package:book_app/models/user.dart';
import 'package:book_app/screens/update_fav_book_screen_view_model.dart';
import 'package:book_app/services/book_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class UpdateFavBookScreen extends StatefulWidget {
  User? profileUser;
  Function callback;
  UpdateFavBookScreen({
    required this.profileUser,
    required this.callback,
  });

  @override
  _UpdateFavBookScreenState createState() => _UpdateFavBookScreenState();
}

class _UpdateFavBookScreenState extends State<UpdateFavBookScreen> {
  TextEditingController _favoriteBookCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<UpdateFavBookScreenViewModel>(
      create: (_) => UpdateFavBookScreenViewModel(),
      builder: (context, _) => Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Constants().blackBlue,
              Constants().blue,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Adding Book',
              style: Constants().r20white,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                widget.callback();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            children: [
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
                    onTap: () async {
                      print('favorite book is: ${_favoriteBookCtr.text}');
                      setState(() {
                        widget.profileUser!.favoriteBooks
                            .add(_favoriteBookCtr.text);
                      });
                      await Provider.of<UpdateFavBookScreenViewModel>(context,
                              listen: false)
                          .updateFavBookData(widget.profileUser,
                              widget.profileUser!.favoriteBooks);
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
              SizedBox(
                width: size.width - 32,
                child: Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: size.width - 32,
                  child: ListView.separated(
                    itemCount: widget.profileUser!.favoriteBooks.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            margin: EdgeInsets.symmetric(vertical: 8),
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.25),
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.profileUser!.favoriteBooks[index],
                                style: Constants().r16white,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  widget.profileUser!.favoriteBooks.remove(
                                      widget.profileUser!.favoriteBooks[index]);
                                });
                                await Provider.of<UpdateFavBookScreenViewModel>(
                                        context,
                                        listen: false)
                                    .updateFavBookData(widget.profileUser,
                                        widget.profileUser!.favoriteBooks);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(24),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'X',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
