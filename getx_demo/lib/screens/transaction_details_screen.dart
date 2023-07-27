import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_text/styled_text.dart';

import 'package:getx_demo/models/account.dart';
import 'package:getx_demo/models/transaction.dart';
import 'package:getx_demo/widgets/my_app_bar.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
  });

  static const route = '/transaction-details-screen';

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final Account account = Get.find();
    return Scaffold(
      appBar: const MyAppBar(),
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
              if (transaction.type == TransactionType.expense)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!transaction.isSplit)
                      shareTheCostWidget(context, account),
                    if (!transaction.isSplit)
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                      ),
                    subscriptionWidget(account),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                    ),
                  ],
                ),
              GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => const AlertDialog(
                    content: Text(
                      'Help is on the way, stay put!',
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    'Something wrong? Get help',
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
                        'Transaction ID #${transaction.id}',
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
        const Text(
          'SUBSCRIPTION',
          style: TextStyle(
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
              const Text(
                'Repeating payment',
              ),
              Obx(
                () => Switch(
                  value: transaction.isRepeating.value,
                  onChanged: (_) {
                    transaction.isRepeating.value =
                        !transaction.isRepeating.value;
                    if (transaction.isRepeating.value) {
                      account.transactions.add(
                        Transaction(
                          title: transaction.title,
                          type: transaction.type,
                          dateTime: DateTime.now(),
                          id: '${transaction.id}v2',
                          amount: transaction.amount,
                        ),
                      );
                    } else {
                      account.transactions.removeWhere(
                        (element) => element.id == '${transaction.id}v2',
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
        const Text(
          'SHARE THE COST',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () {
            transaction.isSplit = true;
            transaction.amount /= 2;
            account.transactions.add(
              Transaction(
                title: 'Split the bill - ${transaction.title}',
                amount: transaction.amount,
                type: TransactionType.topup,
                dateTime: transaction.dateTime,
                id: account.uidGen.v1(),
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
              const Text(
                'Split this bill',
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
        const Text(
          'Add receipt',
        ),
      ],
    );
  }

  Column namePriceDateWidget(BuildContext context) {
    String decimalPart =
        ((transaction.amount - transaction.amount.truncate()) * 100)
                    .truncate() ==
                0
            ? '00'
            : ((transaction.amount - transaction.amount.truncate()) * 100)
                .truncate()
                .toString();
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
                    Transaction.icons[transaction.type],
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            StyledText(
              text:
                  '<large>${transaction.amount.truncate()}</large>.<small>$decimalPart</small>',
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
            transaction.title,
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
            transaction.dateTime.toStandardFormat,
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
