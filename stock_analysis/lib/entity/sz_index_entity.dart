/// ret : 1
/// errorCode : 0
/// datas : {"sharesDetail":[{"id":3243,"date":"2021-05-24","name":"上证指数","dealNum":"116933890","dealPri":"140528831989","highPri":"3496.1502","increPer":"-0.39","increase":"-13.5696","lowpri":"3469.8746","nowpri":"3472.9873","openPri":"3486.2711","time":"2021-05-24 10:14:53","yesPri":"3486.5569"},{"id":3255,"date":"2021-05-24","name":"上证指数","dealNum":"289509242","dealPri":"367181627934","highPri":"3498.3037","increPer":"0.31","increase":"10.7252","lowpri":"3469.8746","nowpri":"3497.2821","openPri":"3486.2711","time":"2021-05-24 15:04:58","yesPri":"3486.5569"}]}

class SzIndexEntity {
  int ret = 0;
  int errorCode = 0;
  late DatasBean datas;

  static SzIndexEntity fromMap(Map<String, dynamic> map) {
    SzIndexEntity szIndexEntityBean = SzIndexEntity();
    szIndexEntityBean.ret = map['ret'];
    szIndexEntityBean.errorCode = map['errorCode'];
    szIndexEntityBean.datas = DatasBean.fromMap(map['datas']);
    return szIndexEntityBean;
  }

  Map toJson() => {
    "ret": ret,
    "errorCode": errorCode,
    "datas": datas,
  };
}

/// sharesDetail : [{"id":3243,"date":"2021-05-24","name":"上证指数","dealNum":"116933890","dealPri":"140528831989","highPri":"3496.1502","increPer":"-0.39","increase":"-13.5696","lowpri":"3469.8746","nowpri":"3472.9873","openPri":"3486.2711","time":"2021-05-24 10:14:53","yesPri":"3486.5569"},{"id":3255,"date":"2021-05-24","name":"上证指数","dealNum":"289509242","dealPri":"367181627934","highPri":"3498.3037","increPer":"0.31","increase":"10.7252","lowpri":"3469.8746","nowpri":"3497.2821","openPri":"3486.2711","time":"2021-05-24 15:04:58","yesPri":"3486.5569"}]

class DatasBean {
  late List<SZIndexBean> beans;

  static DatasBean fromMap(Map<String, dynamic> map) {
    DatasBean datasBean = DatasBean();

    List shares = map['szindex'] as List;  //todo 这里的字段会改
    datasBean.beans = []..addAll(
        shares.map((o) => SZIndexBean.fromMap(o))
    );
    return datasBean;
  }

  Map toJson() => {
    "szindex": beans,
  };
}

/// id : 3243
/// date : "2021-05-24"
/// name : "上证指数"
/// dealNum : "116933890"
/// dealPri : "140528831989"
/// highPri : "3496.1502"
/// increPer : "-0.39"
/// increase : "-13.5696"
/// lowpri : "3469.8746"
/// nowpri : "3472.9873"
/// openPri : "3486.2711"
/// time : "2021-05-24 10:14:53"
/// yesPri : "3486.5569"

class SZIndexBean {
  late int id;
  late String date;
  late String name;
  late String dealNum;
  late String dealPri;
  late String highPri;
  late String increPer;
  late String increase;
  late String lowpri;
  late String nowpri;
  late String openPri;
  late String time;
  late String yesPri;

  static SZIndexBean fromMap(Map<String, dynamic> map) {
    SZIndexBean sharesDetailBean = SZIndexBean();
    sharesDetailBean.id = map['id'];
    sharesDetailBean.date = map['date'];
    sharesDetailBean.name = map['name'];
    sharesDetailBean.dealNum = map['dealNum'];
    sharesDetailBean.dealPri = map['dealPri'];
    sharesDetailBean.highPri = map['highPri'];
    sharesDetailBean.increPer = map['increPer'];
    sharesDetailBean.increase = map['increase'];
    sharesDetailBean.lowpri = map['lowpri'];
    sharesDetailBean.nowpri = map['nowpri'];
    sharesDetailBean.openPri = map['openPri'];
    sharesDetailBean.time = map['time'];
    sharesDetailBean.yesPri = map['yesPri'];
    return sharesDetailBean;
  }

  Map toJson() => {
    "id": id,
    "date": date,
    "name": name,
    "dealNum": dealNum,
    "dealPri": dealPri,
    "highPri": highPri,
    "increPer": increPer,
    "increase": increase,
    "lowpri": lowpri,
    "nowpri": nowpri,
    "openPri": openPri,
    "time": time,
    "yesPri": yesPri,
  };
}