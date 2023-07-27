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
          'top up': 'Top Up',
          'loan': 'Loan',
          'recent activity': 'Recent Activity',
          'today': 'Today',
          'yesterday': 'Yesterday',
          //Transaction details screen
          'transaction id': 'Transaction ID',
          'subscription': 'Subscription',
          'repeating payment': 'Repeating payment',
          'share the cost': 'Share the cost',
          'split the bill': 'Split the bill',
          'split this bill': 'Split this bill',
          'add receipt': 'Add receipt',
          //Pay screen
          'how much': 'How much?',
          'next': 'Next',
          'to whom': 'To whom?',
          'insufficient funds': 'Insufficient funds',
          //Top up screen
          'what is the source': 'What is the source?',
          //Loan application screen
          'loan application': 'Loan application',
          'terms and conditions': 'Terms and Conditions',
          'accept terms and conditions': 'Accept Terms & Conditions',
          'about you': 'About you',
          'monthly salary': 'Monthly salary',
          'enter your salary': 'Enter your salary',
          'monthly expenses': 'Monthly expenses',
          'enter your monthly expenses':
              'Enter your estimated monthly expenses',
          'amount': 'Amount',
          'enter the loan amount': 'Enter the loan amount',
          'term': 'Term',
          'enter the term': 'Enter the term',
          'apply for loan': 'Apply for loan',
          'please complete the form': 'Please complete the form',
          'you have to accept the terms and conditions':
              'You have to accept the terms and conditions',
          'help is on the way': 'Help is on the way, stay put!',
          'something wrong': 'Something wrong? Get help',
          //Loan logic
          'loan declined message':
              'Ooopsss. Your application has been declined. It\'s not your fault, it\'s a financial crisis.',
          'loan accepted message':
              'Yeeeyyy !! Congrats. Your application has been approved. Don\'t tell your friends you have money!',
          'go back': 'Go back',
        },
        'de_DE': {
          'hello': 'Hallo Welt',
          'loan application': 'Changed lol',
        }
      };
}
