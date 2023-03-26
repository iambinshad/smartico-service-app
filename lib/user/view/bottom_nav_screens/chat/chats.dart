
import 'package:flutter/material.dart';

import 'package:smartico/core/constants.dart';

import 'other_screens/messages.dart';

class ChatsScreen extends StatelessWidget {
   ChatsScreen({super.key});

  List vendorsName = [
    'Rajubhai Malhotra',
    'Akshay rav',
    'Robin jeda',
    'Drona chariya',
    'Jasir Ali',
    'Rajubhai Malhotra',
    'Akshay rav',
    'Robin jeda',
  ];
 List recomendedServiceImage = [
    'assets/splash/painter.jpeg',
    'assets/works/driver 2.jpg',
    'assets/splash/tv repair.jpeg',  
    'assets/works/profile pic.jpg'
    'assets/works/driver.jpg',
    'assets/splash/painter.jpeg',
    'assets/works/driver 2.jpg',
    'assets/splash/tv repair.jpeg',
  ];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:const Color.fromARGB(255, 223, 223, 221),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: Text('Messages',style:headText ),),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return  ListTile(
                  onTap:() =>  Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagesScreen(),)),
                  leading: CircleAvatar(backgroundImage:AssetImage(recomendedServiceImage[index]),radius: 28,),
                  title:Text(vendorsName[index],style: normalText,),
                  subtitle: const Text('You have to complete this..',),
                  trailing: Column(
                    children: [
                       const Text('10:40',),
                      CircleAvatar(
                        radius: 9,
                        child: Text('$index',style: const TextStyle(fontSize: 12),),)
                    ],
                  ),
                  
            
                );
                
              },itemCount: 8,),
            )
          ],
        ),
      );
      
     
    
  }
}