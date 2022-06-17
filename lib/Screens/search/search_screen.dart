import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/product_card.dart';
import '../../constants.dart';
import '../../models/Product.dart';
import '../../size_config.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

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
  String query = "";

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

  _SearchState() {
    getProducts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5), horizontal: getProportionateScreenWidth(20) ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: SizeConfig.screenWidth * 0.9,
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  onChanged: (value) {
                    query = value;
                    setState(() { });
                    //print(query);
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20),
                          vertical: getProportionateScreenWidth(9)),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: "Search product",
                      prefixIcon: const Icon(Icons.search)),
                ),
              ),
              SizedBox(height: 30,),

              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: query.isEmpty?
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    ...List.generate(
                      products.length,
                          (index) {
                            //print(products[index].name);
                            print(query);
                            return ProductCard(product: products[index]);
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                ):
                Column(
                  children: [
                    Text("Results:"),
                    SizedBox(height: 10,),
                    ...List.generate(
                      1,
                          (index) {
                            ProductCard mycard = ProductCard(product: products[1]);
                            for(int i =0; i < products.length; i++){
                              if ((query == (products[i].name.toLowerCase())) | (query == (products[i].name.toLowerCase().replaceAll(' ', '')))){
                                mycard = ProductCard(product: products[i]);
                                print("---------");
                                print(i);
                              }
                            }
                            return mycard;
                      },
                    ),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
ProductCard mycard = new ProductCard(product: products[1]);
                        query == products[index].name ?
                        mycard = ProductCard(product: products[index]) :
                        mycard = ProductCard(product: products[1]);
                        return mycard;


                        (query == (products[index].name.toLowerCase().replaceAll(' ', ''))) ?
                            mycard = ProductCard(product: products[index]) :
                            mycard = ProductCard(product: products[2]);
 */