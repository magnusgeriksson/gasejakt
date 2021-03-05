import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/view_models/register_huntingday_viewmodel.dart';
import 'package:gasejakt/services/service_locator.dart';
import 'package:provider/provider.dart';

class RegisterHuntingdayScreen extends StatefulWidget {
  @override
  _RegisterHuntingdayState createState() => _RegisterHuntingdayState();
}

class _RegisterHuntingdayState extends State<RegisterHuntingdayScreen> {
  RegisterHuntingdayViewModel viewModel =
      serviceLocator<RegisterHuntingdayViewModel>();
  final _formKey = GlobalKey<FormState>();
  var testIcon = Icon(Icons.done);
  var testIcon2 = Icon(Icons.send);

  bool _isValid = true;

  void _toggleFavorite() {
    setState(() {
      if (_isValid) {
        _isValid = false;
      } else {
        _isValid = true;
      }
    });
  }

  @override
  void initState() {
    //model.loadData(); <-- Hent huntingdaymodel med jegernummer registrert?
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterHuntingdayViewModel>(
      create: (context) => viewModel,
      child: Consumer<RegisterHuntingdayViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: Text(viewModel.testString),
          ),
          body: Column(
            children: [
              Form(
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
                          color: Colors.green[700],
                          onPressed: _toggleFavorite,
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
                          suffixIcon: (_isValid
                              ? Icon(Icons.done)
                              : Icon(Icons.error))),
                      validator: (value) {
                        if (value.isEmpty) {
                          // _toggleFavorite();
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false
                          // otherwise.
                          _toggleFavorite();

                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a Snackbar.
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
