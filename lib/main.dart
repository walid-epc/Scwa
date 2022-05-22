import 'package:flutter/material.dart';
import 'package:popular_people_cloud/screens/details_screen.dart';
import 'package:popular_people_cloud/screens/full_image_screen.dart';
import 'package:popular_people_cloud/screens/home_screen.dart';
import 'package:popular_people_cloud/view_model/details_view_model.dart';
import 'package:popular_people_cloud/view_model/images_view_model.dart';
import 'package:popular_people_cloud/view_model/persons_view_model.dart';
import 'package:popular_people_cloud/view_model/results_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<PersonsViewModel>(
        //     create: (context) => PersonsViewModel()),
        ChangeNotifierProvider<DetailsViewModel>(
            create: (context) => DetailsViewModel()),
        ChangeNotifierProvider<ImagesViewModel>(
            create: (context) => ImagesViewModel()),
        ChangeNotifierProvider<ResultsViewModel>(
            create: (context) => ResultsViewModel()),
      ],
      child: MaterialApp(
        title: 'Popular People',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(title: 'Popular People'),
          DetailsScreen.id: (context) => const DetailsScreen(),
          FullImageScreen.id: (context) => const FullImageScreen(),

        },
      ),
    );
  }
}
