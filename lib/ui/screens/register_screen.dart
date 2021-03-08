import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/view_models/register_viewmodel.dart';
import 'package:gasejakt/services/service_locator.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  RegisterViewModel viewModel = serviceLocator<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  var testIcon = Icon(Icons.done);
  var testIcon2 = Icon(Icons.send);

  @override
  void initState() {
    //model.loadData(); <-- Hent huntingdaymodel med jegernummer registrert?
    super.initState();
  }

  // bool _isValid = true;

  void _toggleValidator(bool valid) {
    setState(() {
      // _isValid = valid;
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
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Jegernummer',
                    suffixIcon: ((_formKey?.currentState?.validate() ?? false)
                        ? Icon(Icons.done)
                        : Icon(Icons.error))),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: myController,
                onChanged: (text){
                  _toggleValidator(_formKey?.currentState?.validate());
                  // _formKey.currentState.validate();
                } ,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    _toggleValidator(_formKey.currentState.validate());

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
