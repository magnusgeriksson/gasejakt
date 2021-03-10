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
                    itemCount: model.kommunePresentation.length ?? 0,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          // leading: SizedBox(
                          //   width: 60,
                          //   child: Text(
                          //     '${model.kommunePresentation[index].navn}',
                          //     style: TextStyle(fontSize: 10),
                          //   ),
                          // ),
                          title:
                              Text('${model.kommunePresentation[index].navn}'),
                          // subtitle:
                          //     Text('${model.kommunePresentation[index].navn}'),
                          trailing: (model.kommunePresentation[index].isSelected ?? false)
                              ? Icon(Icons.done, color: PrimaryColor)
                              : null,
                          onTap: () {
                            model.setKommune(index);
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
          title: Text('Velg kommune'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(model.selectedKommune.navn ?? "PLACEHOLDER SELECTED KOMMUNE"),
          TextField(
              decoration: InputDecoration(
                labelText: "Søk etter kommune",
                prefixIcon: Icon(Icons.search),

                // focusedBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: Colors.grey, width: 1.0),
                //     borderRadius: BorderRadius.circular(5.0)))
              ),
              onChanged: searchKommune),
          new Expanded(child: buildListView(model))
        ])

        // buildListView(model));
        );
  }
}
