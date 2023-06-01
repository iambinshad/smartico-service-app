
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/show_all_gigs/show_all_gigs.dart';
import 'package:smartico/core/widgets.dart';

class Nothingof extends StatelessWidget {
  Nothingof({super.key});

  FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<RecentServicesProvider>().fetchAllGigs(context);

    });
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Consumer<RecentServicesProvider>(
        builder: (context, value, child) => ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding:
                const EdgeInsets.only(right: 14, left: 14, bottom: 5, top: 5),
            child: Card(
              elevation: 3.0,
              child: Container(
                width: width / 1.1,
                height: height / 5,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: height / 5,
                          width: width / 2.9,
                          decoration: BoxDecoration(
                              
                              image: DecorationImage(
                                  image:
                                      NetworkImage(value.allGigs![index].image),
                                  fit: BoxFit.cover,onError: (exception, stackTrace) => const CircularProgressIndicator(),),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(value.allGigs![index].type),
                        Text(value.allGigs![index].title),
                        // Text(value.allGigs![index].overview),
                        kHeight10,
                        Row(
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.yellow,
                                  size: 23,
                                ),
                                Text(
                                  '4.9(1.2k + reviews)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.monetization_on,
                                  color: Color.fromARGB(255, 58, 201, 15),
                                  size: 23,
                                ),
                                Text(
                                  " ${value.allGigs![index].price}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          itemCount: value.allGigs!.length,
        ),
      ),
    );
  }
}
