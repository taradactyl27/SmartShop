import 'dart:convert';

import 'package:http/http.dart' as http;


class RequestBuilder {
    static String requrl = "http://34.74.249.2";

    static String getItemsByName(String name){
      String input = 
          "query {getItemsByName(name: \"" + name + "\"){_id name price stock picture color desc}}"
          ;
      print(input);
      return input;
    }

    static Future<http.Response> sendGetItemsByName(String name) async {
        return http.post(
          requrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'query': getItemsByName(name)
            }),
        );
      }

    static Future<http.Response> sendUserById(String id) async {
      String input =
          "query {user(id: \"" + id + "\"){_id name password email}}"
      ;
      return http.post(
        requrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'query': input
        }),
      );
    }

    static Future<http.Response> getItemById(String id) async {
      String input =
          "query {getItemById(id: \"" + id + "\"){_id name price stock picture color desc}}"
      ;
      return http.post(
        requrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'query': input
        }),
      );
    }

    static Future<http.Response> getItemsFromIdArray(List<String> id) async {
      String input =
          "query {getItemsFromIdArray(id: " + jsonEncode(id) + "){_id name price stock picture color desc}}"
      ;
      return http.post(
        requrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'query': input
        }),
      );
    }

    static Future<http.Response> addUser(String name, String email, String password) async {
      String input =
          "mutation {addUser(name: \""+ name + "\",email:  \""+ email + "\",password: \""  + password + "\"){_id}}"
      ;
      return http.post(
        requrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'query': input
        }),
      );
    }

    static Future<http.Response> changeStock(String id, List<Int> newStock) async {
      String input =
          "mutation {changeStock(itemId: \"" + id + "\", newStock: " + jsonEncode(newStock) + "){_id}}"
      ;
      return http.post(
        requrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'query': input
        }),
      );
    }


    static Future<http.Response> addItem(String name, Float price, String picture, List<Int> stock, String desc, String color) async {
      String input =
          "mutation {addItem(name: \""+ name + "\", price: \""+ price + "\", picture: \""+ picture + "\", stock: " + jsonEncode(stock) + 
           ", desc: \""+ desc + "\", color: \""+ color + "\"){_id}}"
      ;
      return http.post(
        requrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'query': input
        }),
      );
    }


}