import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_demo/models/account.dart';
import 'package:getx_demo/models/transaction.dart';
import 'package:getx_demo/screens/transaction_details_screen.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({
    super.key,
  });

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
            (
              e,
            ) =>
                ListTile(
              onTap: () => Get.to(
                TransactionDetailsScreen(
                  transaction: e,
                ),
              ),
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

  @override
  Widget build(BuildContext context) {
    final Account account = Get.find();
    return Obx(
      () => ListView(
        padding: const EdgeInsets.all(
          20,
        ),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 8 / 2,
          ),
          SafeArea(
            child: Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          if (account.transactionsMadeToday.isNotEmpty)
            const SizedBox(
              height: 10,
            ),
          if (account.transactionsMadeToday.isNotEmpty)
            const Text(
              'TODAY',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          if (account.transactionsMadeToday.isNotEmpty)
            recentActivityCard(
              account,
              context,
              true,
            ),
          if (account.transactionsMadeYesterday.isNotEmpty)
            const Text(
              'YESTERDAY',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          if (account.transactionsMadeYesterday.isNotEmpty)
            recentActivityCard(
              account,
              context,
              false,
            ),
        ],
      ),
    );
  }
}
