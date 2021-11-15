import 'package:book_app/constants.dart';
import 'package:flutter/material.dart';

class InterestedCategorySignUp extends StatefulWidget {
  bool history;
  bool science;
  bool romantic;
  bool adventure;
  bool sciFi;
  bool novel;
  Function callback;

  InterestedCategorySignUp({
    required this.callback,
    required this.history,
    required this.science,
    required this.sciFi,
    required this.adventure,
    required this.romantic,
    required this.novel,
  });

  @override
  _InterestedCategorySignUpState createState() =>
      _InterestedCategorySignUpState();
}

class _InterestedCategorySignUpState extends State<InterestedCategorySignUp> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Color(0xFF3A6073);
  }

  Map interestedCategoryMap = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          /// Title Interested Category
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Interested Category',
              style: Constants().r20white,
            ),
          ),

          /// Check Boxes
          Wrap(
            children: [
              interestedCategoryMethod('History'),
              interestedCategoryMethod('Science'),
              interestedCategoryMethod('Romantic'),
              interestedCategoryMethod('Adventure'),
              interestedCategoryMethod('Sci-Fi'),
              interestedCategoryMethod('Novel'),
            ],
          ),
        ],
      ),
    );
  }

  Row interestedCategoryMethod(String categoryName) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: categoryName == 'History'
              ? widget.history
              : categoryName == 'Science'
                  ? widget.science
                  : categoryName == 'Romantic'
                      ? widget.romantic
                      : categoryName == 'Adventure'
                          ? widget.adventure
                          : categoryName == 'Sci-Fi'
                              ? widget.sciFi
                              : widget.novel,
          onChanged: (val) {
            setState(() {
              if (categoryName == 'History') {
                widget.history = val!;
              } else if (categoryName == 'Science') {
                widget.science = val!;
              } else if (categoryName == 'Romantic') {
                widget.romantic = val!;
              } else if (categoryName == 'Adventure') {
                widget.adventure = val!;
              } else if (categoryName == 'Sci-Fi') {
                widget.sciFi = val!;
              } else if (categoryName == 'Novel') {
                widget.novel = val!;
              }
            });
            widget.callback(widget.history, widget.science, widget.romantic,
                widget.adventure, widget.sciFi, widget.novel);
          },
        ),
        Text(
          categoryName,
          style: Constants().r16white,
        ),
      ],
    );
  }
}
