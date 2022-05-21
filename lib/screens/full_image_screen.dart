import 'package:gallery_saver/gallery_saver.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popular_people_cloud/constrain.dart';

class FullImageScreen extends StatelessWidget {
  final String image;

  const FullImageScreen({Key key, this.image}) : super(key: key);
  static String id = 'FullImageScreen';
  @override
  Widget build(BuildContext context) {
    String url = personImageUrl + image;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          // height: 300.0,
          decoration: BoxDecoration(
            color: Colors.orange,
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () async {
                      final tempDir = await getTemporaryDirectory();
                      final path = '${tempDir.path}/image.jpg';
                      await Dio().download(url, path);
                      await GallerySaver.saveImage(path);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('downloaded to gallery')),
                      );
                    },
                    label: const Text(
                      'Save Image',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        // fixedSize: const Size(300, 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
