import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasejakt/business_logic/view_models/profile_viewmodel.dart';
import 'package:gasejakt/services/service_locator.dart';
import 'package:gasejakt/ui/widgets/md_text_form_field.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewmodel viewmodel = serviceLocator<ProfileViewmodel>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _hunterNumberController;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _addressController;
  TextEditingController _postalCodeController;
  TextEditingController _postalAddressController;
  TextEditingController _phoneController;
  TextEditingController _mailController;

  final ButtonStyle flatButtonStyle = ElevatedButton.styleFrom(
    minimumSize: Size(80, 48),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
  );

  @override
  void initState() {
    viewmodel.loadData().whenComplete(() => setupTextFieldControllers());
    super.initState();
  }

  void setupTextFieldControllers() {
    initializeTextFieldControllers();
    setupTextFieldBindings();
  }

  void initializeTextFieldControllers() {
    _hunterNumberController =
        TextEditingController(text: viewmodel.hunter.hunterNumber);
    _firstNameController =
        TextEditingController(text: viewmodel.hunter.firstName);
    _lastNameController =
        TextEditingController(text: viewmodel.hunter.lastName);
    _addressController = TextEditingController(text: viewmodel.hunter.address);
    _postalCodeController =
        TextEditingController(text: viewmodel.hunter.postalCode);
    _postalAddressController =
        TextEditingController(text: viewmodel.hunter.postalAddress);
    _phoneController =
        TextEditingController(text: viewmodel.hunter.phoneNumber);
    _mailController = TextEditingController(text: viewmodel.hunter.mailAddress);
  }

  void setupTextFieldBindings() {
    _hunterNumberController.addListener(() {
      viewmodel.setHuntingNumber(_hunterNumberController.text);
    });
    _firstNameController.addListener(() {
      viewmodel.setFirstName(_firstNameController.text);
    });
    _lastNameController.addListener(() {
      viewmodel.setLastName(_lastNameController.text);
    });
    _addressController.addListener(() {
      viewmodel.setAddress(_addressController.text);
    });
    _postalCodeController.addListener(() async {
      viewmodel.setPostalCode(_postalCodeController.text);
      _postalAddressController.text =
          await viewmodel.getKommuneNavn(_postalCodeController.text);
    });
    _phoneController.addListener(() {
      viewmodel.setPhoneNumber(_phoneController.text);
    });
    _mailController.addListener(() {
      viewmodel.setMailAddress(_mailController.text);
    });
  }

  void disposeControllers() {
    _hunterNumberController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _postalCodeController.dispose();
    _postalAddressController.dispose();
    _phoneController.dispose();
    _mailController.dispose();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewmodel>.value(
        value: viewmodel,
        child: Consumer<ProfileViewmodel>(
          builder: (context, vm, child) => Scaffold(
            appBar: AppBar(
              title: Text("Meg"),
            ),
            body: Form(
                child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              children: [
                MDTextFormField(
                  controller: _hunterNumberController,
                  label: "Jegernummer",
                  validatorText: "Kan ikke være tomt",
                  formKey: _formKey,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                MDTextFormField(
                  controller: _firstNameController,
                  label: "Fornavn",
                  keyboardType: TextInputType.text,
                  validatorText: "Kan ikke være tomt",
                  formKey: _formKey,
                ),
                MDTextFormField(
                  controller: _lastNameController,
                  label: "Etternavn",
                  keyboardType: TextInputType.text,
                  validatorText: "Kan ikke være tomt",
                  formKey: _formKey,
                ),
                MDTextFormField(
                  controller: _addressController,
                  label: "Adresse",
                  keyboardType: TextInputType.text,
                  validatorText: "Kan ikke være tomt",
                  formKey: _formKey,
                ),
                MDTextFormField(
                  controller: _postalCodeController,
                  label: "Postnummer",
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validatorText: "Kan ikke være tomt",
                  formKey: _formKey,
                ),
                MDTextFormField(
                  controller: _postalAddressController,
                  label: "Poststed",
                  keyboardType: TextInputType.text,
                  validatorText: "Kan ikke være tomt",
                  formKey: _formKey,
                  enabled: false,
                ),
                MDTextFormField(
                  controller: _phoneController,
                  label: "Mobilnummer",
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validatorText: "Kan ikke være tomt",
                  formKey: _formKey,
                ),
                MDTextFormField(
                  controller: _mailController,
                  label: "Mailadresse",
                  keyboardType: TextInputType.text,
                  validatorText: "Kan ikke være tomt",
                  formKey: _formKey,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                      child: Text("Lagre"),
                      onPressed: () async => saveHunter(),
                      style: flatButtonStyle),
                ),
              ],
            )),
          ),
        ));
  }

  void saveHunter() async {
    var res = await viewmodel.saveHunter();
    showSavingFeedback(res);
  }

  showSavingFeedback(bool res) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(res
          ? "Informasjonen er lagret"
          : "Lagring feilet, vennligst prøv igjen"),
    ));
  }
}
