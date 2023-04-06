import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';

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
              child: Card(
                child: Column(
                  children: [
                    Container(
                      height: height / 4.5,
                      width: width / 1.10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(15),topRight: Radius.circular(15)),
                          image: DecorationImage(
                              image:
                                  NetworkImage(value.AllGigs![index].image),
                              fit: BoxFit.fill)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value.AllGigs![index].title,
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
                    Row(
                      children: [
                        Text(
                          '${value.AllGigs![index].price}',
                          style: const TextStyle(
                              fontSize: 21, color: Colors.blue),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: value.AllGigs!.length,
        ),
      ),
    );
  }
}
