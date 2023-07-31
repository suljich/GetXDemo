import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_demo/app/data/model/account.dart';
import 'package:getx_demo/app/data/model/transaction.dart';
import 'package:getx_demo/widgets/my_app_bar.dart';
import 'package:styled_text/styled_text.dart';

import '../controllers/transaction_details_controller.dart';

class TransactionDetailsView extends GetView<TransactionDetailsController> {
  const TransactionDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'title'.tr,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              namePriceDateWidget(context),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              addReceipt(context),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              if (controller.transaction.type == TransactionType.expense)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!controller.transaction.isSplit.value)
                      shareTheCostWidget(context, controller.account),
                    if (!controller.transaction.isSplit.value)
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                      ),
                    subscriptionWidget(controller.account),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                    ),
                  ],
                ),
              GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text(
                      'help_is_on_the_way'.tr,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    'something_wrong'.tr,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.error,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Text(
                        '${'transaction id'.tr} #${controller.transaction.id}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column subscriptionWidget(Account account) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'subscription'.tr.toUpperCase(),
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'repeating_payment'.tr,
              ),
              Obx(
                () => Switch(
                  value: controller.transaction.isRepeating.value,
                  onChanged: (_) {
                    controller.transaction.isRepeating.value =
                        !controller.transaction.isRepeating.value;
                    if (controller.transaction.isRepeating.value) {
                      controller.account.transactions.add(
                        Transaction(
                          title: controller.transaction.title,
                          type: controller.transaction.type,
                          dateTime: DateTime.now(),
                          id: '${controller.transaction.id}v2',
                          amount: controller.transaction.amount,
                        ),
                      );
                    } else {
                      controller.account.transactions.removeWhere(
                        (element) =>
                            element.id == '${controller.transaction.id}v2',
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column shareTheCostWidget(BuildContext context, Account account) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'share_the_cost'.tr.toUpperCase(),
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.transaction.isSplit.value = true;
            controller.transaction.amount /= 2;
            controller.account.transactions.add(
              Transaction(
                title:
                    '${'split the bill'.tr} - ${controller.transaction.title}',
                amount: controller.transaction.amount,
                type: TransactionType.topup,
                dateTime: controller.transaction.dateTime,
                id: controller.account.uidGen.v1(),
              ),
            );
            Get.back();
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(
                  2,
                ),
                margin: const EdgeInsets.all(
                  10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).primaryColor,
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                ),
                child: const Icon(
                  Icons.call_split,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                'split_this_bill'.tr,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row addReceipt(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(
            2,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).primaryColor,
            borderRadius: BorderRadius.circular(
              4,
            ),
          ),
          child: const Icon(
            Icons.receipt,
            size: 20,
            color: Colors.white,
          ),
        ),
        Text(
          'add_receipt'.tr,
        ),
      ],
    );
  }

  Column namePriceDateWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor,
                    borderRadius: BorderRadius.circular(
                      4,
                    ),
                  ),
                  child: Icon(
                    Transaction.icons[controller.transaction.type],
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            StyledText(
              text:
                  '<large>${controller.transaction.amount.truncate()}</large>.<small>$controller.decimalPart</small>',
              tags: {
                'large': StyledTextTag(
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
                'small': StyledTextTag(
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                )
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            controller.transaction.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            controller.transaction.dateTime.toStandardFormat,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
