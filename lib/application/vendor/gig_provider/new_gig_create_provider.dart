import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartico/application/common/common_provider.dart';
import 'package:smartico/vendor/controller/gig/delete_gig.dart';
import 'package:smartico/vendor/controller/gig/edit_gig.dart';
import 'package:smartico/vendor/controller/gig/new_gig.dart';
import 'package:smartico/vendor/model/category/get_all_category.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NewGIgCreateProvider with ChangeNotifier{
 List<CategoryResModel?> categories = [];
  CategoryResModel? selectedCategory;
  dynamic selectedCategoryId;
bool vendorSideTypeValidation = true;

  Future<void>createNewGig(gigCreateDatas,context)async{
      
        var response = await NewGigCreateApiService().newGigCreate(gigCreateDatas);
        if(response == 'success'){
          showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: 'New Gig Adding Successfull',
      ),
    );
        }
  }

  Future<void>editGig(gigEditDatas,context)async{
    log('inside pro ');
    var response = await EditGigService().editGig(gigEditDatas);
    if(response == 'success'){
         showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.success(
        message: 'Gig Editing Successfull',
      ),
    );
    }
  }

  Future<void>deleteGig(gigId,context)async{
     await DeleteGigService().deleteGig(gigId, context);
  }



  Future<void>getAllCategory(context)async{
     await NewGigCreateApiService().getAllCategory(context).then((categoriesValue){
       categories=categoriesValue!;
       Provider.of<CommonProvider>(context,listen: false).setShimmerLoading(false);
       notifyListeners();
       log(categories.toString());
      notifyListeners();
     });

  }

 }