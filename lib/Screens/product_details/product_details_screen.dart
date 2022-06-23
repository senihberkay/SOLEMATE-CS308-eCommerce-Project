import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter_auth/components/product_card.dart';
import 'package:flutter_auth/constants.dart';
import 'components/body.dart';

/*
class ProductDetailsScreen extends StatelessWidget {
  static var routeName = "/productDetails";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Product Details',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true),
    );
  }
}
*/
class ProductDetailsScreen extends StatefulWidget {
  static var routeName = "/productDetails";
  @override
  _TestMeState createState() => _TestMeState();
}

class _TestMeState extends State<ProductDetailsScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Asuman Aslı Sivri',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Definitely perfect shoe!'
    },
    {
      'name': 'Senih Berkay',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool'
    },
    {
      'name': 'Hammad',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Love this product'
    },
    {
      'name': 'shoeManiac_26',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Could be better'
    },
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Comments"),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        child: CommentBox(
          userImage:
              "https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400",
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            //if (formKey.currentState.validate()) {
            print(commentController.text);
            setState(() {
              var value = {
                'name': 'New User',
                'pic':
                    'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                'message': commentController.text
              };
              filedata.insert(0, value);
            });
            commentController.clear();
            FocusScope.of(context).unfocus();
            //}
            //else {
            // print("Not validated");
            //}
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
