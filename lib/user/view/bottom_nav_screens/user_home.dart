import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smartico/core/widgets.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  List imageList = [
    {},
    {
      'https://static.vecteezy.com/system/resources/previews/008/915/938/non_2x/horizontal-banner-with-image-of-cleaning-products-soap-bubbles-home-or-office-plumbing-advertising-sale-of-cleaning-products-editable-text-vector.jpg'
    }
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 121, 216, 206),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(),
              )
            ],
            title: const Text(
              'Hi Username',
              style: TextStyle(
                  fontFamily: 'ROBOTO',
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 160.0,
                  enlargeCenterPage: true,
                  aspectRatio: 16/9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 0.8,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration:
                      const Duration(microseconds: 800),
                ),
                carouselController: carouselController,
                items: [
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Card(
                      elevation: 6.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/user_home/service banner 2.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              kHeight10,
             Card(
                child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 123, 230, 219),
                  borderRadius: BorderRadius.circular(10)),
              height: height / 11,
              width: width / 1.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Want to be a Vendor',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: height / 23.5,
                    width: width / 2.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "lets's Get Started",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
                ),
              ),
              kHeight10,
              Row(                
                children: const[
              Padding(
               padding: EdgeInsets.only(left: 20),
               child: Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,                               
                            ),
                          ),
             ),
                       
              
              ],),
              SizedBox(
                height: height/7.2,
                
                width: double.infinity,
                child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return SizedBox(
                      child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(9.0),
                        child: CircleAvatar(
                          radius: 34,
                          child: Icon(
                            Icons.plumbing,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ),
                      Text('Work'),
                    ],
                  ));
                },
                itemCount: 20,
                scrollDirection: Axis.horizontal,
              ),
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:const [
               Padding(
                 padding: EdgeInsets.only(left: 20),
                 child: Text(
                              "Recomended services",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,                               
                              ),
                            ),
               ),
                 Padding(
                   padding: EdgeInsets.only(right: 20),
                   child: Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,                               
                              ),
                            ),
                 ),
                ],
              ),
              Expanded(
                child: GridView.builder(gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent:200,childAspectRatio: 3/2,crossAxisSpacing: 20,mainAxisSpacing: 20), itemBuilder: (context, index) {
                  return SizedBox(
                    height: 200,
                    width: width/2,
                    child:Column(children: [
                      Image.asset('assets/user_home/service banner 2.jpg'),
                      const Text('Driving',style: TextStyle(color: Colors.blue,),),
                      const Text('Destination Droping',style: TextStyle(color: Colors.blue,fontSize: 25,fontWeight: FontWeight.bold),),
                      Row(
                        children: const [
                          Icon(Icons.star,color: Colors.yellow,),
                          Text('4.9(1.2k + reviews)'),
                      
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.monetization_on,color: Color.fromARGB(255, 58, 201, 15),),
                          Text("100-1000"),
                      
                        ],
                      ),
                      
                    ],)
                    
                  );
                },itemCount: 10,),
              )
              
      
            ],
          )),
    );
  }
}
