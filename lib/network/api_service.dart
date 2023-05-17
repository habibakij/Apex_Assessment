import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:test_isolate/model/company_list_model.dart';

import '../model/create_company_model.dart';
import '../utils/common.dart';
import 'app_url.dart';
import 'interceptor.dart';
import 'package:http/http.dart' as http;

class ApiService{

  static http.Client client = InterceptedClient.build(interceptors: [ApiInterceptor()]);

  static Future<CompanyListModel> getCompanyInfo() async {
    EasyLoading.show(status: "Please wait...");
    var response = await client.get(Uri.parse(AppUrl.mainUrl));
    final decode;
    if (response.statusCode == 200 || response.statusCode == 201) {
      EasyLoading.dismiss();
      decode = json.decode(response.body);
    } else {
      EasyLoading.dismiss();
      throw Exception("Error fetching. \n ${response.statusCode}, ${response.body}");
    }
    CompanyListModel responseJson = CompanyListModel.fromJson(decode);
    return responseJson;
  }

  static Future<CreateCompanyModel> createNewCompany(String companyName, String email, String password, String phone) async {
    EasyLoading.show(status: "Please wait...");
    var body= {
      "company_name": companyName,
      "email": email,
      "password": password,
      "phone": phone
    };
    var response = await client.post(Uri.parse(AppUrl.mainUrl), body: body);
    EasyLoading.dismiss();
    final decode= json.decode(response.body);
    CreateCompanyModel responseJson = CreateCompanyModel.fromJson(decode);
    return responseJson;
  }




}