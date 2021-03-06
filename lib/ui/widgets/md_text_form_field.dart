import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MDTextFormField extends StatefulWidget {
  // final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String label;
  final String validatorText;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool enabled;
  const MDTextFormField(
      {Key key,
      this.formKey,
      this.label,
      this.validatorText,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.inputFormatters,
      this.enabled})
      : super(key: key);

  @override
  _MDTextFormFieldState createState() => _MDTextFormFieldState();
}

class _MDTextFormFieldState extends State<MDTextFormField> {
  final _formFieldKey = GlobalKey<FormFieldState>();
  bool isValidated;

  @override
  void initState() {
    super.initState();
    //TODO: Validere i initState().
    isValidated = widget.controller?.text != "";
  }

  @override
  Widget build(BuildContext context) {
    void toggleValidated() {
      setState(() {
        isValidated = (_formFieldKey?.currentState?.validate() ?? false) ||
            (widget?.formKey?.currentState?.validate() ?? false);
      });
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          child: TextFormField(
        key: _formFieldKey,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        enabled: widget.enabled != false,
        inputFormatters: widget.inputFormatters,
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
      )),
    );
  }
}
