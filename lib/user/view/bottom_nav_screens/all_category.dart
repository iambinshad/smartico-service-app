import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/show_all_gigs/fetch_single_gig_details.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';
import 'package:smartico/user/view/bottom_nav_screens/home/other_screens/work_descrip.dart';

class AllCategroryList extends StatelessWidget {
  AllCategroryList({super.key});

  List recomendedServiceImage = [
    'assets/splash/painter.jpeg',
    'assets/splash/plumbing.jpeg',
    'assets/works/driver 2.jpg',
    'assets/splash/tree cutting.jpeg',
    'assets/splash/tv repair.jpeg',
    'assets/works/driver.jpg',
    'assets/splash/electrician 2.jpg'
  ];

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 121, 216, 206),
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'All Services',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const ColoredBox(
            color: Color.fromARGB(255, 121, 216, 206),
            child: Padding(
                padding: EdgeInsets.only(right: 13, left: 13, bottom: 5),
                child: CupertinoSearchTextField(
                  backgroundColor: Colors.white,
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                right: 10,
                left: 10,
              ),
              child: Consumer<RecentServicesProvider>(
                builder: (context, value, child) => ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: ()async {
                        await context.read<SingleGigDetailsProvider>().getGig(value.allGigs![index].id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServiceDescriptionScrn(),
                          ));},
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              value.allGigs![index].image),
                                          fit: BoxFit.fill)),
                                  height: width / 2.8,
                                  width: width / 3.2,
                                ),
                              )
                            ],
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: SizedBox(
                                height: width / 3,
                                width: width / 1.9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          value.allGigs![index].title,
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Text(
                                          '(simple Desk Setup)',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.star_rate_rounded,
                                          color: Colors.yellow,
                                          size: 23,
                                        ),
                                        Text(
                                          '4.9(1.2k + reviews)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.monetization_on,
                                          color:
                                              Color.fromARGB(255, 58, 201, 15),
                                          size: 23,
                                        ),
                                        Text(
                                          "100-1000",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: const [
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.blue,
                                          size: 23,
                                        ),
                                        Text(
                                          "383",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: value.allGigs!.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
