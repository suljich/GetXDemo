import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'currency': '£',
          //Transactions screen
          'title': 'MoneyApp',
          'pay': 'Pay',
          'top_up': 'Top Up',
          'loan': 'Loan',
          'recent_activity': 'Recent Activity',
          'today': 'Today',
          'yesterday': 'Yesterday',
          //Transaction details screen
          'transaction_id': 'Transaction ID',
          'subscription': 'Subscription',
          'repeating_payment': 'Repeating payment',
          'share_the_cost': 'Share the cost',
          'split_the_bill': 'Split the bill',
          'split_this_bill': 'Split this bill',
          'add_receipt': 'Add receipt',
          //Pay screen
          'how_much': 'How much?',
          'next': 'Next',
          'to_whom': 'To whom?',
          'insufficient_funds': 'Insufficient funds',
          //Top up screen
          'what_is_the_source': 'What is the source?',
          //Loan application screen
          'loan_application': 'Loan application',
          'terms_and_conditions': 'Terms and Conditions',
          'accept_terms_and_conditions': 'Accept Terms & Conditions',
          'about_you': 'About you',
          'monthly_salary': 'Monthly salary',
          'enter_your_salary': 'Enter your salary',
          'monthly_expenses': 'Monthly expenses',
          'enter_your_monthly_expenses':
              'Enter your estimated monthly expenses',
          'amount': 'Amount',
          'enter_the_loan_amount': 'Enter the loan amount',
          'term': 'Term',
          'enter_the_term': 'Enter the term',
          'apply_for_loan': 'Apply for loan',
          'please_complete_the_form': 'Please complete the form',
          'you_have_to_accept_the_terms_and_conditions':
              'You have to accept the terms and conditions',
          'help_is_on_the_way': 'Help is on the way, stay put!',
          'something_wrong': 'Something wrong? Get help',
          //Loan logic
          'loan_declined_message':
              'Ooopsss. Your application has been declined. It\'s not your fault, it\'s a financial crisis.',
          'loan_accepted_message':
              'Yeeeyyy !! Congrats. Your application has been approved. Don\'t tell your friends you have money!',
          'go_back': 'Go back',
        },
        'de_DE': {
          'hello': 'Hallo Welt',
          'loan_application': 'Changed lol',
        }
      };
}
