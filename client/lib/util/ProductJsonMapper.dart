import 'dart:convert';

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