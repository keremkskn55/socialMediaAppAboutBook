import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

class AddingSharingPhoto extends StatefulWidget {
  File? image;
  Function callback;
  AddingSharingPhoto({required this.image, required this.callback});

  @override
  State<AddingSharingPhoto> createState() => _AddingSharingPhotoState();
}

class _AddingSharingPhotoState extends State<AddingSharingPhoto> {
  late File newImage;

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
    newImage = widget.image!;
    widget.callback(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.image == null
        ? Container(
            height: (size.height / 2),
            width: (size.width / 3) * 2,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
            ),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                ),
                child: Icon(Icons.add),
                onPressed: () {
                  chooseGalleryOrCamera();
                },
              ),
            ),
          )
        : Stack(
            children: [
              Container(
                height: (size.height / 2),
                width: (size.width / 3) * 2,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  image: DecorationImage(
                    image: FileImage(newImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    chooseGalleryOrCamera();
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                      ),
                    ),
                    child: Icon(Icons.change_circle_outlined),
                  ),
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
            height: 90,
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
