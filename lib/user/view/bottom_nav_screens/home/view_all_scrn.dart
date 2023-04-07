import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/work_descrip.dart';

class ViewAllScreen extends StatelessWidget {
  ViewAllScreen({super.key});
  List recomendedServiceImage = [
    'assets/splash/painter.jpeg',
    'assets/splash/plumbing.jpeg',
    'assets/works/driver 2.jpg',
    'assets/splash/tree cutting.jpeg',
    'assets/splash/tv repair.jpeg',
    'assets/works/driver.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Recent Services',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<RecentServicesProvider>(
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: GestureDetector(
                onTap: () async {
                  await context
                      .read<SingleGigDetailsProvider>()
                      .getGig(value.allGigs![index].id);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceDescriptionScrn(),
                      ));
                },
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        height: height / 4,
                        width: width / 1.10,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            image: DecorationImage(
                                image:
                                    NetworkImage(value.allGigs![index].image),
                                fit: BoxFit.fill)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              value.allGigs![index].title,
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.blue,
                                ),
                                Text(
                                  '5.0',
                                  style: TextStyle(fontSize: 19),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          children: [
                            Text(
                              '\$${value.allGigs![index].price}',
                              style: const TextStyle(
                                  fontSize: 21, color: Colors.blue),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: value.allGigs!.length,
        ),
      ),
    );
  }
}
