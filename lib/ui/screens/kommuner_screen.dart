import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/utils/constants.dart';
import 'package:gasejakt/business_logic/view_models/kommune_viewmodel.dart';
import 'package:gasejakt/services/service_locator.dart';
import 'package:provider/provider.dart';

class SelectKommuneScreen extends StatefulWidget {
  @override
  _SelectKommuneScreenState createState() => _SelectKommuneScreenState();
}

class _SelectKommuneScreenState extends State<SelectKommuneScreen> {
  KommuneViewModel model = serviceLocator<KommuneViewModel>();

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Within the SecondRoute widget
    // onPressed: () {
    //   Navigator.pop(context);
    // }

    Widget buildListView(KommuneViewModel viewModel) {
      return ChangeNotifierProvider<KommuneViewModel>.value(
          value: viewModel,
          child: Consumer<KommuneViewModel>(
              builder: (context, model, child) => ListView.builder(
                    itemCount: model?.kommunePresentation?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title:
                              Text('${model.kommunePresentation[index].navn}'),
                          trailing:
                              (model.kommunePresentation[index].isSelected ??
                                      false)
                                  ? Icon(Icons.done, color: PrimaryColor)
                                  : null,
                          onTap: () {
                            //setState to update Placeholder selected kommune
                            setState(() {
                              model.setKommune(index);
                            });
                          },
                        ),
                      );
                    },
                  )));
    }

    void searchKommune(String searchString) {
      model.filterKommuner(searchString);
    }

    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          title: Text('Velg kommune'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
              decoration: InputDecoration(
                labelText: "Søk etter kommune",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: searchKommune),
          new Expanded(child: buildListView(model))
        ]));
  }
}
