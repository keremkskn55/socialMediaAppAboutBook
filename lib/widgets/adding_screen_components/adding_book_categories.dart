import 'package:flutter/material.dart';

import '../../constants.dart';

class AddingBookCategories extends StatefulWidget {
  bool history;
  bool science;
  bool romantic;
  bool adventure;
  bool sciFi;
  bool novel;
  Function callback;

  AddingBookCategories({
    required this.callback,
    required this.history,
    required this.science,
    required this.sciFi,
    required this.adventure,
    required this.romantic,
    required this.novel,
  });

  @override
  State<AddingBookCategories> createState() => _AddingBookCategoriesState();
}

class _AddingBookCategoriesState extends State<AddingBookCategories> {
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
    Size size = MediaQuery.of(context).size;
    return Container(
      height: (size.height / 2),
      width: (size.width / 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          interestedCategoryMethod('History'),
          interestedCategoryMethod('Science'),
          interestedCategoryMethod('Romantic'),
          interestedCategoryMethod('Adventure'),
          interestedCategoryMethod('Sci-Fi'),
          interestedCategoryMethod('Novel'),
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
