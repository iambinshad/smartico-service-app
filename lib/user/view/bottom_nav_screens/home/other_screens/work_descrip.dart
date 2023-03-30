import 'package:flutter/material.dart';
import 'package:smartico/core/widgets.dart';
import 'package:smartico/user/view/bottom_nav_screens/chat/other_screens/messages.dart';

class ServiceDescriptionScrn extends StatelessWidget {
   ServiceDescriptionScrn({super.key});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: width/1.1+30,
                width: width,
                child: const Image(
                  image: AssetImage(
                    'assets/splash/electrician 2.jpg',
                  ),
                  fit: BoxFit.cover,
                )),
            SizedBox(width: width,
              height: width,
              child:Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('All Electric Works',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                      Row(
                        children:const [
                           StarIcon(),
                           StarIcon(),
                           StarIcon(),
                           StarIcon(),
                           StarIcon(),
                           SizedBox(width: 5,),
                           Text('(70 Reviews)',style: TextStyle(fontSize: 19),)
                        ],
                      ),
                      kHeight10,
                      Row(
                        children: const [
                          CircleAvatar(backgroundImage:AssetImage('assets/works/profile pic.jpg'),radius: 28,),
                          SizedBox(width: 5,),
                          Text('Rajubhai Malhotra',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold))
                        ],
                      ),
                      kHeight10,
                      Row(
                        children: const [
                          Icon(Icons.place_outlined,color: Color.fromARGB(255, 123, 230, 219) ,),
                          Text('Golden Estate, Ajah,Logos',style: TextStyle(fontSize: 19))
                        ],
                      ),
                      kHeight10,
                      Row(
                        children: const [
                          Icon(Icons.calendar_month,color: Color.fromARGB(255, 123, 230, 219) ,),
                          
                          Text('Everyday',style: TextStyle(fontSize: 19)),
                        ],
                      ),
                      kHeight10,
                      Row(
                        children: const [
                                                  Icon(Icons.monetization_on_outlined,color: Color.fromARGB(255, 123, 230, 219) ,),
                  
                          Text('30 (Per Day)',style: TextStyle(fontSize: 19))
                        ],
                      ),
                      kHeight10,
                      const Divider(
                        thickness: 1,
                      ),
                      kHeight10,
                      const Text('About me',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                      kHeight10,
                      const Text('Lorem ipsum tirasamma telehet polytehe polyteheten in forutom plattfilm telechet Lorem ipsum tirasamma telehet polytehe polyteheten in forutom plattfilm telechet polu',style: TextStyle(fontSize: 19))
                    ],
                  ),
                ),
              ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 7,right: 8,left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagesScreen(),)),
                    child: Container(
                      height: width/7.5,
                      width: width/5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              color: const Color.fromARGB(255, 123, 230, 219))),
                      child: const Icon(
                        Icons.message_rounded,
                        size: 30,
                        color: Color.fromARGB(255, 123, 230, 219),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 123, 230, 219),
                      padding:  EdgeInsets.symmetric(
                          horizontal: width/4, vertical:width/27),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    child: const Text(
                      "Book Now",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StarIcon extends StatelessWidget {
  const StarIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.star_rate_rounded,size: 25,color: Color.fromARGB(255, 123, 230, 219),);
  }
}
