abstract class Report{
  static const int UN_KNOW = 0;
  static const int UP = 1;
  static const int DOWN = 2;
  static const int UP_THAN_DOWN = 3;
  static const int DOWN_THAN_UP = 4;
  List<String> createReport();
}