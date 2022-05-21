import 'package:flutter/material.dart';
import 'package:popular_people_cloud/constrain.dart';
import 'package:popular_people_cloud/screens/full_image_screen.dart';
import 'package:popular_people_cloud/view_model/details_view_model.dart';
import 'package:popular_people_cloud/view_model/images_view_model.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key key}) : super(key: key);
  static String id = 'DetailsScreen';
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var _details = Provider.of<DetailsViewModel>(context).detail;
    var _items = Provider.of<ImagesViewModel>(context).imgList;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(3),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.album),
                      title: Text(
                        _details.name,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      subtitle: Text(
                        'birth Date:' + _details.birthday,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  crossAxisCount: 3,
                ),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullImageScreen(image: _items[index].filePath),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                personImageUrl + _items[index].filePath),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Center(
            //   child: Text(_details.name.toString()),
            // ),
          ],
        ),
      ),
    );
  }
}
