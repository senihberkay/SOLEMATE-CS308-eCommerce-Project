import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/models/Product.dart';
import 'package:flutter_auth/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  FirebaseAuth auth = FirebaseAuth.instance;
  var fav = [];
  String currentValue = '';

  Future<void> addToFav(Product product) async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);

    var index = -1;
    if (fav.isNotEmpty) {
      index = fav.indexWhere((element) => element['ID'] == product.ID);
    }


    var FavouriteItem = {
      'name': product.name,
      'brand': product.brand,
      'picture': product.pictureURLs[0],
      'ID': product.ID,
      'price': product.price
    };
    fav.add(FavouriteItem);


    final CollectionReference collection = FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).update({
      'favourite': fav,
    });
  }

  Future<void> removeFromFav(Product product) async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);

    fav.removeWhere((element) {
        return (element['ID'] == product.ID);
      });

    final CollectionReference collection =
    FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).update({
      'favourite': fav,
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: product),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: product.ID.toString(),
                    child: Image.network(product.pictureURLs[0]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: const TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                      child: FavoriteButton(
                        iconSize: SizeConfig.screenHeight * 0.05,
                        valueChanged: (_isFavorite) {
                          if (_isFavorite){
                            addToFav(product);
                          }
                          else{
                            removeFromFav(product);
                          }

                          print('Is Favorite $_isFavorite)');
                        },
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
