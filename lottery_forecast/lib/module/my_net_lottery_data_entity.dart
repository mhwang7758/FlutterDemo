import 'package:lottery_forecast/generated/json/base/json_convert_content.dart';

class MyNetLotteryDataEntity with JsonConvert<MyNetLotteryDataEntity> {
	int ret;
	int errorCode;
	MyNetLotteryDataDatas datas;
}

class MyNetLotteryDataDatas with JsonConvert<MyNetLotteryDataDatas> {
	List<MyNetLotteryDataDatasLottery> lottery;
}

class MyNetLotteryDataDatasLottery with JsonConvert<MyNetLotteryDataDatasLottery> {
	int id;
	String no;
	String res;
	String date;
	String type;
}
