import 'bank.dart';

class Sbi extends Bank{

  double myMoney= 0.0;

  @override
  void deposit() {
    print("Added money to account");
    myMoney++;
  }

  @override
  void statement() {
    print("I have $myMoney money");
  }

  @override
  void withdraw() {
   print("Money Taken from account");
   myMoney--;
  }
}