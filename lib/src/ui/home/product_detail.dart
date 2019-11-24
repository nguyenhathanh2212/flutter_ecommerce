import 'package:flutter/material.dart';
import 'package:simple_app_ecommerce/src/models/item.dart';

class ProductDetail extends StatefulWidget {
  Item itemProduct;
  ProductDetail(this.itemProduct);
  @override
  State<StatefulWidget> createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  int _value = 1;
  bool _showDescription = true;
  bool _showReview = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.orangeAccent,
                expandedHeight: MediaQuery.of(context).size.width * 1.2,
                floating: true,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
//                    tag: 'image-product-',//${widget.itemProduct.id}
                    child: Container(
                      child: Image(
                        image: AssetImage('assets/images/product.jpg'),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 1.2,
                        fit: BoxFit.scaleDown,
                      ),
                      color: Colors.grey[400],
                    ),
                  ),
                ),

              )
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'widget.itemProduct.name',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      '\$50.00',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.star, size: 16, color: Colors.cyan,),
                            Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                            Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                            Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                            Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: RaisedButton(
                          color: Colors.cyan[300],
                          child: Text(
                            'ADD TO CART',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.cyan[100]),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        margin: const EdgeInsets.only(left: 16, right: 8),
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        width: 60,
                        height: 40,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: _value,
                            items: <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                            onChanged: (int newValue) {
                              setState(() {
                                _value = newValue;
                              });
                            },
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 0),
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 0.3, color: Colors.grey[400]),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            padding: EdgeInsets.all(2),
                            icon: Icon(
                                _showDescription ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                color: Colors.grey[600]
                            ),
                            onPressed: () {
                              setState(() {
                                _showDescription = !_showDescription;
                              });
                            },
                          ),
                        )
                      ],
                    )
                  ),
                  Visibility(
                    visible: _showDescription,
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 0.3, color: Colors.grey[400]),
                        ),
                      ),
                      padding: EdgeInsets.only(left: 25, top: 15, bottom: 15),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '• Description detail',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            '• Description detail',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 0, bottom: 0),
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 0.3, color: Colors.grey[400]),
                          bottom: BorderSide(width: 0.3, color: Colors.grey[400]),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Read Reviews',
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: IconButton(
                              padding: EdgeInsets.all(2),
                              icon: Icon(
                                  _showReview ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                  color: Colors.grey[600]
                              ),
                              onPressed: () {
                                setState(() {
                                  _showReview = !_showReview;
                                });
                              },
                            ),
                          )
                        ],
                      )
                  ),
                  Visibility(
                    visible: _showReview,
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 0.3, color: Colors.grey[300]),
                          bottom: BorderSide(width: 0.3, color: Colors.grey[300]),
                        ),
                      ),
                      padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.3, color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Jane',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Text(
                                    'I love it',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '16:04 22/12/1995',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.star, size: 16, color: Colors.cyan,),
                                          Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                                          Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                                          Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                                          Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.3, color: Colors.grey[400]),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Jane',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Text(
                                    'I love it',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '16:04 22/12/1995',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.star, size: 16, color: Colors.cyan,),
                                          Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                                          Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                                          Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                                          Icon(Icons.star_border, size: 16, color: Colors.cyan,),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
