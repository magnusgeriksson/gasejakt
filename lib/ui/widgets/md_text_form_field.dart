import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MDTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String label;
  final String validatorText;
  final TextInputType textInputType;

  const MDTextFormField(
      {Key key,
      this.controller,
      this.formKey,
      this.label,
      this.validatorText,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  _MDTextFormFieldState createState() => _MDTextFormFieldState();
}

class _MDTextFormFieldState extends State<MDTextFormField> {
  final _formFieldKey = GlobalKey<FormFieldState>();
  var isValidated = false;

  @override
  Widget build(BuildContext context) {
    void toggleValidated() {
      setState(() {
        isValidated = _formFieldKey?.currentState?.validate() ??
            false || widget?.formKey?.currentState?.validate() ??
            false;
      });
    }

    return Container(
      // color: Colors.orange,
      // ...
        child: TextFormField(
          key: _formFieldKey,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      decoration: InputDecoration(
          labelText: widget.label,
          suffixIcon: isValidated ? Icon(Icons.done) : Icon(Icons.error),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(5.0))),
      validator: (value) {
        if (value.isEmpty) {
          return widget.validatorText;
        }
            return null;
          },
          onChanged: (text) {
            toggleValidated();
          },
        ));
  }
}