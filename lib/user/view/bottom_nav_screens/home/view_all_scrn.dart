import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
    return  Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title:Text('Recomended Services',style: TextStyle(fontWeight: FontWeight.bold),),
        
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
          child: Card(
            elevation: 4.0,
            child:Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Container(
                    height:height/3.8,width: width/1.10,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),image:DecorationImage(image: AssetImage(recomendedServiceImage[index]),fit: BoxFit.cover)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Full Painting',style: TextStyle(fontFamily: 'Roboto',fontSize: 23,fontWeight: FontWeight.bold),),
                       Row(
                        children:const [
                          Icon(Icons.star_rounded,color: Colors.blue,),
                          Text('5.0',style: TextStyle(fontSize: 19),),
            
                        ],
                       )
                      
                    ],
                  ),
                  Row(
                    children: [
                      Text('\$40',style: TextStyle(fontSize: 21,color: Colors.blue),)
                    ],
                  )
                ],
              ),
            ) ,
          ),
        );
        
      },
      itemCount: 6,
      ),
    );
  }
}