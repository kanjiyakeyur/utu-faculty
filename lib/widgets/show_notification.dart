import 'package:flutter/material.dart';
import 'package:utu_faculty/screens/add_notification_screen.dart';
import '../provider/notification.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../screens/home_screen.dart' as a;

class ShowNotification extends StatefulWidget {
  final NotificationType data;
  final bool filter;
  final a.FilterList selectedFilter;

  ///final String title;
  //final String description;

  ShowNotification(
      {@required this.data,
      @required this.filter,
      @required this.selectedFilter});

  @override
  _ShowNotificationState createState() => _ShowNotificationState();
}

class _ShowNotificationState extends State<ShowNotification> {
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

  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    //for expiredate for ntification
    final bool _isEmptyDate =
        widget.data.expiredate == 'EmptyLastDate123' ? true : false;
    DateTime _expiredate;
    bool _dateExpireOrNot = false;
    if (!_isEmptyDate) {
      _expiredate = DateTime.parse(widget.data.expiredate);
      _dateExpireOrNot = _expiredate.isBefore(DateTime.now()) ? true : false;
    }

    //for link for notification
    final bool _isLinkEmpty = widget.data.link == 'EmptyLink123' ? true : false;
    _launchUrl() async {
      var url = widget.data.link;
      await launch(url);
    }

    bool _showable = true;
    if (widget.filter) {
      if (widget.selectedFilter == a.FilterList.Current) {
        !_dateExpireOrNot ? _showable = true : _showable = false;
      } else if (widget.selectedFilter == a.FilterList.CurrentWithOutExpired) {
        _isEmptyDate ? _showable = true : _showable = false;
      } else if (widget.selectedFilter == a.FilterList.CurrenyWithExpire) {
        _isEmptyDate
            ? _showable = false
            : !_dateExpireOrNot ? _showable = true : _showable = false;
      } else if (widget.selectedFilter == a.FilterList.Expired) {
        _dateExpireOrNot ? _showable = true : _showable = false;
      }
    }

    //print(widget.data);
    return !_showable
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: Dismissible(
              key: ValueKey(widget.data.id),
              background: Container(
                  //color : Theme.of(context).errorColor,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red),
                  child:
                      Icon(Icons.delete_sweep, color: Colors.white, size: 40),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  margin: EdgeInsets.all(5)),
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) {
                return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Are you sure ?'),
                          content: Text('do you want to remove Announcement ?'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text('No!')),
                            FlatButton(
                                onPressed: () async {
                                  try {
                                    await Provider.of<UtuNotification>(context,
                                            listen: false)
                                        .removeNotification(widget.data);
                                    Navigator.of(context).pop(true);
                                  } catch (error) {
                                    await _showErrorDialog(error.toString());
                                    Navigator.of(context).pop(false);
                                  }
                                },
                                child: Text('Yes')),
                          ],
                        ));
              },
              child: Wrap(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                    child: Card(
                      elevation: 4,
                      color: _isEmptyDate
                          ? Colors.orange[50]
                          : _dateExpireOrNot
                              ? Colors.red[50]
                              : Colors.green[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              widget.data.title.toString(),
                              style: TextStyle(
                                  color: _isEmptyDate
                                      ? Colors.orange
                                      : _dateExpireOrNot
                                          ? Colors.red
                                          : Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            subtitle: Text(
                              widget.data.discription,
                              //softWrap: true,
                              overflow:
                                  !_expanded ? TextOverflow.ellipsis : null,
                            ),
                            trailing: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: _dateExpireOrNot
                                      ? Colors.grey
                                      : Colors.indigo.shade400,
                                ),
                                onPressed: _dateExpireOrNot
                                    ? null
                                    : () {
                                        Navigator.of(context).pushNamed(
                                            AddNotificationScreen.routeName,
                                            arguments: widget.data);
                                      }),
                          ),
                          _expanded
                              ? Container(
                                  padding: EdgeInsetsDirectional.only(
                                      bottom: 10, start: 17),
                                  child: Column(
                                    children: <Widget>[
                                      if (!_isLinkEmpty)
                                        Container(
                                          padding: EdgeInsets.only(right: 15),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: GestureDetector(
                                                    onTap: () => _launchUrl(),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: 'Link : ',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text: widget
                                                                .data.link,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .lightBlue,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.content_copy),
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: widget
                                                              .data.link));
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                      "URL Copied to Clipboard",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      if (!_isLinkEmpty)
                                        SizedBox(
                                          height: 10,
                                        ),
                                      Container(
                                        padding: EdgeInsets.only(right: 25),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Location : ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: widget
                                                          .data
                                                          .department
                                                          .department,
                                                    ),
                                                    TextSpan(
                                                      text: ' > ',
                                                    ),
                                                    TextSpan(
                                                      text: widget.data
                                                          .department.course,
                                                    ),
                                                    TextSpan(
                                                      text: ' > ',
                                                    ),
                                                    TextSpan(
                                                      text: widget.data
                                                          .department.divison,
                                                    ),
                                                    TextSpan(
                                                      text: ' > ',
                                                    ),
                                                    TextSpan(
                                                      text: widget.data
                                                          .department.batch,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text('by : ${widget.data.by}')
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  'Send Date : ${DateFormat('dd/MM/yyyy hh:mm a').format(widget.data.datetime)}',
                                                  style: TextStyle(
                                                      color: Colors.black26),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                _isEmptyDate
                                                    ? Container()
                                                    : Text(
                                                        'Expire Date : ${DateFormat('dd/MM/yyyy hh:mm a').format(_expiredate)}',
                                                        style: TextStyle(
                                                          color: _dateExpireOrNot
                                                              ? Theme.of(
                                                                      context)
                                                                  .errorColor
                                                              : Colors.black26,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
