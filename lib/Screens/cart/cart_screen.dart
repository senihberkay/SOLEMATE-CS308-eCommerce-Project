import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_auth/components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  dynamic data;
  var cart = [];
  var sum = 0.0;

  calculateTotal() {
    cart.forEach((element) {
      setState(() {
        sum += double.parse(element['price']) * element['quantity'];
      });
    });
  }

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
        cart = data['cart'];
      });
    });
  }

  Future<void> deleteFromCart(String ID, int index, String size) async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    var totalCost =
        double.parse(cart[index]['price']) * cart[index]['quantity'];
    setState(() {
      sum -= totalCost;
      cart.removeWhere((element) {
        return (element['size'] == size && element['ID'] == ID);
      });
    });
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).update({
      'cart': cart,
    });
  }

  incrementQuantity(String ID, int index) async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);
    var index = cart.indexWhere((element) => element['ID'] == ID);
    var cartItem = cart[index];
    cartItem['quantity'] = cartItem['quantity'] + 1;
    cart[index] = cartItem;
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users');
    await collection.doc(currentUser!.uid).update({
      'cart': cart,
    });
    setState(() {
      sum += double.parse(cart[index]['price']);
    });
    /*await collection.doc(currentUser.uid).snapshots().listen((event) {
      data = event.data();

      setState(() {
        cart = data['cart'];
      });
    });*/
  }

  decrementQuantity(String ID, int index) async {
    User? currentUser = auth.currentUser;
    assert(currentUser != null);

    var index = cart.indexWhere((element) => element['ID'] == ID);
    var cartItem = cart[index];
    if (cartItem['quantity'] > 1) {
      cartItem['quantity'] = cartItem['quantity'] - 1;
      cart[index] = cartItem;
      final CollectionReference collection =
          FirebaseFirestore.instance.collection('users');
      await collection.doc(currentUser!.uid).update({
        'cart': cart,
      });
      setState(() {
        sum -= double.parse(cart[index]['price']);
      });
    }
  }

  _CartScreenState() {
    getData().then((e) {
      calculateTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: cart.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(cart[index]['ID'].toString()),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      deleteFromCart(
                          cart[index]['ID'], index, cart[index]['size']);
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
                                  child: Image.network(cart[index]['picture']),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cart[index]['name'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  maxLines: 2,
                                ),
                                SizedBox(height: 5),
                                Text.rich(
                                  TextSpan(
                                    text: "${cart[index]['price']} TL",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: kPrimaryColor),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text.rich(
                                  TextSpan(
                                    text: '${cart[index]['size']} EU',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                cart[index]['quantity'] != 1
                                    ? IconButton(
                                        iconSize: 20,
                                        padding: const EdgeInsets.all(0),
                                        icon:
                                            Icon(Icons.indeterminate_check_box),
                                        onPressed: () {
                                          decrementQuantity(
                                              cart[index]['ID'], index);
                                        },
                                      )
                                    : Container(),
                                Text(
                                  cart[index]['quantity'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                    fontFamily: 'Open Sans',
                                  ),
                                ),
                                IconButton(
                                  iconSize: 20,
                                  padding: const EdgeInsets.all(0),
                                  icon: Icon(Icons.add_box_rounded),
                                  onPressed: () {
                                    incrementQuantity(cart[index]['ID'], index);
                                  },
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: Text('Your cart is empty... :('),
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Text("Add voucher code"),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: kTextColor,
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: sum.toString() + ' TL',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: cart.isNotEmpty
                        ? DefaultButton(
                            text: "Check Out",
                            press: () {
                              Navigator.pushNamed(context, '/checkout');
                            },
                          )
                        : DefaultButton(
                            text: 'Continue Shopping',
                            press: () {
                              Navigator.popAndPushNamed(context, '/home');
                            }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${cart.length} item(s)",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
