import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GridItem extends StatelessWidget {
  final String imageUrl;
  GridItem({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new CachedNetworkImage(
        fit: BoxFit.cover,
        placeholder: (context, url) => new Center(
          child: new SizedBox(
            height: 50.0,
            width: 50.0,
            child: CircularProgressIndicator(),
          ),
        ),
        imageUrl: imageUrl,
      ),
    );
  }
}
