import 'package:flutter/material.dart';

class Review extends StatefulWidget{
  @override
  _Review createState() => _Review();
}

class _Review extends State<Review>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff121212),
        floatingActionButtonLocation: 
          FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff6FB6F6),
          child: const Icon(Icons.add,color:Colors.black),
          onPressed: null),
        bottomNavigationBar: PreferredSize(
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color(0xff3066BE),
                  offset: Offset(0, -1),
                  blurRadius: 20.0,
                  spreadRadius: 0.5,
                )
              ]),
              child: BottomAppBar(
                elevation: 0.0,
                shape: CircularNotchedRectangle(),
                notchMargin: 4.0,
                color: Color(0xff343434),
                child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.menu), color:Colors.white, onPressed: () {},),
                  IconButton(icon: Icon(Icons.account_circle), color: Colors.white, onPressed: () {},),
                      ],
                    ),
                  ),
                ),
            preferredSize: Size.fromHeight(kToolbarHeight),
          ),
        
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(children: <Widget>[
                Card(
                   child: InkWell(
                       splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                        print('Card tapped.');
                    },
                   child: Container(
                       decoration: BoxDecoration(
                         color: Color(0xff343434),
                         border: Border(
                           bottom: BorderSide(
                              width: 30,
                              color: Color(0xff6FB6F6),
                           ) ),
                        ),
                      width: 325,
                      height: 500,
                      child: Center(
                        child: Column(
                          children:<Widget>[
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                 bottom: BorderSide(
                                   width: 1,
                                  color: Colors.white,
                           ) ),
                              ),
                              child: Text("Your Review", 
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Raleway',
                                fontSize: 24,
                                 )
                              ),
                            )
                  ]),
              )))),
        ],)],
      ))),
    );
  }
}