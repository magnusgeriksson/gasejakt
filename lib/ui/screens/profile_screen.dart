import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasejakt/business_logic/view_models/profile_viewmodel.dart';
import 'package:gasejakt/services/service_locator.dart';
import 'package:gasejakt/ui/widgets/MDTextFormField.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewmodel viewmodel = serviceLocator<ProfileViewmodel>();
  final _formKey = GlobalKey<FormState>();
  var isLoading = true;

  @override
  void initState() {
    viewmodel.loadData().whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }
    return ChangeNotifierProvider<ProfileViewmodel>.value(
        value: viewmodel,
        child: Consumer<ProfileViewmodel>(
          builder: (context, vm, child) => Scaffold(
            appBar: AppBar(
              title: Text("Meg"),
            ),
            body: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MDTextFormField(
                    initialValue: vm.hunter.hunterNumber ?? "HRRR",
                    onChanged: (value) => viewmodel.setHuntingNumber(value),
                    label: "Jegernummer",
                    validatorText: "Kan ikke være tomt",
                    formKey: _formKey,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  MDTextFormField(
                    initialValue: vm.hunter.firstName,
                    label: "Fornavn",
                    keyboardType: TextInputType.text,
                    validatorText: "Kan ikke være tomt",
                    formKey: _formKey,
                    onChanged: (value) => vm.setFirstName(value),
                  ),
                  MDTextFormField(
                    initialValue: vm.hunter.lastName,
                    label: "Etternavn",
                    keyboardType: TextInputType.text,
                    validatorText: "Kan ikke være tomt",
                    formKey: _formKey,
                    onChanged: (value) => vm.setLastName(value),
                  ),
                  MDTextFormField(
                    initialValue: vm.hunter.address,
                    label: "Adresse",
                    keyboardType: TextInputType.text,
                    validatorText: "Kan ikke være tomt",
                    formKey: _formKey,
                    onChanged: (value) => vm.setAddress(value),
                  ),
                  MDTextFormField(
                    initialValue: vm.hunter.postalCode,
                    label: "Postnummer",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validatorText: "Kan ikke være tomt",
                    formKey: _formKey,
                    onChanged: (value) => vm.setPostalCode(value),
                  ),
                  MDTextFormField(
                    initialValue: vm.hunter.postalAddress,
                    label: "Poststed",
                    keyboardType: TextInputType.text,
                    validatorText: "Kan ikke være tomt",
                    formKey: _formKey,
                    onChanged: (value) => vm.setPostalAddress(value),
                  ),
                  MDTextFormField(
                    initialValue: vm.hunter.phoneNumber,
                    label: "Mobilnummer",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validatorText: "Kan ikke være tomt",
                    formKey: _formKey,
                    onChanged: (value) => vm.setPhoneNumber(value),
                  ),
                  MDTextFormField(
                    initialValue: vm.hunter.mailAddress,
                    label: "Mailadresse",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validatorText: "Kan ikke være tomt",
                    formKey: _formKey,
                    onChanged: (value) => vm.setMailAddress(value),
                  ),
                  Text(vm.hunter.firstName),
                  Text(vm.hunter.lastName),
                  Text(vm.hunter.hunterNumber),
                  Text(vm.hunter.address),
                  Text(vm.hunter.postalCode),
                  Text(vm.hunter.postalAddress),
                  Text(vm.hunter.phoneNumber),
                  Text(vm.hunter.mailAddress),
                ],
              ),
            ),
          ),
        ));
  }
}
