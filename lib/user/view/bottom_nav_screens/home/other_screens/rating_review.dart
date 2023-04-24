
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/user/booking/booked_gigs.dart';
import 'package:smartico/core/constants.dart';
import 'package:smartico/core/widgets.dart';

class WorkReviewScreen extends StatelessWidget {
  const WorkReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ReservedGigs>(
            builder: (context, value, child) => ListView.separated(
              separatorBuilder: (context, index) => Divider() ,
              itemCount: value.reveiws!.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ratings & Reviews',style: normalText.copyWith(fontSize: 27),),
                          kHeight10,
                          Row(
                            children: [
                              RatingBar.builder(
                                ignoreGestures: true,
                                allowHalfRating: true,
                                initialRating: value.reveiws![index]!.rating,
                                itemSize: 20,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 230, 209, 23),
                                ),
                                onRatingUpdate: (value) {},
                              ),
                              
                              Text("(${value.reveiws![index]!.rating})",style: normalText,),
                              kWidth10,
                              Text(value.reveiws![index]!.title,style: normalText),
                            ],
                          ),
                          kHeight10,
                          Text(value.reveiws![index]!.description,style: const TextStyle(fontSize: 19),),
                          kHeight10,
                          Row(
                            children: [
                              const CircleAvatar(radius: 10,backgroundImage: AssetImage('assets/splash/unknown.jpg'),),
                              kWidth10,
                              Text("${value.reveiws![index]!.userId.fullName}  ,  ",style:const TextStyle(color: Colors.grey,fontWeight: FontWeight.bold) ,),
                              Text(value.reveiws![index]!.userId.status,style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)
                            ],
                          ),
                          kHeight10,
                          Row(
                            children: [
                              const Icon(Icons.verified,size: 18,),
                              Text('Verified User  ${value.reveiws![index]!.date}')
                            ],
                          ),
                         
                        ],
                      ),
                ) ,),));
  }
}
