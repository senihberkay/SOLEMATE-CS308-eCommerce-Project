import 'package:flutter/material.dart';
import 'package:flutter_auth/components/product_card.dart';
import 'package:flutter_auth/models/Product.dart';

import 'package:flutter_auth/size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  List<Product> products = [];
  PopularProducts(
    {Key? key, required this.products}
  ) : super(key: key); // sonradan eklendi

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                products.length,
                (index) {

                  return ProductCard(product: products[index]);

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
