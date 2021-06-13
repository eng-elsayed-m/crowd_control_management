import '../app_localizations.dart';
import 'package:flutter/material.dart';

class LabScreen extends StatefulWidget {
  static const navN = "lab-screen";

  @override
  _LabScreenState createState() => _LabScreenState();
}

String _date;

class _LabScreenState extends State<LabScreen> {
  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context).translate;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          trans("Analytics Lab"),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  color: Theme.of(context).primaryColorLight,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      trans("Note"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: _date == null
                        ? ListTile(
                            leading: ElevatedButton(
                                onPressed: () async {
                                  DateTimeRange _range =
                                      await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate:
                                        DateTime.now().add(Duration(days: 7)),
                                  );

                                  setState(() {
                                    _date = _range.start
                                            .toString()
                                            .split(" ")
                                            .first +
                                        " to " +
                                        _range.end.toString().split(" ").first;
                                  });
                                  await showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                            elevation: 0,
                                            actionsOverflowDirection:
                                                VerticalDirection.up,
                                            backgroundColor: Colors.transparent,
                                            content: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.check,
                                                    color:
                                                        Colors.lightGreenAccent,
                                                    size: 40,
                                                  ),
                                                  Text(
                                                      "The doctor will arrive with you during the specified period Between $_date, make sure you are at home at the time .",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: Text("Thanks",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)))
                                                ]),
                                          ));
                                },
                                child: Text(trans("Book"))),
                            trailing: Text(
                              "Request examination",
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "The doctor will arrive with you during the specified period Between $_date, make sure you are at home at the time .",
                            ),
                          )),
                Card(
                    elevation: 8,
                    color: Colors.cyan[100],
                    child: ListTile(
                      leading: ElevatedButton(
                          onPressed: () {}, child: Text(trans("Get"))),
                      trailing: Text(trans("Receive analysis result")),
                    )),
              ],
            ),
          ),
          Expanded(
              child: Center(
            child: Image.asset(
              "assets/images/ccm_logo.png",
              fit: BoxFit.contain,
            ),
          ))
        ],
      ),
    );
  }
}
