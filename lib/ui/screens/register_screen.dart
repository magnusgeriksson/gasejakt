import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/view_models/register_view_model.dart';
import 'package:gasejakt/services/service_locator.dart';
import 'package:gasejakt/ui/widgets/column_spacer.dart';
import 'package:gasejakt/ui/widgets/md_number_input_row.dart';
import 'package:gasejakt/ui/widgets/md_text_form_field.dart';
import 'package:provider/provider.dart';
import 'kommuner_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterScreen> {
  RegisterViewModel viewModel = serviceLocator<RegisterViewModel>();

  final _formKey = GlobalKey<FormState>();

  //Initialized in load default data to trigger validation
  TextEditingController _jegerNummerController;
  final _antallJegereController = TextEditingController();
  final _gragasNumberController = TextEditingController(text: "0");
  final _kanadagasNumberController = TextEditingController(text: "0");
  final _kortnebbgasNumberController = TextEditingController(text: "0");

  //Used to validate goose counter rows
  int gooseCounter = 0;

  @override
  void initState() {
    super.initState();

    loadDefaultData();
    _kanadagasNumberController.addListener(incrementGooseCounter);
    _gragasNumberController.addListener(incrementGooseCounter);
    _kortnebbgasNumberController.addListener(incrementGooseCounter);
  }

  void loadDefaultData() async {
    await viewModel.loadData();
    _jegerNummerController =
        TextEditingController(text: viewModel.registerPresentation.jegernummer);
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

  void _sendRegistrering() {
    viewModel.sendData(
        _gragasNumberController.text, _kortnebbgasNumberController.text,
        _kanadagasNumberController.text, _antallJegereController.text);

    _antallJegereController.clear();
    _gragasNumberController.clear();
    _kanadagasNumberController.clear();
    _kortnebbgasNumberController.clear();
    gooseCounter = 0;
  }

  void _navigateToSelectKommune() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectKommuneScreen()),
    ).then((value) => loadDefaultData());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterViewModel>.value(
        value: viewModel,
        child: Consumer<RegisterViewModel>(
          builder: (context, model, child) => Scaffold(
              //TODO legg AppBar i main?
              appBar: AppBar(
                centerTitle: true,
                title: Text("Registrer"),
              ),
              body: ListView(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  children: [
                    Form(
                      key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ColumnSpacer(spacing: 10, children: [
                            //INFO TEXT
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
                                    "Send inn en registrering for hver jaktdag, for hele jaktf??lget",
                                  ),
                                ),
                              ],
                            ),
                            //Jegernummer
                            MDTextFormField(
                              controller: _jegerNummerController,
                              formKey: _formKey,
                              label: "Jegernummer",
                              validatorText: "Kan ikke v??re tom",
                            ),
                            //Antall jegere
                            MDTextFormField(
                              controller: _antallJegereController,
                              formKey: _formKey,
                              label: "Antall jegere",
                              validatorText: "Kan ikke v??re tom",
                                keyboardType: TextInputType.number),
                            //Hvor jaktet du?
                            Text("Hvor jaktet du?", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                            //TODO legge til validering p?? kommune.
                                SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _navigateToSelectKommune,
                                child: Text(model?.registerPresentation?.kommunenavn ?? ""),
                              ),
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
                            //M?? v??re minst en g??s registrert
                            //Gr??g??s
                            NumberInputRow(
                                label: "Gr??g??s",
                                controller: _gragasNumberController,
                                gooseCounter: gooseCounter),
                            //Kanadag??s
                            NumberInputRow(
                                label: "Kanadag??s",
                                controller: _kanadagasNumberController,
                                gooseCounter: gooseCounter),
                            //Kortnebbg??s
                            NumberInputRow(
                                label: "Kortnebbg??s",
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
                                        // _toggleValidator();

                                        // viewModel.sendData();

                                        if (_formKey.currentState.validate()) {
                                          _sendRegistrering();

                                            // If the form is valid, display a Snackbar.
                                            // ScaffoldMessenger.of(context)
                                            //     .showSnackBar(SnackBar(content: Text('Processing Data')));
                                          }
                                        },
                                        child: Text('Send inn'),
                                      ),
                                    )),
                              ]),
                            ]))
                  ])),
        ));
  }
}
