import 'package:lottery_forecast/module/my_net_lottery_data_entity.dart';

myNetLotteryDataEntityFromJson(MyNetLotteryDataEntity data, Map<String, dynamic> json) {
	if (json['ret'] != null) {
		data.ret = json['ret'] is String
				? int.tryParse(json['ret'])
				: json['ret'].toInt();
	}
	if (json['errorCode'] != null) {
		data.errorCode = json['errorCode'] is String
				? int.tryParse(json['errorCode'])
				: json['errorCode'].toInt();
	}
	if (json['datas'] != null) {
		data.datas = new MyNetLotteryDataDatas().fromJson(json['datas']);
	}
	return data;
}

Map<String, dynamic> myNetLotteryDataEntityToJson(MyNetLotteryDataEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ret'] = entity.ret;
	data['errorCode'] = entity.errorCode;
	if (entity.datas != null) {
		data['datas'] = entity.datas.toJson();
	}
	return data;
}

myNetLotteryDataDatasFromJson(MyNetLotteryDataDatas data, Map<String, dynamic> json) {
	if (json['lottery'] != null) {
		data.lottery = new List<MyNetLotteryDataDatasLottery>();
		(json['lottery'] as List).forEach((v) {
			data.lottery.add(new MyNetLotteryDataDatasLottery().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> myNetLotteryDataDatasToJson(MyNetLotteryDataDatas entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.lottery != null) {
		data['lottery'] =  entity.lottery.map((v) => v.toJson()).toList();
	}
	return data;
}

myNetLotteryDataDatasLotteryFromJson(MyNetLotteryDataDatasLottery data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['no'] != null) {
		data.no = json['no'].toString();
	}
	if (json['res'] != null) {
		data.res = json['res'].toString();
	}
	if (json['date'] != null) {
		data.date = json['date'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	return data;
}

Map<String, dynamic> myNetLotteryDataDatasLotteryToJson(MyNetLotteryDataDatasLottery entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['no'] = entity.no;
	data['res'] = entity.res;
	data['date'] = entity.date;
	data['type'] = entity.type;
	return data;
}