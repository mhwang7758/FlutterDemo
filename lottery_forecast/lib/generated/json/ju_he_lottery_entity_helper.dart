import 'package:lottery_forecast/module/ju_he_lottery_entity.dart';

juHeLotteryEntityFromJson(JuHeLotteryEntity data, Map<String, dynamic> json) {
	if (json['reason'] != null) {
		data.reason = json['reason'].toString();
	}
	if (json['result'] != null) {
		data.result = new JuHeLotteryResult().fromJson(json['result']);
	}
	if (json['error_code'] != null) {
		data.errorCode = json['error_code'] is String
				? int.tryParse(json['error_code'])
				: json['error_code'].toInt();
	}
	return data;
}

Map<String, dynamic> juHeLotteryEntityToJson(JuHeLotteryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['reason'] = entity.reason;
	if (entity.result != null) {
		data['result'] = entity.result.toJson();
	}
	data['error_code'] = entity.errorCode;
	return data;
}

juHeLotteryResultFromJson(JuHeLotteryResult data, Map<String, dynamic> json) {
	if (json['lotteryResList'] != null) {
		data.lotteryResList = new List<JuHeLotteryResultLotteryResList>();
		(json['lotteryResList'] as List).forEach((v) {
			data.lotteryResList.add(new JuHeLotteryResultLotteryResList().fromJson(v));
		});
	}
	if (json['page'] != null) {
		data.page = json['page'] is String
				? int.tryParse(json['page'])
				: json['page'].toInt();
	}
	if (json['pageSize'] != null) {
		data.pageSize = json['pageSize'] is String
				? int.tryParse(json['pageSize'])
				: json['pageSize'].toInt();
	}
	if (json['totalPage'] != null) {
		data.totalPage = json['totalPage'] is String
				? int.tryParse(json['totalPage'])
				: json['totalPage'].toInt();
	}
	return data;
}

Map<String, dynamic> juHeLotteryResultToJson(JuHeLotteryResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.lotteryResList != null) {
		data['lotteryResList'] =  entity.lotteryResList.map((v) => v.toJson()).toList();
	}
	data['page'] = entity.page;
	data['pageSize'] = entity.pageSize;
	data['totalPage'] = entity.totalPage;
	return data;
}

juHeLotteryResultLotteryResListFromJson(JuHeLotteryResultLotteryResList data, Map<String, dynamic> json) {
	if (json['lottery_id'] != null) {
		data.lotteryId = json['lottery_id'].toString();
	}
	if (json['lottery_res'] != null) {
		data.lotteryRes = json['lottery_res'].toString();
	}
	if (json['lottery_no'] != null) {
		data.lotteryNo = json['lottery_no'].toString();
	}
	if (json['lottery_date'] != null) {
		data.lotteryDate = json['lottery_date'].toString();
	}
	if (json['lottery_exdate'] != null) {
		data.lotteryExdate = json['lottery_exdate'].toString();
	}
	if (json['lottery_sale_amount'] != null) {
		data.lotterySaleAmount = json['lottery_sale_amount'].toString();
	}
	if (json['lottery_pool_amount'] != null) {
		data.lotteryPoolAmount = json['lottery_pool_amount'].toString();
	}
	return data;
}

Map<String, dynamic> juHeLotteryResultLotteryResListToJson(JuHeLotteryResultLotteryResList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['lottery_id'] = entity.lotteryId;
	data['lottery_res'] = entity.lotteryRes;
	data['lottery_no'] = entity.lotteryNo;
	data['lottery_date'] = entity.lotteryDate;
	data['lottery_exdate'] = entity.lotteryExdate;
	data['lottery_sale_amount'] = entity.lotterySaleAmount;
	data['lottery_pool_amount'] = entity.lotteryPoolAmount;
	return data;
}