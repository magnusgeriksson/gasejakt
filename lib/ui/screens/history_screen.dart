import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/utils/constants.dart';
import 'package:gasejakt/business_logic/view_models/history_viewmodel.dart';
import 'package:gasejakt/services/service_locator.dart';
import 'package:gasejakt/ui/widgets/column_spacer.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryViewModel model = serviceLocator<HistoryViewModel>();

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  Widget buildListView(HistoryViewModel viewModel) {
    return ChangeNotifierProvider<HistoryViewModel>.value(
        value: viewModel,
        child: Consumer<HistoryViewModel>(
            builder: (context, model, child) => ListView.builder(
                  itemCount: model?.registerPresentation?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ExpansionTile(
                        // leading: SizedBox(
                        //   width: 60,
                        //   child: Text(
                        //     '${model.kommunePresentation[index].navn}',
                        //     style: TextStyle(fontSize: 10),
                        //   ),
                        // ),
                        title: Text(
                            model?.registerPresentation[index].date.toString()),
                        // subtitle:
                        //     Text('${model.kommunePresentation[index].navn}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(Icons.done, color: PrimaryColor),
                          ],
                        ),
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //TODO design senere
                                Text(
                                    "Jegernummer ${model.registerPresentation[index].jegernummer}"),
                                Text(
                                    "Antall jegere ${model.registerPresentation[index].antallJegere}"),
                                Text(
                                    "Kommune ${model.registerPresentation[index].kommunenavn}"),
                                //Grågås
                                Row(
                                  children: [
                                    Image.asset('images/gragas.png',
                                        height: 30, width: 30, fit: BoxFit.cover),
                                    Text("${model.registerPresentation[index].gragas}")
                                  ],
                                ),
                                //Kanadagås
                                Row(
                                  children: [
                                    Image.asset('images/kanadagas.png',
                                        height: 30, width: 30, fit: BoxFit.cover),
                                    Text("${model.registerPresentation[index].kanadaGas}")
                                  ],
                                ),
                                //kortnebbgås
                                Row(
                                  children: [
                                    Image.asset('images/kortnebbgas.png',
                                        height: 30, width: 30, fit: BoxFit.cover),
                                    Text("${model.registerPresentation[index].kortnebbgas}")
                                  ],
                                ),


                              ])
                        ],
                        // onTap: () {
                        //   //setState to update Placeholder selected kommune
                        //   setState(() {
                        //     // model.setKommune(index);
                        //   });
                        // },
                      ),
                    );
                  },
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ColumnSpacer(spacing: 19, children: [
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child:
                          Image.asset('images/gragas.png', fit: BoxFit.cover)),
                  Expanded(
                      child: Image.asset('images/kanadagas.png',
                          fit: BoxFit.cover)),
                  Expanded(
                      child: Image.asset('images/kortnebbgas.png',
                          fit: BoxFit.cover)),
                ]),
            //
          ]),
          new Expanded(child: buildListView(model))
        ]));
  }
}
