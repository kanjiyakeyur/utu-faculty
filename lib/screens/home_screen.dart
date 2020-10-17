import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../screens/add_notification_screen.dart';
import './drawer_screen.dart';
import '../provider/notification.dart';
import '../widgets/show_notification.dart';
import 'package:provider/provider.dart';
import '../provider/faculty.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum FilterList {
  All,
  Expired,
  CurrentWithOutExpired,
  CurrenyWithExpire,
  Current,
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _filter = false;
  FilterList _selectedFilter = FilterList.All;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    //final fatchOrNot =
    //    Provider.of<UtuNotification>(context, listen: false).fatchedData;
    final userUid = Provider.of<Faculty>(context).userid;
    return Scaffold(
      // appBar: AppBar(
      //     elevation: 0,
      //     title: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.baseline,
      //       textBaseline: TextBaseline.ideographic,
      //       children: <Widget>[
      //         Text(
      //           'UTU ',
      //           style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               fontSize: 28,
      //               color: Colors.indigo.shade700),
      //         ),
      //         //SizedBox(width: 5,),
      //         Text(
      //           'Faculty',
      //           style: TextStyle(
      //               //fontWeight: FontWeight.bold,
      //               fontSize: 20,
      //               color: Colors.black54),
      //         ),
      //       ],
      //     ),
      //     centerTitle: true,
      //     actions: <Widget>[
      //       PopupMenuButton(
      //         icon: Icon(Icons.filter_list),
      //         onSelected: (FilterList value) {
      //           if (FilterList.All == value) {
      //             setState(() {
      //               _filter = false;
      //             });
      //           } else if (value == FilterList.Current) {
      //             setState(() {
      //               _filter = true;
      //               _selectedFilter = FilterList.Current;
      //             });
      //           } else if (value == FilterList.CurrenyWithExpire) {
      //             setState(() {
      //               _filter = true;
      //               _selectedFilter = FilterList.CurrenyWithExpire;
      //             });
      //           } else if (value == FilterList.CurrentWithOutExpired) {
      //             setState(() {
      //               _filter = true;
      //               _selectedFilter = FilterList.CurrentWithOutExpired;
      //             });
      //           } else if (value == FilterList.Expired) {
      //             setState(() {
      //               _filter = true;
      //               _selectedFilter = FilterList.Expired;
      //             });
      //           }
      //         },
      //         itemBuilder: (_) => [
      //           PopupMenuItem(
      //             child: Text('All'),
      //             value: FilterList.All,
      //           ),
      //           PopupMenuItem(
      //             child: Text('Current'),
      //             value: FilterList.Current,
      //           ),
      //           PopupMenuItem(
      //             child: Text('Current With Expire'),
      //             value: FilterList.CurrenyWithExpire,
      //           ),
      //           PopupMenuItem(
      //             child: Text('Current Without Expire'),
      //             value: FilterList.CurrentWithOutExpired,
      //           ),
      //           PopupMenuItem(
      //             child: Text('Expired'),
      //             value: FilterList.Expired,
      //           )
      //         ],
      //       ),
      //     ]),

      drawer: DrawerScreen(HomeScreen.routeName),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                PopupMenuButton(
                  icon: Icon(
                    Icons.filter_list,
                  ),
                  onSelected: (FilterList value) {
                    if (FilterList.All == value) {
                      setState(() {
                        _filter = false;
                      });
                    } else if (value == FilterList.Current) {
                      setState(() {
                        _filter = true;
                        _selectedFilter = FilterList.Current;
                      });
                    } else if (value == FilterList.CurrenyWithExpire) {
                      setState(() {
                        _filter = true;
                        _selectedFilter = FilterList.CurrenyWithExpire;
                      });
                    } else if (value == FilterList.CurrentWithOutExpired) {
                      setState(() {
                        _filter = true;
                        _selectedFilter = FilterList.CurrentWithOutExpired;
                      });
                    } else if (value == FilterList.Expired) {
                      setState(() {
                        _filter = true;
                        _selectedFilter = FilterList.Expired;
                      });
                    }
                  },
                  offset: Offset(-100, 70),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Text('All'),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.orange,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      value: FilterList.All,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Text('Current'),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.orange,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      value: FilterList.Current,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Text('Current With Expire'),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.green,
                          )
                        ],
                      ),
                      value: FilterList.CurrenyWithExpire,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Text('Current Without Expire'),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.orange,
                          ),
                        ],
                      ),
                      value: FilterList.CurrentWithOutExpired,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Text('Expired'),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.red,
                          ),
                        ],
                      ),
                      value: FilterList.Expired,
                    )
                  ],
                ),
              ],
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              expandedHeight: 150.0,
              floating: true,
              pinned: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.asset(
                    'assets/images/background.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: <Widget>[
                    Text(
                      'UTU ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.indigo.shade700),
                    ),
                    //SizedBox(width: 5,),
                    Text(
                      'Faculty',
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black54),
                    ),
                  ],
                ),
                // background: Image.network(
                //   "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                //   fit: BoxFit.cover,
                // )
              ),
            ),
          ];
        },
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('notification')
              .orderBy('datetime')
              .where('byid', isEqualTo: userUid)
              .snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final d = snapshot.data.documents;
            final data = d.reversed.toList();
            if (data.length == 0) {
              return Center(
                child: Text('Empty'),
              );
            }
            // animationController.forward();
            return AnimationLimiter(
              child: ListView.builder(
                itemCount: data.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (ctx, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: ShowNotification(
                          filter: _filter,
                          selectedFilter: _selectedFilter,
                          data: NotificationType(
                            id: data[index].documentID,
                            title: data[index]['title'],
                            discription: data[index]['description'],
                            datetime: DateTime.parse(data[index]['datetime']),
                            department: UtuDepartment(
                              department: data[index]['location']['department'],
                              course: data[index]['location']['course'],
                              divison: data[index]['location']['divison'],
                              batch: data[index]['location']['batch'],
                            ),
                            by: data[index]['by'],
                            byid: data[index]['byid'],
                            expiredate: data[index]['expiredate'],
                            link: data[index]['link'],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Hero(
        tag: 'button',
        child: RaisedButton.icon(
            padding:
                EdgeInsets.only(top: 10.0, bottom: 10, left: 10, right: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.indigo.shade400,
            elevation: 0,
            label: Text(
              'Notice',
              style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w300),
            ),
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 17,
            ),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        AddNotificationScreen(),
                    transitionDuration: Duration(milliseconds: 800),
                    transitionsBuilder:
                        (context, animation, anotherAnimation, child) {
                      animation = CurvedAnimation(
                          curve: Curves.linear, parent: animation);
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    }),
              );
            }),
      ),
    );
  }
}
