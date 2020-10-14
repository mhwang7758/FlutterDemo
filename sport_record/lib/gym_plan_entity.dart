class GymPlanEntity {
	int ret;
	GymPlanDatas datas;
	int errorCode;

	GymPlanEntity({this.ret, this.datas, this.errorCode});

	GymPlanEntity.fromJson(Map<String, dynamic> json) {
		ret = json['ret'];
		datas = json['datas'] != null ? new GymPlanDatas.fromJson(json['datas']) : null;
		errorCode = json['errorCode'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ret'] = this.ret;
		if (this.datas != null) {
      data['datas'] = this.datas.toJson();
    }
		data['errorCode'] = this.errorCode;
		return data;
	}
}

class GymPlanDatas {
	List<GymPlanDatasPlan> plans;

	GymPlanDatas({this.plans});

	GymPlanDatas.fromJson(Map<String, dynamic> json) {
		if (json['plans'] != null) {
			plans = new List<GymPlanDatasPlan>();(json['plans'] as List).forEach((v) { plans.add(new GymPlanDatasPlan.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.plans != null) {
      data['plans'] =  this.plans.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class GymPlanDatasPlan {
	String uId;
	String createTime;
	int id;
	int time;
	String title;

	GymPlanDatasPlan({this.uId, this.createTime, this.id, this.time, this.title});

	GymPlanDatasPlan.fromJson(Map<String, dynamic> json) {
		uId = json['uId'];
		createTime = json['createTime'];
		id = json['id'];
		time = json['time'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uId'] = this.uId;
		data['createTime'] = this.createTime;
		data['id'] = this.id;
		data['time'] = this.time;
		data['title'] = this.title;
		return data;
	}
}
