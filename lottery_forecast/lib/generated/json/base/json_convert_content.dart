// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:lottery_forecast/module/ju_he_lottery_entity.dart';
import 'package:lottery_forecast/generated/json/ju_he_lottery_entity_helper.dart';
import 'package:lottery_forecast/module/my_net_lottery_data_entity.dart';
import 'package:lottery_forecast/generated/json/my_net_lottery_data_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case JuHeLotteryEntity:
				return juHeLotteryEntityFromJson(data as JuHeLotteryEntity, json) as T;
			case JuHeLotteryResult:
				return juHeLotteryResultFromJson(data as JuHeLotteryResult, json) as T;
			case JuHeLotteryResultLotteryResList:
				return juHeLotteryResultLotteryResListFromJson(data as JuHeLotteryResultLotteryResList, json) as T;
			case MyNetLotteryDataEntity:
				return myNetLotteryDataEntityFromJson(data as MyNetLotteryDataEntity, json) as T;
			case MyNetLotteryDataDatas:
				return myNetLotteryDataDatasFromJson(data as MyNetLotteryDataDatas, json) as T;
			case MyNetLotteryDataDatasLottery:
				return myNetLotteryDataDatasLotteryFromJson(data as MyNetLotteryDataDatasLottery, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case JuHeLotteryEntity:
				return juHeLotteryEntityToJson(data as JuHeLotteryEntity);
			case JuHeLotteryResult:
				return juHeLotteryResultToJson(data as JuHeLotteryResult);
			case JuHeLotteryResultLotteryResList:
				return juHeLotteryResultLotteryResListToJson(data as JuHeLotteryResultLotteryResList);
			case MyNetLotteryDataEntity:
				return myNetLotteryDataEntityToJson(data as MyNetLotteryDataEntity);
			case MyNetLotteryDataDatas:
				return myNetLotteryDataDatasToJson(data as MyNetLotteryDataDatas);
			case MyNetLotteryDataDatasLottery:
				return myNetLotteryDataDatasLotteryToJson(data as MyNetLotteryDataDatasLottery);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (JuHeLotteryEntity).toString()){
			return JuHeLotteryEntity().fromJson(json);
		}	else if(type == (JuHeLotteryResult).toString()){
			return JuHeLotteryResult().fromJson(json);
		}	else if(type == (JuHeLotteryResultLotteryResList).toString()){
			return JuHeLotteryResultLotteryResList().fromJson(json);
		}	else if(type == (MyNetLotteryDataEntity).toString()){
			return MyNetLotteryDataEntity().fromJson(json);
		}	else if(type == (MyNetLotteryDataDatas).toString()){
			return MyNetLotteryDataDatas().fromJson(json);
		}	else if(type == (MyNetLotteryDataDatasLottery).toString()){
			return MyNetLotteryDataDatasLottery().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(List<JuHeLotteryEntity>() is M){
			return data.map<JuHeLotteryEntity>((e) => JuHeLotteryEntity().fromJson(e)).toList() as M;
		}	else if(List<JuHeLotteryResult>() is M){
			return data.map<JuHeLotteryResult>((e) => JuHeLotteryResult().fromJson(e)).toList() as M;
		}	else if(List<JuHeLotteryResultLotteryResList>() is M){
			return data.map<JuHeLotteryResultLotteryResList>((e) => JuHeLotteryResultLotteryResList().fromJson(e)).toList() as M;
		}	else if(List<MyNetLotteryDataEntity>() is M){
			return data.map<MyNetLotteryDataEntity>((e) => MyNetLotteryDataEntity().fromJson(e)).toList() as M;
		}	else if(List<MyNetLotteryDataDatas>() is M){
			return data.map<MyNetLotteryDataDatas>((e) => MyNetLotteryDataDatas().fromJson(e)).toList() as M;
		}	else if(List<MyNetLotteryDataDatasLottery>() is M){
			return data.map<MyNetLotteryDataDatasLottery>((e) => MyNetLotteryDataDatasLottery().fromJson(e)).toList() as M;
		}
		return null;
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}