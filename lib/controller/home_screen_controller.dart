import 'package:get/get.dart';
import 'package:test_isolate/model/company_list_model.dart';

import '../model/create_company_model.dart';
import '../network/api_service.dart';
import '../utils/common.dart';

class HomeScreenController extends GetxController {

  @override
  void onInit() {
    getCompanyListData();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Rx<CompanyListModel> companyListModel = CompanyListModel().obs;
  getCompanyListData() async {
    companyListModel.value = await ApiService.getCompanyInfo();
  }

  RxInt createNewStatus= 0.obs;
  Rx<CreateCompanyModel> createCompanyModel = CreateCompanyModel().obs;
  Future<int> createNewCompany(String companyName, String email, String password, String phone) async {
    createCompanyModel.value= await ApiService.createNewCompany(companyName, email, password, phone);
    if(createCompanyModel.value.statusCode == "1"){
      Common.customToast(createCompanyModel.value.statusMessage.toString());
      createNewStatus.value= 1;
    } else {
      Common.customToast(createCompanyModel.value.statusMessage.toString());
      createNewStatus.value= 0;
    }
    return createNewStatus.value;
  }

}