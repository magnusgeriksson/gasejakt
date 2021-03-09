import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/view_models/register_viewmodel.dart';
import 'package:gasejakt/services/service_locator.dart';
import 'package:gasejakt/ui/widgets/column_spacer.dart';
import 'package:gasejakt/ui/widgets/md_number_input_row.dart';
import 'package:gasejakt/ui/widgets/md_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  RegisterViewModel viewModel = serviceLocator<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  var testIcon = Icon(Icons.done);
  var testIcon2 = Icon(Icons.send);
  final _antallJegereController = TextEditingController();
  final _jegerNummerController = TextEditingController();
  final _gragasNumberController = TextEditingController(text: "0");
  final _kanadagasNumberController = TextEditingController(text: "0");
  final _kortnebbgasNumberController = TextEditingController(text: "0");
  int gooseCounter = 0;

  @override
  void initState() {
    //model.loadData(); <-- Hent huntingdaymodel med jegernummer registrert?
    super.initState();
    _kanadagasNumberController.addListener(incrementGooseCounter);
    _gragasNumberController.addListener(incrementGooseCounter);
    _kortnebbgasNumberController.addListener(incrementGooseCounter);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _gragasNumberController.dispose();
    _kanadagasNumberController.dispose();
    _kortnebbgasNumberController.dispose();
    super.dispose();
  }

  void incrementGooseCounter() {
    setState(() {
      gooseCounter = int.tryParse(_gragasNumberController.text) +
          int.tryParse(_kanadagasNumberController.text) +
          int.tryParse(_kortnebbgasNumberController.text);
    });
  }

  bool _isValid = true;

  void _toggleValidator() {
    setState(() {
      _isValid = _formKey?.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListView(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
        children: [
          Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ColumnSpacer(spacing: 10, children: [
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
                    //Jegernummer
                    MDTextFormField(
                      controller: _jegerNummerController,
                      formKey: _formKey,
                      label: "Jegernummer",
                      validatorText: "Kan ikke være tom",
                    ),
                    //Antall jegere
                    MDTextFormField(
                      controller: _antallJegereController,
                      formKey: _formKey,
                      label: "Antall jegere",
                      validatorText: "Kan ikke være tom",
                    ),
                    //Hva har du skutt title
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Hva har du skutt?",
                                //TODO default sub title style
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                            Text("Antall",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15))
                          ],
                        ),
                        Divider(color: Colors.black, thickness: 1),
                      ],
                    ),
                    //Grågås
                    NumberInputRow(
                        label: "Grågås",
                        controller: _gragasNumberController,
                        gooseCounter: gooseCounter),
                    //Kanadagås
                    NumberInputRow(
                        label: "Kanadagås",
                        controller: _kanadagasNumberController,
                        gooseCounter: gooseCounter),
                    //Kortnebbgås
                    NumberInputRow(
                        label: "Kortnebbgås",
                        controller: _kortnebbgasNumberController,
                        gooseCounter: gooseCounter),
                    //Send inn
                    Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: SizedBox(
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
                        )),
                  ]),
                ]),
          )
        ]);
  }
}
