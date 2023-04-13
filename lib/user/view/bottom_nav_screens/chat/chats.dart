
import 'package:flutter/material.dart';

import 'package:smartico/core/constants.dart';


class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});



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
            // Expanded(
            //   child: ListView.builder(itemBuilder: (context, index) {
            //     return  ListTile(
            //       onTap:() =>  Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagesScreen(),)),
            //       leading: const CircleAvatar(radius: 28,),
            //       title:const Text(''),
            //       subtitle: const Text('You have to complete this..',),
            //       trailing: Column(
            //         children: [
            //            const Text('10:40',),
            //           CircleAvatar(
            //             radius: 9,
            //             child: Text('$index',style: const TextStyle(fontSize: 12),),)
            //         ],
            //       ),
                  
            
            //     );
                
            //   },itemCount: 6,),
            // )
          ],
        ),
      );
      
     
    
  }
}