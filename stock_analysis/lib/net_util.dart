import 'package:dio/dio.dart';

class NetUtil{
  static const String BASE_URL = "https://www.52code.tech";

  static NetUtil _netUtil = NetUtil._internal();

  NetUtil._internal();

  factory NetUtil() => _getInstance();
  static _getInstance(){
    return _netUtil;
  }

  Future<String> getStocks() async{
    String url = BASE_URL + "/shares";
    try{
      Response response = await Dio().get(url);
      return response.toString();
    }catch(e){
      return "";
    }
  }

  Future<String> getStockDetail(String gid) async{
    String url = BASE_URL + "/sharesdetail/"+gid;
    try{
      Response response = await Dio().get(url);
      return response.toString();
    }catch(e){
      return "";
    }
  }

  Future<String> getSZIndex() async{
    String url = BASE_URL + "/szindex";
    try{
      Response response = await Dio().get(url);
      return response.toString();
    }catch(e){
      return "";
    }
  }
}