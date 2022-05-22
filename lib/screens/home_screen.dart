import 'package:flutter/material.dart';
import 'package:popular_people_cloud/constrain.dart';
import 'package:popular_people_cloud/models/persons_model.dart';
import 'package:popular_people_cloud/screens/details_screen.dart';
import 'package:popular_people_cloud/view_model/details_view_model.dart';
import 'package:popular_people_cloud/view_model/images_view_model.dart';
import 'package:popular_people_cloud/view_model/results_view_model.dart';
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
  bool hasMore = true;
  bool isLoading = false;

  Future<void> init() async {

    await Provider.of<ResultsViewModel>(context, listen: false).fetchResults();
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
  List<PersonsModel>personsList  =[];

  @override
  Widget build(BuildContext context) {
    List<PersonsModel> newList=[];
    int totalPages = Provider.of<ResultsViewModel>(context).totalPage;
    int totalResults = Provider.of<ResultsViewModel>(context).totalResult;
    newList  =   Provider.of<ResultsViewModel>(context).perList;

    if(totalResults != null){
      if (totalResults/totalPages < newList.length) {
        setState(() {
          hasMore = false;
        });

      }
    }


    personsList.addAll(newList);
    newList.clear();

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
            itemCount: personsList.length + 1,
            itemBuilder: (context, index) {
              if (index < personsList.length) {
                var person = personsList[index];
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
                              : const AssetImage(
                                  'assets/images/person-male.jpg'),
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
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: hasMore
                        ? const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            color: Colors.orange,
                          )
                        : const Text('No more data to load'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  getPageLimit(int totalResults, int totalPages) {
    int limit = totalResults ~/ totalPages;
    return limit;
  }
}
