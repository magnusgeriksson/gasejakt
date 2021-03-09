import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberInputRow extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final int gooseCounter;

  const NumberInputRow(
      {Key key, this.controller, this.label, this.gooseCounter})
      : super(key: key);

  @override
  _NumberInputRowState createState() => _NumberInputRowState();
}

class _NumberInputRowState extends State<NumberInputRow> {
  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        widget.label,
        style: TextStyle(fontSize: 15),
      ),
      SizedBox(
        width: 40,
        child: TextFormField(
          key: _formFieldKey,
          controller: widget.controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(5.0))),
          validator: (value) {
            if (int.tryParse(value) != null && int.tryParse(value) > 0)
              return null;
            return "";
            // if (widget.gooseCounter == null || widget.gooseCounter < 1)
            //   return "";
            // return null;
          },
          onTap: () {
            if (widget.controller.text == "0") {
              widget.controller.clear();
            }
          },
          onChanged: (text) {
            _formFieldKey?.currentState?.validate();

            // widget.controller.clear();
          },
        ),
      )
    ]);
  }
}
