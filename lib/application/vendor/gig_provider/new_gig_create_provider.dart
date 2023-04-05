import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartico/vendor/controller/gig/new_gig.dart';
import 'package:smartico/vendor/controller/gig/show_all_gigs.dart';
import 'package:smartico/vendor/model/category/get_all_category.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NewGIgCreateProvider with ChangeNotifier{
 List<CategoryResModel?> categories = [];
  CategoryResModel? selectedCategory;
  var selectedCategoryId;

  Future<void>createNewGig(gigCreateDatas,context)async{
      
        var response = await NewGigCreateApiService().newGigCreate(gigCreateDatas);
        if(response == 'success'){
          showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: 'New Gig Added',
      ),
    );
        }
  }

  Future<void>getAllCategory(context)async{
     await NewGigCreateApiService().getAllCategory(context).then((categoriesValue){
       categories=categoriesValue!;
       notifyListeners();
       log(categories.toString());
      notifyListeners();
     });

  }

 }