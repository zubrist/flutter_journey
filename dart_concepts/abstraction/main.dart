
import 'axis.dart';
import 'sbi.dart';

void main(){
  Sbi sbi = Sbi();
  sbi.statement();
  sbi.deposit();
  sbi.deposit();
  sbi.withdraw();

  sbi.statement();

  Axis axis = Axis();
  axis.statement();
  axis.deposit();
  axis.deposit();
  axis.withdraw();
  axis.statement();

}