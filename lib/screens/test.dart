import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final format = DateFormat("yyyy-MM-dd HH:mm a");

  DateTime ddate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        SizedBox(
          height: 300,
        ),
        Text('Basic date & time field (${format.pattern})'),
        DateTimeField(
          format: DateFormat("dd-MM-yyyy HH:mm a"),
          onSaved: (newValue) {
            ddate = newValue;
          },
          onFieldSubmitted: (value) {},
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              setState(() {
                ddate = DateTimeField.combine(date, time);
              });
              return ddate;
            } else {
              return currentValue;
            }
          },
        ),
        Text(ddate.toString()),
        RaisedButton(
          onPressed: () {},
          child: Text('done'),
        )
      ]),
    );
  }
}
