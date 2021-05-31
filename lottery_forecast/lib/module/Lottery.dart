class Lottery{
  String res;
  String date;
  String no;   // 期数
  String type = "ssq";

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res'] = this.res;
    data['date'] = this.date;
    data['no'] = this.no;
    data['type'] = this.type;
    return data;
  }

}