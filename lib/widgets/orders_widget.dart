import 'package:flutter/material.dart';
import 'package:grocery_admin_panel/widgets/text_widget.dart';

import '../services/utils.dart';

class Orderswidget extends StatefulWidget {
  const Orderswidget({
    Key? key,
  }) : super(key: key);

  @override
  State<Orderswidget> createState() => _OrderswidgetState();
}

class Timestamp {}

class _OrderswidgetState extends State<Orderswidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = theme == true ? Colors.white : Colors.black;
    Size size = Utils(context).getScreenSize;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: size.width < 650 ? 3 : 1,
                child: Image.network(
                  "https://aborabora.com/wp-content/uploads/2021/09/Orange.jpg",

                  fit: BoxFit.fill,
                  // height: screenWidth * 0.15,
                  // width: screenWidth * 0.15,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "\$9.0",
                      color: color,
                      textSize: 16,
                      isTitle: true,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          TextWidget(
                            text: 'By  ',
                            color: Colors.blue,
                            textSize: 16,
                            isTitle: true,
                          ),
                          Text('Djallel')
                        ],
                      ),
                    ),
                    Text(
                      "29/03/2022",
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
