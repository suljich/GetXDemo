import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_demo/app/modules/loan_application/views/custom_textfield_view.dart';

import 'package:getx_demo/widgets/my_app_bar.dart';
import 'package:getx_demo/app/modules/loan_application/controllers/loan_application_controller.dart';

class LoanApplicationView extends GetView<LoanApplicationController> {
  const LoanApplicationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'loan application'.tr,
      ),
      body: Obx(() {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    8,
                    8,
                    8,
                    0,
                  ),
                  child: Text(
                    'terms and conditions'.tr,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                    8,
                    0,
                    8,
                    8,
                  ),
                  child: Text(
                    //TODO:not localized
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam elementum enim non neque luctus, nec blandit ipsum sagittis. Sed fringilla blandit nibh, sit amet suscipit massa sollicitudin lacinia. Donec cursus, odio sit amet tincidunt sodales, odio nisl hendrerit sem, tempor tincidunt ligula nisl nec ante. Nulla aliquet aliquam justo, ac bibendum orci rhoncus non. Nullam quis ex elementum, pharetra ligula eleifend, convallis nulla. Nulla sit amet nisi viverra, semper nunc eu, posuere dui. Donec at metus ut eros rhoncus vestibulum vitae at lacus. Etiam imperdiet, nulla ac condimentum aliquam, enim lacus fringilla leo, vel hendrerit mi ipsum et ante. Vivamus finibus mauris eget diam sodales, eget efficitur orci laoreet. Sed feugiat odio quis mattis tristique. Mauris sit amet sem mauris.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Color(
                        0xFF3A3B3C,
                      ),
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      letterSpacing: -0.24,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.fromLTRB(
                    16,
                    14,
                    0,
                    14,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'accept terms and conditions'.tr,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Obx(
                        () => Switch(
                          value: controller.accepted.value,
                          onChanged: (value) =>
                              controller.accepted.value = value,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    'about you'.tr.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomTextfieldView(
                  context: context,
                  textController: controller.salaryController,
                  title: 'monthly salary'.tr,
                  hintText: 'enter your salary'.tr,
                ),
                CustomTextfieldView(
                  context: context,
                  textController: controller.expensesController,
                  title: 'monthly expenses'.tr,
                  hintText: 'enter your monthly expenses'.tr,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    14,
                    0,
                    0,
                  ),
                  child: Text(
                    'loan'.tr.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                CustomTextfieldView(
                  context: context,
                  textController: controller.loanAmountController,
                  title: 'amount'.tr,
                  hintText: 'enter the loan amount'.tr,
                ),
                CustomTextfieldView(
                  context: context,
                  textController: controller.termController,
                  title: 'term'.tr,
                  hintText: 'enter the term'.tr,
                  isTerm: true,
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          height: 60,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: controller.loanLogic,
                            child: Text(
                              'apply for loan'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (controller.isLoading.value)
              const ModalBarrier(
                dismissible: false,
                color: Colors.black38,
              ),
            if (controller.isLoading.value)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      }),
    );
  }
}
