import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartico/application/vendor/gig_provider/show_all_gig_provider.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';

// ignore: must_be_immutable
class GigDescripttion extends StatelessWidget {
  GigDescripttion({super.key, required this.index, required this.title});

  int index;
  String? title;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title!,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 81, 135),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
             Navigator.pop(context);
            },
            icon:const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: ListView(
        children: [
          SizedBox(
              height: width / 1.5,
              width: width,
              child: Consumer<ShowAllGigsProvider>(
                builder: (context, value, child) => Image(
                  image: NetworkImage(value.vendorGigs![index].image),
                  fit: BoxFit.cover,
                ),
              )),
          Card(
            child: SizedBox(
              // width: width,
              // height: doub,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Consumer<ShowAllGigsProvider>(
                  builder: (context, value, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.vendorGigs![index].title,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Row(
                        children: [
                          StarIcon(),
                          StarIcon(),
                          StarIcon(),
                          StarIcon(),
                          StarIcon(),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '(0)',
                            style: TextStyle(fontSize: 19),
                          )
                        ],
                      ),
                      kHeight10,
                      Row(
                        children: [
                          Text(value.vendorGigs![index].type,
                              style: normalText),
                        ],
                      ),
                      kHeight10,
                      Row(
                        children: [
                          const Icon(
                            Icons.monetization_on_outlined,
                            color: Color.fromARGB(255, 123, 230, 219),
                          ),
                          Text("${value.vendorGigs![index].price}",
                              style: const TextStyle(fontSize: 19))
                        ],
                      ),
                      kHeight10,
                      const Divider(
                        thickness: 1,
                      ),
                      kHeight10,
                      const Text(
                        'Overview',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      kHeight10,
                      Text(value.vendorGigs![index].overview,
                          style: const TextStyle(fontSize: 19)),
                      kHeight10,
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      kHeight10,
                      Text(value.vendorGigs![index].description,
                          style: const TextStyle(fontSize: 19))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Shimmer getjobdescriShimmerLoad(width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: width / 1.1 + 30,
        width: width,
        color: Colors.white,
      ),
    );
  }
}

// ignore: must_be_immutable
class Containerr extends StatelessWidget {
  Containerr({super.key, this.height, this.width, this.color = Colors.white});
  dynamic height;
  dynamic width;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}

class StarIcon extends StatelessWidget {
  const StarIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.star_rate_rounded,
      size: 25,
      color: Color.fromARGB(255, 123, 230, 219),
    );
  }
}
