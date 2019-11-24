import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_app_ecommerce/src/ui/home/grid_view_product.dart';
import 'app_bar_custom.dart';
import 'grid_view_product.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../blocs/service_bloc.dart';
import '../../blocs/item_bloc.dart';

class MainHome extends StatefulWidget {
//  Map<String, Widget> listWidgetViewProduct = Map<String, Widget>();
  @override
  State<StatefulWidget> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;
  int _idServiceActive;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        changeStatusAppBar(false);
      }

      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        changeStatusAppBar(true);
      }
    });

    serviceBloc.getServices();
    super.initState();
  }

  void changeStatusAppBar(status) {
    setState(() {
      _showAppBar = status;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarCustom(showAppBar: _showAppBar),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _idServiceActive = null;
                  itemBloc.getItemByServiceId(null);
                });
              },
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 8, left: 5),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
                ),
                height: 90,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        border: Border.all(color: Colors.orangeAccent, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Container(
                            margin: EdgeInsets.only(top: 3),
                            child: Column(
                              children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                ),
                                height: 50,
                                width: 50,
                                child: Icon(
                                    Icons.home,
                                  color: Colors.green,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      'Home',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    )
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: serviceBloc.serviceStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return buildListViewServices(snapshot);
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }

                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                  ],
                )
              ),
            ),
            GridViewProduct(scrollController: _scrollController, serviceId: _idServiceActive)
          ],
        ),
      ),
    );
  }

  Widget buildListViewServices(snapshot) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.results.length,
        itemBuilder: (context, index) {
          return Container(
              constraints: BoxConstraints(
                  minWidth: 80
              ),
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.only(top: 3),
              child: Column(
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 50,
                    height: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: SvgPicture.network(
                        snapshot.data.results[index].iconUrl,
                        height: 25,
                      ),
                      color: _idServiceActive == snapshot.data.results[index].id ? Colors.white12 : Colors.white,
                      onPressed: () {
                        setState(() {
                          _idServiceActive = snapshot.data.results[index].id;
                          itemBloc.getItemByServiceId(snapshot.data.results[index].id);
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          snapshot.data.results[index].name,
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        )
                    ),
                  ),
                ],
              )
          );
        }
    );
  }
}
