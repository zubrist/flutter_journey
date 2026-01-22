import 'bank.dart';

class Axis extends Bank{

  double myMoney= 0.0;
  @override
  void deposit() {
    myMoney = myMoney+10.0;
    print("Money added to account");
  }

  @override
  void statement() {
   print("total money : $myMoney");
  }

  @override
  void withdraw() {
    myMoney = myMoney-2;
    print("withdrawl charge taken");

    
  }

  
}