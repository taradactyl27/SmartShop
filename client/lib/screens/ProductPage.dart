import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import './MainCart.dart';
import '../util/ProductJsonMapper.dart';
import '../util/RequestBuilder.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ProductPage extends StatefulWidget{
  final String product_id;
  List<Map<String,int>> productIds = [];
  List<Product> products = [Product("", [0,0,0,0,0], "", "", "", "", 0.0)];
  ProductPage({Key key, @required this.product_id, @required this.productIds}) : super(key: key);
  @override
  _ProductPage createState()=>_ProductPage();

}

class _ProductPage extends State<ProductPage>{
  @override
  void initState() {
    String product_id = widget.product_id != null ? widget.product_id : "";
    List<Map<String,int>> productIds= widget.productIds != null ? widget.productIds : [];
    if(product_id != null){
      print("CHIEF KEEF");
      List<Product> tempProductList;
      Future<http.Response> queriedProducts = RequestBuilder.getItemsFromIdArray([product_id]);
      queriedProducts.then((value) => {
        setState(() {widget.products = ProductJsonMapper.fromJsonArray(jsonEncode(jsonDecode(value.body)["data"]));}),
        //tempProductList = ProductJsonMapper.fromJsonArrayV2(value.body)
        print("WIDGET DECODED"),
      });
      super.initState();
      //return tempProductList;
      }
  }
  int photoIndex = 0;
  int pickedSize = 0;
  List<String> photos = [];
  List picked = [true, false, false, false, false ];
  int previousPicked = 0;
  List<String> sizes = ['XS','S','M','L','XL'];
  List<Product> generateProducts(String id) {
       print("GENERATING PRODUCTS: ");
      print(id); 
      
  }
  void cartHandler() {
    print(this.widget.productIds);
    this.widget.productIds.add({this.widget.product_id: pickedSize});
    print(this.widget.productIds[this.widget.productIds.length-1]);
    Navigator.pushReplacement(
        context, MaterialPageRoute(
          builder: (context) => MainCart(productIdsList: this.widget.productIds))
        );
  }
  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
    });
  }
  void pickToggle(index) {
    setState(() {
      picked[previousPicked] = !picked[previousPicked];
      picked[index] = !picked[index];
      pickedSize = index;
      previousPicked = index;
    });
  }
  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }
  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                
                Container(
                  height: 275.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: widget.products != null ? AssetImage("assets/" + widget.products[0].picture) : "",
                          fit: BoxFit.contain)),
                ),
                GestureDetector(
                  child: Container(
                    height: 275.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                  ),
                  onTap: _nextImage,
                ),
                GestureDetector(
                  child: Container(
                    height: 275.0,
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.transparent,
                  ),
                  onTap: _previousImage,
                ),
                Positioned(
                top: 25,
                left: 10,
                child: IconButton(
                    alignment: Alignment.topLeft,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
                Positioned(
                    top: 240.0,
                    left: MediaQuery.of(context).size.width / 2 - 30.0,
                    child: Row(
                      children: <Widget>[
                        SelectedPhoto(

                          numberOfDots: photos.length,
                          photoIndex: photoIndex,
                        )
                      ],
                    ))
              ],
            ),
            Container(
                height: 450,
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: WaveClipperTwo(),
                      child: Container(
                        height: 115.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0)),
                          gradient: LinearGradient(
                          colors: [
                            //Color(0xFF80F9B7),
                            //Color(0xFF9ABDEB),
                            Color(0x99FC7B7B),
                            Color(0x99A6C1FF),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                 ),
                ),
                  ),
                    ),
                  Positioned(
                  top: 20,
                  left: 15,
                     child: Text(
                        'SKU: ' + '2',
                        style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 15.0,
                        color: Colors.white
                        )
                     ),
                ),
                 Positioned(
                    top: 45,
                    left: 15,
                    child: Text(widget.products[0].name,
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                Positioned(
                  top: 105,
                  left: 15,
                   child: Row(
                      children: <Widget>[
                        Container(
                          width: (MediaQuery.of(context).size.width / 4 + MediaQuery.of(context).size.width / 2) - 10.0,
                          child: Text( widget.products[0].desc,
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 13.0,
                            color: Colors.grey[700],
                          ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text('\$' + widget.products[0].price.toString(),
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 25.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                                ),
                            ),
                          ),
                          ],
                 )
            ),
                Positioned(
                  top: 250,
                  left: 15,
                  child: Text(
                    'Size',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
            ),
          ),
        ),
        Positioned(
          top: 300,
          left: 15,
          child: Row(
            children: <Widget>[
              SizedBox(
              width: 50.0,
              height: 50.0,
              child: new RaisedButton(
                onPressed: widget.products[0].stock[0] > 0 ? () => pickToggle(0) : null,
                child: Text('XS', style: TextStyle(
                  fontFamily: "Raleway",
                  color: picked[0] ? Colors.black : Colors.grey.withOpacity(0.4)),), 
                color: Colors.white,
                shape: CircleBorder(side: BorderSide(color: picked[0] ? Colors.black : Colors.grey.withOpacity(0.4))),
              ),
            ),
            SizedBox(width: 15.0),
            SizedBox(
              width: 50.0,
              height: 50.0,
              child: new RaisedButton(
                onPressed: widget.products[0].stock[1] > 0 ? () => pickToggle(1) : null,
                child: Text('S', style: TextStyle(
                  fontFamily: "Raleway",
                  color: picked[1] ? Colors.black : Colors.grey.withOpacity(0.4)),), 
                color: Colors.white,
                shape: CircleBorder(side: BorderSide(color: picked[1] ? Colors.black : Colors.grey.withOpacity(0.4))),
              ),
            ),
              SizedBox(width: 15.0),
            SizedBox(
              width: 50.0,
              height: 50.0,
              child: new RaisedButton(
                onPressed: widget.products[0].stock[2] > 0 ? () => pickToggle(2) : null,
                child: Text('M', style: TextStyle(
                  fontFamily: "Raleway",
                  color: picked[2] ? Colors.black : Colors.grey.withOpacity(0.4)),), 
                color: Colors.white,
                shape: CircleBorder(side: BorderSide(color: picked[2] ? Colors.black : Colors.grey.withOpacity(0.4))),
              ),
            ),
            SizedBox(width: 15.0),
            SizedBox(
              width: 50.0,
              height: 50.0,
              child: new RaisedButton(
                onPressed: widget.products[0].stock[3] > 0 ? () => pickToggle(3) : null,
                child: Text('L', style: TextStyle(
                  fontFamily: "Raleway",
                  color: picked[3] ? Colors.black : Colors.grey.withOpacity(0.4)),), 
                color: Colors.white,
                shape: CircleBorder(side: BorderSide(color: picked[3] ? Colors.black : Colors.grey.withOpacity(0.4))),
              ),
            ),
            SizedBox(width: 15.0),
            SizedBox(
              width: 50.0,
              height: 50.0,
              child: new RaisedButton(
                onPressed: widget.products[0].stock[4] > 0 ? () => pickToggle(4) : null,
                child: Text('XL', style: TextStyle(
                  fontFamily: "Raleway",
                  color: picked[4] ? Colors.black : Colors.grey.withOpacity(0.4)),), 
                color: Colors.white,
                shape: CircleBorder(side: BorderSide(color: picked[4] ? Colors.black : Colors.grey.withOpacity(0.4))),
              ),
            ),
            ],
          )
        ),
        Positioned(
            top: 375,
            left: 15,
            child: SizedBox(
                width: 150.0,
                height: 50.0,
                child: new RaisedButton(
                  onPressed: () {
                    cartHandler();
                  },
                  child: Text('Add To Cart', style: TextStyle(
                    fontFamily: "Raleway",
                    color: Colors.white, fontSize:14),), 
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)
                      ),

                ),
              ),
        ),
            ],
            ),
            ),
            
            /*SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            'COLOR',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding:  EdgeInsets.only(left: 15.0),
          child: Row(
            children: <Widget>[
              SizedBox(
              width: 50.0,
              height: 50.0,
              child: new RaisedButton(
                onPressed: () {},
                color: Colors.black,
                shape: CircleBorder(side: BorderSide(color: Colors.black)),
              ),
            ),
            SizedBox(width: 15.0),
            SizedBox(
              width: 50.0,
              height: 50.0,
              child: new RaisedButton(
                onPressed: () {},
                color: Colors.white,
                shape: CircleBorder(side: BorderSide(color: Colors.black)),
              ),
            ),
            SizedBox(width: 15.0),
            SizedBox(
              width: 50.0,
              height: 50.0,
              child: new RaisedButton(
                onPressed: () {}, 
                color: Colors.red,
                shape: CircleBorder(side: BorderSide(color: Colors.black)),
              ),
            )
            ],
          )
        ),*/
          ],
        )
      ],
    ),
    );
  }
}

class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return new Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(4.0))),
      ),
    );
  }

  Widget _activePhoto() {
    return new Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
                color: Color(0x99A6C1FF),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
                ])),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildDots(),
    ));
  }
}