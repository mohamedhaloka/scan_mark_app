import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scan_mark_app/provider/userData.dart';
import 'package:scan_mark_app/services/auth.dart';
import 'package:scan_mark_app/services/store.dart';
import 'package:scan_mark_app/views/bottom_tab/home/view.dart';
import 'package:scan_mark_app/views/bottom_tab/view.dart';
import 'package:scan_mark_app/widgets/custom_filled_button.dart';
import 'package:scan_mark_app/widgets/custom_sized_box.dart';
import 'package:scan_mark_app/widgets/custom_text_field.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import '../../const.dart';

class CompleteSignUp extends StatefulWidget {
  @override
  _CompleteSignUpState createState() => _CompleteSignUpState();
}

class _CompleteSignUpState extends State<CompleteSignUp> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  User loggedInUser;
  File _image;
  String imgURL;

  void getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedInUser = user;
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
      print("done upload");
    } catch (e) {
      print('bego erorr $e');
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    print(loggedInUser.uid);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: ExactAssetImage("assets/img/sign-in/bg.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 62, right: 62, top: 180, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/img/logo.png"),
                CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                Text(
                  "Customize Your Account, Enter Your Information Below.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                CustomSizedBox(heiNum: 0.08, wedNum: 0.0),
                GestureDetector(
                  onTap: () {
                    uploadFile();
                  },
                  child: Container(
                    child: CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.of(context).size.width * .4,
                              height: MediaQuery.of(context).size.width * .3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                        placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                  strokeWidth: 1.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFFff6768))),
                              width: 100.0,
                              height: 100.0,
                            ),
                        errorWidget: (context, url, error) =>
                            Text(error.toString()),
                        width: 300.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                        imageUrl: imgURL == null
                            ? "https://firebasestorage.googleapis.com/v0/b/scan-market.appspot.com/o/Jx4ATDi52BNaGHuTehxW2zMgt4C2%2FUserProfille%2Fimage_picker2771216902201923755.jpg?alt=media&token=b31dce1d-6b03-475f-a16e-8f897aac2ae2"
                            : imgURL.toString()),
                  ),
                ),
                CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hint: "Phone Number",
                          onChange: (val) {},
                        ),
                      ],
                    )),
                CustomSizedBox(heiNum: 0.052, wedNum: 0.0),
                loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Builder(
                        builder: (context) => FilledButton(
                            tittle: "Complete",
                            onPress: () {
                              _complete(context);
                            },
                            buttonColor: kPrimaryColor)),
                CustomSizedBox(heiNum: 0.02, wedNum: 0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _complete(context) async {
    var userData = Provider.of<UserData>(context, listen: false);
    try {
      setState(() {
        loading = true;
      });
      if (_formKey.currentState.validate()) {
        Store().storeUserInfo({
          kUserName: userData.name,
          kUserPassword: userData.pass,
          kUserEmail: userData.email,
          kUserPhoto: imgURL
        });
        print("done create account");

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomTabView()));
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
    setState(() {
      loading = false;
    });
  }
}
