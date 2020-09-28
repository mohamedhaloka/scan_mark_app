import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';
import 'package:scan_mark_app/provider/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';

class ProfilePhoto extends StatefulWidget {
  ProfilePhoto({this.photo});
  String photo;
  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  User loggedInUser;
  File _image;
  bool loadingPhoto = false;
  String imgURL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        print(loggedInUser.uid);
      }
    } catch (e) {
      print("error" + e);
    }
  }

  Future uploadFile() async {
    try {
      await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
        setState(() {
          _image = image;
        });
      });
      print("step 1");
      setState(() {
        loadingPhoto = true;
      });
      StorageReference storageReference = FirebaseStorage.instance.ref().child(
          '${loggedInUser.uid}/UserProfille/${Path.basename(_image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete;
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          print(fileURL);
          imgURL = fileURL;
          print(imgURL.toString());
        });
      });
      setState(() {
        loadingPhoto = false;
      });

      print("done upload");
    } catch (e) {
      print('bego erorr $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(widget.photo == null ? "" : widget.photo),
              fit: BoxFit.cover)),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.2), shape: BoxShape.circle),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle),
              child: IconButton(
                icon: Icon(Icons.photo),
                onPressed: () {
                  updatePhoto();
                },
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  updatePhoto() async {
    uploadFile();
    var userData = Provider.of<UserData>(context, listen: false);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String pass;
    setState(() {
      pass = preferences.getString("userpass");
    });
    print(pass);
    Response response;
    Dio dio = new Dio();
    response =
        await dio.patch("https://scan-market.firebaseio.com/$pass.json", data: {
      kUserPhoto: imgURL.toString(),
    });
    setState(() {
      preferences.setString("userphoto", imgURL);
    });
  }
}