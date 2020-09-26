import './Review.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductJsonMapper {
  static String toJson(Product p) {
    Map<String, dynamic> map() =>
    {
      '_id': p._id,
      'name': p.name,
      'stock': p.stock.join(","),
      'picture': p.picture,
      'desc': p.desc,
      'price': p.price,
      'color': p.color,
    };
    String result = jsonEncode(map());
    return result;
  }

  static Product fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    String id = json['_id'];
    String name = json['name'];
    List<dynamic> stock =  json['stock'];
    String picture = json['picture'];
    String desc = json['desc'];
    double price = json['price'];
    String color = json['color'];
    Product p = new Product(id, stock, name, picture, desc, color, price);
    return p;
  }

  static Product fromJsonMap(Map<String, dynamic> json) {
    String id = json['_id'];
    String name = json['name'];
    List<dynamic> stock =  json['stock'];
    String picture = json['picture'];
    String desc = json['desc'];
    double price = json['price'];
    String color = json['color'];
    Product p = new Product(id, stock, name, picture, desc, color, price);
    return p;
  }

  static List<Product> fromJsonArray(String jsonString) {
    Map<String, dynamic> decodedMap = jsonDecode(jsonString);
    List<dynamic> dynamicList = decodedMap['products'];
    List<Product> products = new List<Product>();
    dynamicList.forEach((f) {
      Product p = ProductJsonMapper.fromJsonMap(f);
      products.add(p);
    });

    return products;
  }
}

class Product {
  final String _id;
  final List<dynamic> stock;
  final String name;
  final String picture;
  final String desc;
  final String color;
  final double price;

  Product(this._id, this.stock, this.name, this.picture, this.desc, this.color, this.price);
}

class ProductPage extends StatefulWidget{
  @override
  _ProductPage createState()=>_ProductPage();

}

class _ProductPage extends State<ProductPage>{
  int photoIndex = 0;
  List<String> photos = [
    'assets/item.jpg',
    'assets/item1.jpg',
    'assets/item2.jpg',
  ];

  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : 0;
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

  bool isSizeStock(int size){
    //query the database for the array
    //get the index from array that is relative to the size



    if(  > 0){
      return true;
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 275.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(photos[photoIndex]),
                          fit: BoxFit.cover)),
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
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'SKU: FW7089',
                style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 15.0,
                color: Colors.grey
          ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Text('Russian Lifestyle',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: Text('Color',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                children: <Widget>[
                  Container(
                width: (MediaQuery.of(context).size.width / 4 + MediaQuery.of(context).size.width / 2) - 10.0,
                child: Text('Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
                ),
              ),
              Text('\$ 120',
                style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
                ],
              )
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
        SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            'SIZE',
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
                child: Text('XS', style: TextStyle(color: Colors.black),), 
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
                child: Text('S', style: TextStyle(color: Colors.black),), 
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
                child: Text('M', style: TextStyle(color: Colors.black),), 
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
                child: Text('L', style: TextStyle(color: Colors.black),), 
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
                child: Text('XL', style: TextStyle(color: Colors.black),), 
                color: Colors.white,
                shape: CircleBorder(side: BorderSide(color: Colors.black)),
              ),
            ),
            ],
          )
        )
          ],
        )
      ],
    ),
    bottomNavigationBar: Material(
      elevation: 7.0,
      color: Colors.white,
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          SizedBox(width: 10.0),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50.0,
                width: 50.0,
                color: Colors.white,
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50.0,
                width: 50.0,
                color: Colors.white,
                child: Icon(
                  Icons.account_box,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(
              width: 200.0,
              height: 50.0,
              child: new RaisedButton(
                onPressed: () {},
                child: Text('Add To Cart', style: TextStyle(color: Colors.black, fontSize:30),), 
                color: Colors.yellow,
                //shape: StadiumBorder(side: BorderSide(color: Colors.black)),
              ),
            ),
          ]
        )
      )
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
                color: Colors.yellow,
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