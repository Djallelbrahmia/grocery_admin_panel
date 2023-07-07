import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:grocery_admin_panel/widgets/orders_list.dart';
import 'package:provider/provider.dart';
import 'package:grocery_admin_panel/controllers/MenuController.dart' as Mc;

import '../responsive.dart';
import '../screens/dashboard_screen.dart';
import '../widgets/grid_product.dart';
import '../widgets/side_menu.dart';
import '../widgets/text_widget.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<Mc.MenuController>().getOrdersScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    Header(
                      title: "All Orders",
                      fct: () {
                        context.read<Mc.MenuController>().controlProductsMenu();
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OrdersList(
                          isInDashboard: false,
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
