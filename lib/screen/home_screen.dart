
import 'dart:developer';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:test_isolate/controller/home_screen_controller.dart';
import 'package:test_isolate/utils/style_management.dart';
import 'package:get/get.dart';

import '../utils/common.dart';
import '../widget/text_field_widget.dart';

class HomeScreen extends StatelessWidget {

  final homeScreenController= Get.put(HomeScreenController());

  TextEditingController nameController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController= TextEditingController();
  TextEditingController phoneController= TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.white,
        title: const Center(child: Text("Company List", style: StyleManagement.testStyleBlack16)),
      ),*/
      body: Column(
        children: [
          const SizedBox(height: 60),
          const Text("Company List", style: StyleManagement.testStyleBlack16),
          const SizedBox(height: 20),
          const Divider(),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: homeScreenController.companyListModel.value.companyList != null &&
                  homeScreenController.companyListModel.value.companyList!.data != null ? homeScreenController.companyListModel.value.companyList!.data!.length : 0,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 20),
                      child: Obx(() => Text(
                        homeScreenController.companyListModel.value.companyList!.data![index].companyName.toString(),
                        style: StyleManagement.testStyleBlackBold16,
                      )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, left: 20),
                      child: Obx(() => Text(
                        homeScreenController.companyListModel.value.companyList!.data![index].email.toString(),
                        style: StyleManagement.testStyleGrey14,
                      )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, left: 20, bottom: 10),
                      child: Obx(() => Text(
                        homeScreenController.companyListModel.value.companyList!.data![index].phone.toString(),
                        style: StyleManagement.testStyleBlack14,
                      )),
                    ),
                    const Divider(),
                  ],
                );
              })),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(HexColor("#25A5A3")),
                  ),
                onPressed: (){
                  createNewCompanyDialog(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text("Create Company", style: StyleManagement.testStyleWhite16),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }


  void createNewCompanyDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Form(
            key: _formKey,
            child: Dialog(
              child: SizedBox(
               height: 450,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [

                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close, size: 30),
                        ),
                      ),
                      const Text("Create a new company", style: StyleManagement.testStyleBlackBold18),
                      const SizedBox(height: 20),
                      TextFieldWidget(controller: nameController, hintText: "Company Name", inputType: 0),
                      TextFieldWidget(controller: emailController, hintText: "Work Email", inputType: 0),
                      TextFieldWidget(controller: passwordController, hintText: "Password", inputType: 0),
                      TextFieldWidget(controller: phoneController, hintText: "Phone", inputType: 1),

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(HexColor("#25A5A3")),
                          ),
                          onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              homeScreenController.createNewCompany(nameController.text.toString(),
                                  emailController.text.toString(), passwordController.text.toString(), phoneController.text.toString()).then((value) => {
                                    if(value == 1){
                                      Navigator.pop(context),
                                      nameController.clear(),
                                      emailController.clear(),
                                      passwordController.clear(),
                                      phoneController.clear(),
                                    }
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text("Create A New Company", style: StyleManagement.testStyleWhite16),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

}
