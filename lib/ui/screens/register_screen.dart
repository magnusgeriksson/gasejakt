import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/view_models/register_viewmodel.dart';
import 'package:gasejakt/services/service_locator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  RegisterViewModel viewModel = serviceLocator<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _formFieldKey = GlobalKey<FormFieldState>();
  var testIcon = Icon(Icons.done);
  var testIcon2 = Icon(Icons.send);
  final _antallJegereController = TextEditingController();
  final _jegerNummerController = TextEditingController();

  @override
  void initState() {
    //model.loadData(); <-- Hent huntingdaymodel med jegernummer registrert?
    super.initState();
  }

  _printLatestValue() {
    print("Second text field: ${myController.text}");
  }

  bool _isValid = true;

  void _toggleValidator() {
    setState(() {
      _isValid = _formKey?.currentState?.validate();
    });
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
        padding: EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.centerLeft,
                    icon: Icon(Icons.error),
                    //TODO use constant
                    color: Color(0xFF006964),
                  ),
                  Flexible(
                    child: Text(
                      "Send inn en registrering for hver jaktdag, for hele jaktfølget tet",
                    ),
                  ),
                ],
              ),
              TextFieldState(
                controller: _jegerNummerController,
                formKey: _formKey,
                label: "Jegernummer",
                validatorText: "Kan ikke være tom",
              ),   TextFieldState(
                controller: _antallJegereController,
                formKey: _formKey,
                label: "Antall jegere",
                validatorText: "Kan ikke være tom",
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    _toggleValidator();

                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      // ScaffoldMessenger.of(context)
                      //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text('Send inn'),
                ),
              ),
            ],
          ),
        ));
  }
}

class TextFieldState extends StatefulWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String label;
  final String validatorText;

  const TextFieldState(
      {Key key, this.controller, this.formKey, this.label, this.validatorText})
      : super(key: key);

  @override
  _TextFieldStateState createState() => _TextFieldStateState();
}

class _TextFieldStateState extends State<TextFieldState> {
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
      keyboardType: TextInputType.text,
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