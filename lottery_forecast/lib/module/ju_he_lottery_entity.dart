import 'package:lottery_forecast/generated/json/base/json_convert_content.dart';
import 'package:lottery_forecast/generated/json/base/json_field.dart';

class JuHeLotteryEntity with JsonConvert<JuHeLotteryEntity> {
	String reason;
	JuHeLotteryResult result;
	@JSONField(name: "error_code")
	int errorCode;
}

class JuHeLotteryResult with JsonConvert<JuHeLotteryResult> {
	List<JuHeLotteryResultLotteryResList> lotteryResList;
	int page;
	int pageSize;
	int totalPage;
}

class JuHeLotteryResultLotteryResList with JsonConvert<JuHeLotteryResultLotteryResList> {
	@JSONField(name: "lottery_id")
	String lotteryId;
	@JSONField(name: "lottery_res")
	String lotteryRes;
	@JSONField(name: "lottery_no")
	String lotteryNo;
	@JSONField(name: "lottery_date")
	String lotteryDate;
	@JSONField(name: "lottery_exdate")
	String lotteryExdate;
	@JSONField(name: "lottery_sale_amount")
	String lotterySaleAmount;
	@JSONField(name: "lottery_pool_amount")
	String lotteryPoolAmount;
}
