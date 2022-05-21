import 'package:flutter/material.dart';
import 'package:popular_people_cloud/constrain.dart';
import 'package:popular_people_cloud/models/persons_model.dart';
import 'package:popular_people_cloud/screens/details_screen.dart';
import 'package:popular_people_cloud/view_model/details_view_model.dart';
import 'package:popular_people_cloud/view_model/images_view_model.dart';
import 'package:popular_people_cloud/view_model/persons_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.title}) : super(key: key);
  final String title;
  static String id = 'HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final scrollController = ScrollController();

  Future<void> init() async {
    await Provider.of<PersonsViewModel>(context, listen: false).fetchPersons();
  }

  @override
  void initState() {
    init();

    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        init();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<PersonsModel> _personsList =
        Provider.of<PersonsViewModel>(context).perList;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Popular People'),
          ),
          body: ListView.builder(
            controller: scrollController,
            itemCount: _personsList.length,
            itemBuilder: (context, index) {
              var person = _personsList[index];
              return Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  image: DecorationImage(
                    image: person.imageUrl != null
                        ? NetworkImage(personImageUrl + person.imageUrl)
                        : person.gender == 1
                            ? const AssetImage(
                                    'assets/images/person-female.jpg')
                                as ImageProvider
                            : const AssetImage('assets/images/person-male.jpg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      person.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25.0),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(person.department,
                              style: const TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await Provider.of<DetailsViewModel>(context,
                                    listen: false)
                                .fetchDetails(person.id);
                            await Provider.of<ImagesViewModel>(context,
                                    listen: false)
                                .fetchPersonImages(person.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailsScreen(),
                              ),
                            );
                          },
                          label: const Text(
                            'See Details',
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
              );
            },
          ),
        ),
      ),
    );
  }
}
