
  import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:smartico/core/widgets.dart';

 Shimmer getShimmerLoading(width){
    return Shimmer.fromColors( baseColor: Colors.grey[300]!, highlightColor: Colors.grey[100]!,
    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                           
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      borderRadius: BorderRadius.circular(9),
                                      ),
                                  height: width / 2.9,
                                  width: width / 3.2,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SizedBox(
                              height: width / 3,
                              width: width / 1.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 15,
                                        width:100 ,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  kHeight10,
                                  Row(
                                    children:  [
                                      Container(
                                        height: 15,
                                        width:150 ,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  kHeight10,
                                
                                  Row(
                                    children:  [
                                      Container(
                                        height: 15,
                                        width:100 ,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  kHeight10,
                                  Row(
                                    children:  [
                                      Container(
                                        height: 15,
                                        width:120 ,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  kHeight10,
                                  Row(
                                    children:  [
                                     Container(
                                        height: 15,
                                        width:120 ,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ), 
    );
  }