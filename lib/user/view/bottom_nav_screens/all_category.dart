import 'package:flutter/material.dart';
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
          ColoredBox(
            color: const Color.fromARGB(255, 121, 216, 206),
            child: Padding(
              padding: const EdgeInsets.only(right: 13, left: 13, bottom: 5),
              child: TextField(
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 123, 230, 219)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Search Here",
                    fillColor: Colors.white70),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                right: 10,
                left: 10,
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>ServiceDescriptionScrn() ,)),
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
                                        image: AssetImage(
                                            recomendedServiceImage[index]),
                                        fit: BoxFit.cover)),
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
                                    children: const [
                                      Text(
                                        'Design interior service',
                                        style: TextStyle(
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
                                        color: Color.fromARGB(255, 58, 201, 15),
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
                itemCount: 7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
