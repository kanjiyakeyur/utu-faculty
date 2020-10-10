import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:utu_faculty/provider/faculty.dart';
import '../provider/notification.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class AddNotificationScreen extends StatefulWidget {
  static const routeName = '/addnotification';

  @override
  _AddNotificationScreenState createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen>
    with TickerProviderStateMixin {
  Map<String, String> _formData = {
    'title': '',
    'description': '',
    'department': '',
    'course': '',
    'divison': '',
    'batch': '',
    'expiredate': '',
    'link': '',
  };

  //this for update notification
  bool _argumentDataFatch = false;
  DateTime _oldSendDate;
  String _notificationID;
  setdata(NotificationType data) {
    if (_argumentDataFatch == false) {
      _formData['title'] = data.title;
      _formData['description'] = data.discription;
      _selectedDepartment = data.department.department;
      _selectedCourse = data.department.course;
      _selectedDivison = data.department.divison;
      _selectedBatch = data.department.batch;
      _oldSendDate = data.datetime;
      _notificationID = data.id;
      if (data.expiredate != 'EmptyLastDate123') {
        expiredate = DateTime.parse(data.expiredate);
      }
      if (data.link != 'EmptyLink123') {
        _formData['link'] = data.link;
      }
      _argumentDataFatch = true;
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation =
        Tween<double>(begin: 0.0, end: 500).animate(animationController);
    animationController.forward();
  }

  final _sendFocuse = FocusNode();
  final _descriptionFocuse = FocusNode();
  final _savebutton = FocusNode();
  var _isloding = false;
  DateTime expiredate;

  Future<void> _showErrorDialog(String errorMessage) async {
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('A error Occoured !!'),
              content: Text(errorMessage),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('Ohky'),
                )
              ],
            ));
  }

  Future<void> checkTheDepartmets() async {
    var error = '';
    if (_selectedDepartment.isEmpty) {
      error = 'Please select Department';
    } else if (_selectedCourse.isEmpty) {
      error = 'Please select Course';
    } else if (_selectedDivison.isEmpty) {
      error = 'Please select Divison';
    } else if (_selectedCourse.isEmpty) {
      error = 'Please select Course';
    } else {
      _formData['department'] = _selectedDepartment;
      _formData['course'] = _selectedCourse;
      _formData['divison'] = _selectedDivison;
      _formData['batch'] = _selectedBatch;
      return;
    }
    throw error;
  }

  Future<void> _saveform(String uid, String uName) async {
    setState(() {
      _isloding = true;
    });
    var valid = _formKey.currentState.validate();
    if (!valid) {
      setState(() {
        _isloding = false;
      });
      return;
    }
    _formKey.currentState.save();
    //last date edit

    if (expiredate == null) {
      _formData['expiredate'] = 'EmptyLastDate123';
    } else {
      _formData['expiredate'] = expiredate.toIso8601String();
    }
    //check for link
    if (_formData['link'] == '') {
      _formData['link'] = 'EmptyLink123';
    }

    try {
      await checkTheDepartmets();
      if (!_argumentDataFatch) {
        await Provider.of<UtuNotification>(context, listen: false)
            .sendNotification(
          title: _formData['title'],
          description: _formData['description'],
          department: _formData['department'],
          course: _formData['course'],
          divison: _formData['divison'],
          batch: _formData['batch'],
          userid: uid,
          userName: uName,
          expiredate: _formData['expiredate'],
          link: _formData['link'],
        );
      } else {
        await Provider.of<UtuNotification>(context, listen: false)
            .updateNotification(
          id: _notificationID,
          title: _formData['title'],
          description: _formData['description'],
          department: _formData['department'],
          course: _formData['course'],
          divison: _formData['divison'],
          batch: _formData['batch'],
          userid: uid,
          userName: uName,
          expiredate: _formData['expiredate'],
          link: _formData['link'],
          oldSendDate: _oldSendDate,
        );
      }
      setState(() {
        _isloding = false;
      });
      Navigator.pop(context);
    } on PlatformException catch (error) {
      _showErrorDialog(error.message);
      setState(() {
        _isloding = false;
      });
    } catch (error) {
      _showErrorDialog(error.toString());
      setState(() {
        _isloding = false;
      });
    }
  }

  //for all
  //var _all = ['All'];

  //Department
  var _selectedDepartment = '';
  List<String> _department = [
    'All',
    'Engineering',
    'Bsc',
    'Pharmacy',
    'MicroBio'
  ];

  //course
  var _selectedCourse = '';
  bool _disableCourse = true;
  List<DropdownMenuItem<String>> _course = List();

  var _engineering = ['All', 'IT', 'CO', 'EC', 'EE', 'MC'];
  var _bsc = ['All', 'Maths', 'Physic', 'Chemestry'];

  //divison
  var _selectedDivison = '';
  bool _disableDivison = true;
  List<DropdownMenuItem<String>> _divison = List();

  var _engineeringIt = ['All', 'A', 'B'];
  var _engineeringCo = ['All', 'A', 'B', 'c'];
  var _bscMath = ['All', 'A', 'B'];

  //for batch
  var _selectedBatch = '';
  bool _disableBatch = true;
  List<DropdownMenuItem<String>> _batch = List();
  var _forALLbatch = ['All', '1', '2', '3'];

  //for create new dropDown
  void newDropWonItem(var _list, addableList) {
    _list
        .map((e) =>
            addableList.add(DropdownMenuItem<String>(value: e, child: Text(e))))
        .toList();
  }

  //select department
  void onSelectDepartment(_value) {
    if (_value == 'All') {
      _course = [];
      _selectedCourse = 'All';
      _divison = [];
      _selectedDivison = 'All';
      _batch = [];
      _selectedBatch = 'All';
      //newDropWonItem(_all,_course);
    } else if (_value == 'Engineering') {
      _course = [];
      newDropWonItem(_engineering, _course);
    } else if (_value == 'Bsc') {
      _course = [];
      newDropWonItem(_bsc, _course);
    } else {
      _course = [];
    }
    if (_value == 'All') {
      setState(() {
        _selectedDepartment = _value;
      });
    } else {
      setState(() {
        _selectedDepartment = _value;
        _selectedCourse = '';
        _disableCourse = false;
        _selectedDivison = '';
        _disableDivison = true;
        _selectedBatch = '';
        _disableBatch = true;
      });
    }
  }

  void onSelectCourse(_value) {
    if (_value == 'All') {
      _divison = [];
      _selectedDivison = 'All';
      _batch = [];
      _selectedBatch = 'All';
      //newDropWonItem(_all, _divison);
    } else if (_value == 'IT') {
      _divison = [];
      newDropWonItem(_engineeringIt, _divison);
    } else if (_value == 'CO') {
      _divison = [];
      newDropWonItem(_engineeringCo, _divison);
    } else if (_value == 'Maths') {
      _divison = [];
      newDropWonItem(_bscMath, _divison);
    } else {
      _divison = [];
    }
    if (_value == 'All') {
      setState(() {
        _selectedCourse = _value;
      });
    } else {
      setState(() {
        _selectedCourse = _value;
        _selectedDivison = '';
        _disableDivison = false;
        _selectedBatch = '';
        _disableBatch = true;
      });
    }
  }

  void onSelectDivison(_value) {
    if (_value == 'All') {
      _batch = [];
      _selectedBatch = 'All';
    } else {
      _batch = [];
      newDropWonItem(_forALLbatch, _batch);
    }
    if (_value == 'All') {
      setState(() {
        _selectedDivison = _value;
      });
    } else {
      setState(() {
        _selectedDivison = _value;
        _selectedBatch = '';
        _disableBatch = false;
      });
    }
  }

  void onSelectBatch(_value) {
    setState(() {
      _selectedBatch = _value;
    });
  }

  FocusNode _titlefocusNode = FocusNode();
  Color color;

  @override
  void dispose() {
    _sendFocuse.dispose();
    _descriptionFocuse.dispose();
    _savebutton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    removeAllFocus() {
      FocusScope.of(context).unfocus();
    }

    if (ModalRoute.of(context).settings.arguments != null) {
      final NotificationType arguments =
          ModalRoute.of(context).settings.arguments as NotificationType;
      setdata(arguments);
    }

    _titlefocusNode.addListener(() {
      setState(() {
        color = _titlefocusNode.hasFocus ? Colors.blue : Colors.red;
      });
    });
    _descriptionFocuse.addListener(() {
      setState(() {
        color = _descriptionFocuse.hasFocus ? Colors.blue : Colors.grey;
      });
    });

    final currentUser = Provider.of<Faculty>(context, listen: false).details;
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        centerTitle: true,
        title: Text(
          'Announcement',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.indigo.shade700),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ScaleTransition(
            scale: animationController,
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.purple[50],
            ),
          ),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      focusNode: _titlefocusNode,
                      decoration: InputDecoration(
                        labelText: 'title',
                        labelStyle: TextStyle(
                          color: _titlefocusNode.hasFocus
                              ? Colors.indigo
                              : Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.indigo, width: 2.0),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      initialValue:
                          _formData['title'] != '' ? _formData['title'] : null,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter title';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocuse);
                      },
                      onSaved: (value) {
                        _formData['title'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'description',
                        labelStyle: TextStyle(
                          color: _descriptionFocuse.hasFocus
                              ? Colors.indigo
                              : Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.indigo, width: 2.0),
                        ),
                      ),
                      maxLines: null,
                      minLines: 2,
                      initialValue: _formData['description'] != ''
                          ? _formData['description']
                          : null,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocuse,
                      //textInputAction: TextInputAction.co,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter description';
                        }
                        return null;
                      },

                      onFieldSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      onSaved: (value) {
                        _formData['description'] = value;
                      },
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_selectedDepartment.isEmpty
                            ? 'Select Department '
                            : _selectedDepartment),
                        DropdownButton(
                          items: _department
                              .map((e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: new Text(e),
                                  ))
                              .toList(),
                          //focusNode: _selectDepartmentFocuse,
                          hint: Text('Select Department'),
                          //value: selectedDepartment,
                          //isExpanded: true,
                          onChanged: (String value) {
                            FocusScope.of(context).requestFocus(_savebutton);
                            onSelectDepartment(value);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_selectedCourse.isEmpty
                            ? 'Select Course '
                            : _selectedCourse),
                        DropdownButton(
                            items: _course,

                            //isExpanded: true,
                            //value: selectedCourse,
                            hint: Text('Select Course'),
                            disabledHint: _selectedCourse.isEmpty
                                ? Text('first Select Department')
                                : Text('---'),
                            onChanged: _disableCourse
                                ? null
                                : (String value) {
                                    onSelectCourse(value);
                                  }),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_selectedDivison.isEmpty
                            ? 'Select Divison'
                            : _selectedDivison),
                        DropdownButton(
                            items: _divison,
                            hint: Text('Select Divison'),
                            disabledHint: _selectedDivison.isEmpty
                                ? Text('first Select Course')
                                : Text('---'),
                            onChanged: _disableDivison
                                ? null
                                : (String value) {
                                    onSelectDivison(value);
                                  })
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_selectedBatch.isEmpty
                            ? 'Select Divison'
                            : _selectedBatch),
                        DropdownButton(
                            items: _batch,
                            hint: Text('Select Batch'),
                            disabledHint: _selectedBatch.isEmpty
                                ? Text('first Select Divison')
                                : Text('---'),
                            onChanged: _disableBatch
                                ? null
                                : (String value) {
                                    onSelectBatch(value);
                                  })
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    Text('Optional Fields'),
                    Divider(),
                    Row(
                      children: [
                        Text('Expire Date   : '),
                        SizedBox(
                          width: 40,
                        ),
                        Flexible(
                          child: DateTimeField(
                            format: DateFormat("dd/MM/yyyy hh:mm a"),
                            decoration: InputDecoration(
                              labelText: 'Selete Date & Time',
                            ),
                            initialValue:
                                _argumentDataFatch ? expiredate : null,
                            onChanged: (value) {
                              expiredate = value;
                            },
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  helpText: 'Select Date',
                                  context: context,
                                  firstDate: DateTime.now(),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 1000)));
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );

                                expiredate = DateTimeField.combine(date, time);
                                return expiredate;
                              } else {
                                return currentValue;
                              }
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.link),
                        Text('  Link  :  '),
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.indigo, width: 2.0),
                              ),
                            ),
                            maxLines: null,
                            minLines: 1,
                            initialValue: _formData['link'] != ''
                                ? _formData['link']
                                : null,
                            keyboardType: TextInputType.multiline,
                            onSaved: (value) {
                              _formData['link'] = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    _isloding
                        ? CircularProgressIndicator()
                        : Hero(
                            tag: 'button',
                            child: RaisedButton.icon(
                                padding: EdgeInsets.only(
                                    top: 10.0, bottom: 10, left: 10, right: 10),
                                focusNode: _savebutton,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.indigo.shade400,
                                elevation: 0,
                                icon: Icon(
                                  Icons.near_me,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Conform !',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 3),
                                ),
                                onPressed: () {
                                  removeAllFocus();
                                  _saveform(
                                      currentUser['uid'], currentUser['name']);
                                }),
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
