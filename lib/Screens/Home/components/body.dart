import 'package:flutter/material.dart';
import 'package:flutter_auth/models/Product.dart';
import 'package:flutter_auth/size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'special_offers.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  FirebaseAuth auth = FirebaseAuth.instance;

  dynamic data;
  String username = "";
  String mail = "";
  String uid = "";
  String pictureURL = "";
  var cart = {};
  var bookmarks = {};
  var notifications = {};
  List<Product> products = [];
  bool showNotificationsBadge = false;

  Future getProducts() async {
    User? currentUser = await auth.currentUser;
    if (currentUser != null) {
      await currentUser.reload();
    }
    final CollectionReference collection = FirebaseFirestore.instance.collection('products');
    await collection.get().then<dynamic>((QuerySnapshot snapshot) async{
      snapshot.docs.forEach((doc) {
        String docID = doc.id;
        final DocumentReference document = FirebaseFirestore.instance.collection('products').doc(docID);
        document.get().then<dynamic>((DocumentSnapshot snapshot2) async{
          setState(() {
            data = snapshot2.data();
          });
          String name = data['name'];
          String brand = data['brand'];
          String ID = data['ID'];
          //double rating = data['rating'];
          String description = data['description'];
          var pictureURLs = data['pictureURLs'];
          var comments = data['comments'];
          String price = data['price'];
          var sizesStocks = data['sizesStocks'];
          String distributor = data['distributor'];
          String warrantyStatus = data['warrantyStatus'];

          Product product = Product(
            name: name,
            brand: brand,
            price: price,
            //rating: rating,
            ID: ID,
            description: description,
            pictureURLs: pictureURLs,
            comments: comments,
            sizesStocks: sizesStocks,
            distributor: distributor,
            warrantyStatus: warrantyStatus

          );
          setState(() {
            products.add(product);
          });
        });
      });
    });
  }

  _BodyState() {
    getProducts();
  }

 // sonradan eklendi
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            //const DiscountBanner(), // aramızda konuşuruz
            Categories(),
            //SpecialOffers(), //delete
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(products: products),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
