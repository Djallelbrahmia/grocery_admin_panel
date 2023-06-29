import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_admin_panel/inner_screens/edit_prod.dart';
import 'package:grocery_admin_panel/screens/loading_manager.dart';

import '../services/global_method.dart';
import '../services/utils.dart';
import 'text_widget.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool _isLoading = true;
  String productCat = "";
  String? imgUrl;
  String title = "";
  String price = '0.0';
  double salePrice = 0.0;
  bool isOnsale = false;
  bool isPiece = false;

  Future<void> getProductData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final DocumentSnapshot productsDoc = await FirebaseFirestore.instance
          .collection("products")
          .doc(widget.id)
          .get();
      if (productsDoc.isNull) {
        return;
      } else {
        setState(() {
          productCat = productsDoc.get('productCategoryName');
          imgUrl = productsDoc.get('imageUrl');
          title = productsDoc.get('title');
          price = productsDoc.get('price');
          salePrice = productsDoc.get('salePrice');
          isOnsale = productsDoc.get('isOnSale');
          isPiece = productsDoc.get('isPiece');
        });
      }
    } catch (e) {
      GlobalMethods.ErrorDialog(subtitle: e.toString(), context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    final color = Utils(context).color;
    return LoadingManager(
      isLoading: _isLoading,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor.withOpacity(0.6),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProductScreen(
                      id: widget.id,
                      title: title,
                      price: price,
                      salePrice: salePrice,
                      productCat: productCat,
                      imageUrl: imgUrl ??
                          "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png",
                      isOnSale: isOnsale,
                      isPiece: isPiece)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Image.network(
                          imgUrl ??
                              "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png",
                          fit: BoxFit.fill,
                          // width: screenWidth * 0.12,
                          height: size.width * 0.12,
                        ),
                      ),
                      const Spacer(),
                      PopupMenuButton(
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  onTap: () {},
                                  child: Text('Edit'),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection("products")
                                        .doc(widget.id)
                                        .delete();
                                    await Fluttertoast.showToast(
                                      msg: "Deleted",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      // backgroundColor: ,
                                      // textColor: ,
                                      // fontSize: 16.0
                                    );
                                  },
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  value: 2,
                                ),
                              ])
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: isOnsale,
                        child: TextWidget(
                          text: '\$$salePrice',
                          color: color,
                          textSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Visibility(
                          visible: true,
                          child: Text(
                            '\$$price',
                            style: TextStyle(
                                decoration: isOnsale
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: color),
                          )),
                      const Spacer(),
                      TextWidget(
                        text: isPiece ? "Piece" : '1Kg',
                        color: color,
                        textSize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  TextWidget(
                    text: title,
                    color: color,
                    textSize: 24,
                    isTitle: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
