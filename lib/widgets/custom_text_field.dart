import 'package:flutter/material.dart';
import 'package:scan_mark_app/const.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField({@required this.onChange, @required this.hint});
  Function onChange;
  String hint;
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;
  errorMessage(hint) {
    switch (hint) {
      case "Name":
        return "Required Name*";
      case "E-Mail":
        return "Required E-Mail*";
      case "Password":
        return "Required Password*";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      cursorColor: kPrimaryColor,
      // ignore: missing_return
      validator: (val) {
        if (val.isEmpty) {
          return errorMessage(widget.hint);
        }
      },
      keyboardType: widget.hint == "Phone Number"
          ? TextInputType.phone
          : TextInputType.name,
      style: TextStyle(fontSize: 14),
      textAlign: TextAlign.center,
      onChanged: widget.onChange,
      decoration: InputDecoration(
          prefixIcon: widget.hint == "Password"
              ? IconButton(
                  icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  })
              : null,
          filled: true,
          focusColor: Colors.grey,
          hintText: widget.hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey[100]),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey[100])),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey[100])),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey[100]))),
    );
  }
}
