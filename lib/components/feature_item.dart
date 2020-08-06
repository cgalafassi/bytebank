import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    Key key,
    @required IconData iconData,
    @required this.textTitle,
    @required this.onTap,
  })  : iconData = iconData,
        super(key: key);

  final IconData iconData;
  final String textTitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: InkWell(
          onTap: () => onTap(),
          child: Container(
            height: 100,
            width: 150,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    iconData,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  Text(
                    textTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
