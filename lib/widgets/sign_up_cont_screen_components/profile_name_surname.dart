import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class ProfileNameSurname extends StatefulWidget {
  ProfileNameSurname({
    Key? key,
    required this.nameSurnameKey,
    required this.nameCtr,
    required this.surnameCtr,
    required this.callback,
    required this.photoUrl,
    required this.image,
  }) : super(key: key);

  final GlobalKey<FormState> nameSurnameKey;
  final TextEditingController nameCtr;
  final TextEditingController surnameCtr;
  String photoUrl;
  File? image;
  Function callback;

  @override
  State<ProfileNameSurname> createState() => _ProfileNameSurnameState();
}

class _ProfileNameSurnameState extends State<ProfileNameSurname> {
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        widget.image = imageTemporary;
        print('image: ${widget.image}');
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    widget.callback(widget.nameCtr, widget.surnameCtr, widget.image);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// Profile Photo
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
            ),
            widget.image != null
                ? ClipOval(
                    child: Image.file(
                      widget.image!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipOval(
                    child: Image.network(
                      widget.photoUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
            Positioned(
              top: 60,
              left: 60,
              child: GestureDetector(
                onTap: () {
                  print('image picker was pressed');
                  chooseGalleryOrCamera();
                },
                child: Container(
                  width: 58,
                  height: 52,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/camera_60r.png'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        /// Name Surname
        Form(
          key: widget.nameSurnameKey,
          child: Column(
            children: [
              SizedBox(
                width: size.width / 2,
                child: TextFormField(
                  controller: widget.nameCtr,
                  onChanged: (_) {
                    widget.callback(
                        widget.nameCtr, widget.surnameCtr, widget.image);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Name',
                    hintStyle: Constants().r16black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: size.width / 2,
                child: TextFormField(
                  controller: widget.surnameCtr,
                  onChanged: (_) {
                    widget.callback(
                        widget.nameCtr, widget.surnameCtr, widget.image);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Surname',
                    hintStyle: Constants().r16black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void chooseGalleryOrCamera() {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.image = null;
                        });
                        widget.callback(
                            widget.nameCtr, widget.surnameCtr, widget.image);
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Default Photo',
                              style: Constants().r16black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 2,
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Gallery',
                              style: Constants().r16black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 2,
                      color: Colors.black,
                    ),
                    InkWell(
                      onTap: () {
                        pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Camera',
                              style: Constants().r16black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
