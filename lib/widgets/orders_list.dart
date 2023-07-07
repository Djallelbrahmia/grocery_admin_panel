import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/widgets/text_widget.dart';

import '../consts/constants.dart';
import '../services/utils.dart';
import 'orders_widget.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key, this.isInDashboard = true}) : super(key: key);
  final bool isInDashboard;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("orders").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: isInDashboard && snapshot.data!.docs.length > 4
                        ? 4
                        : snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          Orderswidget(
                            imageUrl: snapshot.data!.docs[index]["imageUrl"],
                            price: snapshot.data!.docs[index]["price"],
                            quantity: snapshot.data!.docs[index]["quantity"],
                            totalPrice: snapshot.data!.docs[index]
                                ["totalPrice"],
                            productId: snapshot.data!.docs[index]["productId"],
                            userId: snapshot.data!.docs[index]["userId"],
                            userName: snapshot.data!.docs[index]["userName"],
                            orderDate: snapshot.data!.docs[index]["orderDate"],
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                        ],
                      );
                    }),
              );
            } else {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextWidget(
                    text: "Your Store is Empty", color: Utils(context).color),
              ));
            }
          } else {
            return Center(
                child: TextWidget(
                    text: "Something went wrong", color: Colors.red));
          }
        });
  }
}
