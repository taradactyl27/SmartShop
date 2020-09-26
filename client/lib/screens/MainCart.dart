import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import '../util/ProductJsonMapper.dart';
import 'dart:convert';

class MainCart extends StatefulWidget{

    @override
    _MainCart createState() => _MainCart();

}

class _MainCart extends State<MainCart> {
  List picked = [false, false, false, false];

  int totalAmount = 0;

  pickToggle(index) {
    setState(() {
      picked[index] = !picked[index];
      getTotalAmount();
    });
  }

  getTotalAmount() {
    var count = 0;
    for (int i = 0; i < picked.length; i++) {
      if (picked[i]) {
        count = count + 1;
      }
      if (i == picked.length - 1) {
        setState(() {
          totalAmount = 248 * count;
        });
      }
    }
  }

  List<Product> products = ProductJsonMapper.fromJsonArray('''{
      "products": [{
          "_id": "5f6eb803db6c2e1eee7d31af",
          "stock": [
            1,
            2,
            3,
            4,
            5
          ],
          "name": "Low-Cut Tshirt",
          "price": 7.99,
          "picture": "tshirt.jpg",
          "desc": "Its a bag",
          "color": "black"
      },
      {
        "_id": "5f6eb803db6c2e1eee7d31ae",
          "stock": [
            1,
            2,
            3,
            4,
            5
          ],
          "name": "Ankle Jeans",
          "price": 13.99,
          "picture": "jeans.jpg",
          "desc": "Its a bag",
          "color": "blue"
      },
      {
        "_id": "5f6eb803db6c2e1eee7d31ac",
          "stock": [
            1,
            2,
            3,
            4,
            5
          ],
          "name": "Bomber Jacket",
          "price": 43.99,
          "picture": "bomber.jpg",
          "desc": "Its a bag",
          "color": "Red"
      },
      {
        "_id": "5f6eb803db6c2e1eee7d31ac",
          "stock": [
            1,
            2,
            3,
            4,
            5
          ],
          "name": "Hooded Sweatshirt",
          "price": 33.99,
          "picture": "hoodie.jpg",
          "desc": "Its a bag",
          "color": "Green"
      }]
    }''');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Stack(children: [
            Stack(children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
              ),
              Container(
                height: 250.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                    colors: [
                      //Color(0xFF80F9B7),
                      //Color(0xFF9ABDEB),
                      Color(0xFFFC7B7B),
                      Color(0xFFA6C1FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                 ),
                ),
              ),
              Positioned(
                  top: 75.0,
                  left: 15.0,
                  child: Text(
                    'Shopping Cart',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                height: 650,
                padding: EdgeInsets.only(top: 150),
                child: ListView(shrinkWrap: true,
                  children: <Widget>[
                    Column(
                        children: <Widget>[
                           for (var product in products) 
                           itemCard(product.name,
                                    product.color,
                                    product.price, 
                                    product.picture,
                                    true,0)
                      /*   itemCard('Gray T-Shirt', 'gray', '248',
                            '', true, 0),
                        itemCard('Ankle Jeans', 'blue', '248',
                            '', true, 1),
                        itemCard('Bomber Jacket', 'black', '248',
                            '', true, 2),
                        itemCard('Low-top Sneakers', 'white', '248',
                            '', true, 3), */
                    ],
                  ),
                ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 685.0),
                  child: Container(
                      height: 50.0,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('Total: \$' + totalAmount.toString()),
                          SizedBox(width: 10.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {},
                              elevation: 0.5,
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  'Pay Now',
                                ),
                              ),
                              textColor: Colors.white,
                            ),
                          )
                        ],
                      ))),
              ])
          ])
        ]),
    );
  }

  Widget itemCard(itemName, color, price, imgPath, available, i) {
    return InkWell(
      onTap: () {
        if (available) {
          pickToggle(i);
        }
      },
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 3.0,
              child: Container(
                  padding: EdgeInsets.only(left: 15.0, right: 10.0),
                  width: MediaQuery.of(context).size.width - 20.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: 25.0,
                              width: 25.0,
                              decoration: BoxDecoration(
                                color: available
                                    ? Colors.grey.withOpacity(0.4)
                                    : Colors.red.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12.5),
                              ),
                              child: Center(
                                  child: available
                                      ? Container(
                                          height: 12.0,
                                          width: 12.0,
                                          decoration: BoxDecoration(
                                              color: picked[i]
                                                  ? Colors.lightGreenAccent
                                                  : Colors.grey
                                                      .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(6.0)),
                                        )
                                      : Container()))
                        ],
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        height: 150.0,
                        width: 125.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/' + imgPath),
                                fit: BoxFit.contain)),
                      ),
                      SizedBox(width: 4.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                itemName,
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              SizedBox(width: 7.0),
                              available
                                  ? picked[i]
                                      ? Text(
                                          'x1',
                                          style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                              color: Colors.grey),
                                        )
                                      : Container()
                                  : Container()
                            ],
                          ),
                          SizedBox(height: 7.0),
                          available
                              ? Text(
                                  'Color: ' + color,
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: Colors.grey),
                                )
                              : OutlineButton(
                                  onPressed: () {},
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                      style: BorderStyle.solid),
                                  child: Center(
                                    child: Text('Find Similar',
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.0,
                                            color: Colors.red)),
                                  ),
                                ),
                          SizedBox(height: 7.0),
                          available
                              ? Text(
                                  '\$' + price.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.lightGreenAccent[700],
                                ))
                              : Container(),
                        ],
                      )
                    ],
                  )))),
    );
  }
}