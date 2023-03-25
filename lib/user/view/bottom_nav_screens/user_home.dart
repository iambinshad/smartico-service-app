import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});
  @override
  State<UserHomePage> createState() => _UserHomePageState();
}
class _UserHomePageState extends State<UserHomePage> {
  List serviceCategoryIcons =<Widget> [
const Icon(Icons.plumbing),
const Icon(Icons.delivery_dining_sharp),
const Icon(Icons.cake),
const Icon(Icons.format_paint),
const Icon(Icons.tv_rounded),
const Icon(Icons.electrical_services_outlined),
const Icon(Icons.iron),
const Icon(Icons.dry_cleaning),
  ];
  List serviceCategoryNames = [
    'Plumber',
    'Delivery',
    'Cake Maker',
    'Painter',
    'Tv repair',
    'Electrician',
    'Dress iron',
    'Dress dry Clean'
  ];
  List recomendedServiceImage = [
    'assets/splash/painter.jpeg',
    'assets/splash/plumbing.jpeg',
    'assets/works/driver 2.jpg',
    'assets/splash/tree cutting.jpeg',
    'assets/splash/tv repair.jpeg',
    'assets/works/driver.jpg',
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
                child: CircleAvatar(radius: 30,backgroundImage: AssetImage('assets/works/profile pic.jpg'),),
              )
            ],
            title: SearchBarAnimation(
                          textEditingController: TextEditingController(),
                          isOriginalAnimation: true,
                          enableKeyboardFocus: true,
                          trailingWidget: const Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.black,
                          ),
                          secondaryButtonWidget: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                          buttonWidget: const Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
          ),
          body: Column(
            
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 135.0,
                  enlargeCenterPage: true,
                  
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 0.97,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration:
                      const Duration(microseconds: 5000),
                ),
                carouselController: carouselController,
                items: [
                  BannerCard(imageAddress: 'assets/splash/review.webp',),
                  BannerCard(imageAddress: 'assets/user_home/banner image 3.webp',),
                  BannerCard(imageAddress: 'assets/user_home/service banner 2.jpg')
                ],
              ),
              
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
                    children:  [
                      Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: CircleAvatar(
                          radius: 34,
                          child:serviceCategoryIcons[index],
                        ),
                      ),
                      Text(serviceCategoryNames[index]),
                    ],
                  ));
                },
                itemCount: 8,
                scrollDirection: Axis.horizontal,
              ),
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:const [
               Padding(
                 padding: EdgeInsets.only(left: 17),
                 child: Text(
                              "Recomended services",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,                               
                              ),
                            ),
               ),
                 Padding(
                   padding: EdgeInsets.only(right:17),
                   child: Text(
                              "View All",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold, 
                                color: Color.fromARGB(255, 123, 230, 219),                              
                              ),
                            ),
                 ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 7,right: 13,left: 13),
                  child: GridView.builder(gridDelegate:const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent:200,childAspectRatio: 3/3.4,crossAxisSpacing: 10,mainAxisSpacing: 10), itemBuilder: (context, index) {
                    return SizedBox(
                      
                      width: width/2,
                      child:Column(children: [
                        Container(
                          height: height/7.7,
                          width: width/2.1,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),image: DecorationImage(image: AssetImage(recomendedServiceImage[index]),fit:BoxFit.cover)),),
                        Row(
                          children:const [
                             Text('Driving',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Row(
                          children:const [
                             Text('Destination Droping',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.star_rate_rounded,color: Colors.yellow,size: 23,),
                            Text('4.9(1.2k + reviews)',style: TextStyle(fontWeight: FontWeight.bold),),
                        
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.monetization_on,color: Color.fromARGB(255, 58, 201, 15),size: 23,),
                            Text("100-1000",style: TextStyle(fontWeight: FontWeight.bold),),
                        
                          ],
                        ),
                        
                      ],)
                      
                    );
                  },itemCount: 6,),
                ),
              )
              
              
            ],
          )),
    );
  }
}

class BannerCard extends StatelessWidget {
   BannerCard({
    required this.imageAddress, super.key,
  });
String imageAddress;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image:  DecorationImage(
              image: AssetImage(
                  imageAddress),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
