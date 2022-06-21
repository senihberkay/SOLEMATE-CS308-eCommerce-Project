import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class FavScreen extends StatefulWidget {
  static var routeName = "/favs";

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var fav = [];
  dynamic data;

  Future<void> getData() async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    final CollectionReference collection =
    FirebaseFirestore.instance.collection('users');
    await collection
        .doc(currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) async {
      data = snapshot.data();
      setState(() {
        fav = data['favourite'];
      });
    });
  }

  Future<void> deleteFromFav(String ID, int index, String size) async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);

    setState(() {
      fav.removeWhere((element) {
        return (element['ID'] == ID);
      });
    });
    final CollectionReference collection =
    FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).update({
      'favourite': fav,
    });
  }

  _FavScreenState() {
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Favourites',
          style: TextStyle(
              color: Colors.black, fontSize: 20),
      ), centerTitle: true),

      body: fav.isNotEmpty ?
      Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20)),

          child: ListView.builder(
              itemCount: fav.length,
              itemBuilder: (context, index) =>
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: Dismissible(
                        key: Key(fav[index]['ID'].toString()),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          deleteFromFav(
                              fav[index]['ID'], index, fav[index]['size']);
                        },
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFE6E6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/Trash.svg"),
                              Spacer(),
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 88,
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          getProportionateScreenWidth(10)),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.network(
                                          fav[index]['picture']),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      fav[index]['name'],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 5),
                                    Text.rich(
                                      TextSpan(
                                        text: "${fav[index]['price']} TL",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: kPrimaryColor),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text.rich(
                                      TextSpan(
                                        text: '${fav[index]['brand']} ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                  )
          )
      ) :
      Center(
        child: Text("You do not have any favourites yet!"),
      ),
    );
  }
}
