import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoGalleryPage extends StatefulWidget {
  final List<String> images;

  PhotoGalleryPage(this.images);

  @override
  State<StatefulWidget> createState() {
    return _PhotoGalleryPageState();
  }

}

class _PhotoGalleryPageState extends State<PhotoGalleryPage> {
  //退出
  void _pop() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Widget body = new PageView.builder(itemBuilder: (context,index) =>
    _buildItem(index, widget.images));
    return body;
  }

  Widget _buildItem(int index, List<String> images) =>
      new GestureDetector(
        child: new PhotoView(imageProvider: new NetworkImage(images[index])
          , loadingChild: new Center(
            child: const CircularProgressIndicator(),
          ),
        heroTag: images[index],),
        onTap: _pop,
      );
}