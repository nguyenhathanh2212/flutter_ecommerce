import 'package:flutter/material.dart';
import 'product_detail.dart';
import 'package:simple_app_ecommerce/src/models/item.dart';
import 'package:simple_app_ecommerce/src/blocs/item_bloc.dart';

class GridViewProduct extends StatefulWidget {
  GridViewProduct({@required this.scrollController, @required this.serviceId});
  ScrollController scrollController;
  int serviceId;

  @override
  State<StatefulWidget> createState() => GridViewProductState();
}

class GridViewProductState extends State<GridViewProduct> {
  @override
  void initState() {
    itemBloc.getItemByServiceId(widget.serviceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Container(
        child: StreamBuilder(
          stream: itemBloc.itemStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildGridViewItems(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget buildGridViewItems(snapshot) {
    return GridView.builder(
      controller: widget.scrollController,
      itemCount: snapshot.data.results.length,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  color: Colors.black12,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Hero(
                        tag: 'image-product-${snapshot.data.results[index].id}',
                        child: Image(
                          image: AssetImage('assets/images/product.jpg'),
                          height: MediaQuery.of(context).size.width / 2 * 1.1,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetail(snapshot.data.results[index]))
                  );
                },
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Text(
                        snapshot.data.results[index].name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      '\$10.00',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.star, size: 13, color: Colors.cyan,),
                              Icon(Icons.star_border, size: 13, color: Colors.cyan,),
                              Icon(Icons.star_border, size: 13, color: Colors.cyan,),
                              Icon(Icons.star_border, size: 13, color: Colors.cyan,),
                              Icon(Icons.star_border, size: 13, color: Colors.cyan,),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_cart),
                          iconSize: 18,
                          color: Colors.red,
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
