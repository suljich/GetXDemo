import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_demo/app/data/model/account.dart';
import 'package:getx_demo/app/data/model/transaction.dart';
import 'package:getx_demo/app/modules/transactions/controllers/transactions_controller.dart';
import 'package:getx_demo/app/routes/app_pages.dart';

class RecentActivityView extends GetView<TransactionsController> {
  const RecentActivityView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(
        20,
      ),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 8 / 2,
        ),
        SafeArea(
          child: Text(
            'recent activity'.tr,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        if (controller.account.transactionsMadeToday.isNotEmpty)
          const SizedBox(
            height: 10,
          ),
        if (controller.account.transactionsMadeToday.isNotEmpty)
          Text(
            'today'.tr.toUpperCase(),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        if (controller.account.transactionsMadeToday.isNotEmpty)
          recentActivityCard(
            controller.account,
            context,
            true,
          ),
        if (controller.account.transactionsMadeYesterday.isNotEmpty)
          Text(
            'yesterday'.tr.toUpperCase(),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        if (controller.account.transactionsMadeYesterday.isNotEmpty)
          recentActivityCard(
            controller.account,
            context,
            false,
          ),
      ],
    );
  }

  Widget recentActivityCard(
    Account account,
    BuildContext context,
    bool today,
  ) {
    final list = today
        ? account.transactionsMadeToday
        : account.transactionsMadeYesterday;
    return Column(
      children: list
          .map(
            (e) => ListTile(
              onTap: () =>
                  Get.toNamed(Routes.TRANSACTION_DETAILS, arguments: e),
              leading: Container(
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
                  Transaction.icons[e.type],
                  color: Colors.white,
                ),
              ),
              title: Text(
                e.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                e.type == TransactionType.topup ||
                        e.type == TransactionType.loan
                    ? '+${e.amount.toStringAsFixed(
                        2,
                      )}'
                    : e.amount.toStringAsFixed(
                        2,
                      ),
                style: TextStyle(
                  color: e.type == TransactionType.topup ||
                          e.type == TransactionType.loan
                      ? Theme.of(
                          context,
                        ).primaryColor
                      : Colors.black,
                  fontSize: e.type == TransactionType.topup ||
                          e.type == TransactionType.loan
                      ? 25
                      : 20,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
