import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/services/utils.dart';
import 'package:grocery_admin_panel/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:grocery_admin_panel/controllers/MenuController.dart' as Mc;

import '../responsive.dart';
import '../screens/dashboard_screen.dart';
import '../widgets/grid_product.dart';
import '../widgets/side_menu.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<Mc.MenuController>().getgridscaffoldKey,
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
                      title: "All Product",
                      fct: () {
                        context.read<Mc.MenuController>().controlProductsMenu();
                      },
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Responsive(
                      mobile: ProductGridWidget(
                        isInMain: false,
                        crossAxisCount: size.width < 650 ? 2 : 4,
                        childAspectRatio:
                            size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                      ),
                      desktop: ProductGridWidget(
                        isInMain: false,
                        childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                      ),
                    ),
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
