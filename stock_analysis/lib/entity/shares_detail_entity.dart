/// ret : 1
/// errorCode : 0
/// datas : {"sharesDetail":[{"id":3160,"gid":"sz000728","buyFive":"180400","buyFivePri":"7.850","buyFour":"175300","buyFourPri":"7.860","buyThree":"260555","buyThreePri":"7.870","buyTwo":"260555","buyTwoPri":"7.880","buyOne":"79300","buyOnePri":"7.890","competitivePri":"7.890","reservePri":"7.900","date":"2021-05-19","increPer":"-0.63","increase":"-0.05","nowPri":"7.900","sellFive":"68800","sellFivePri":"7.940","sellFour":"116450","sellFourPri":"7.930","sellThree":"77980","sellThreePri":"7.920","sellTwo":"71341","sellTwoPri":"7.910","sellOne":"49200","sellOnePri":"7.900","time":"10:11:06","todayMax":"7.930","todayMin":"7.870","todayStartPri":"7.880","yestodEndPri":"7.940","traAmount":"42553538.940","traNumber":"53903"},{"id":3172,"gid":"sz000728","buyFive":"52200","buyFivePri":"7.840","buyFour":"471400","buyFourPri":"7.850","buyThree":"384315","buyThreePri":"7.860","buyTwo":"384315","buyTwoPri":"7.870","buyOne":"43510","buyOnePri":"7.880","competitivePri":"7.880","reservePri":"7.890","date":"2021-05-19","increPer":"-0.63","increase":"-0.05","nowPri":"7.890","sellFive":"70200","sellFivePri":"7.930","sellFour":"53000","sellFourPri":"7.920","sellThree":"171600","sellThreePri":"7.910","sellTwo":"187400","sellTwoPri":"7.900","sellOne":"162900","sellOnePri":"7.890","time":"15:00:03","todayMax":"7.970","todayMin":"7.860","todayStartPri":"7.880","yestodEndPri":"7.940","traAmount":"152629070.690","traNumber":"193220"},{"id":3184,"gid":"sz000728","buyFive":"92200","buyFivePri":"7.850","buyFour":"107300","buyFourPri":"7.860","buyThree":"101800","buyThreePri":"7.870","buyTwo":"101800","buyTwoPri":"7.880","buyOne":"57784","buyOnePri":"7.890","competitivePri":"7.890","reservePri":"7.900","date":"2021-05-20","increPer":"1.41","increase":"0.11","nowPri":"7.890","sellFive":"284650","sellFivePri":"7.940","sellFour":"251943","sellFourPri":"7.930","sellThree":"232020","sellThreePri":"7.920","sellTwo":"137900","sellTwoPri":"7.910","sellOne":"136360","sellOnePri":"7.900","time":"10:11:06","todayMax":"7.940","todayMin":"7.800","todayStartPri":"7.820","yestodEndPri":"7.790","traAmount":"92948452.720","traNumber":"118044"},{"id":3196,"gid":"sz000728","buyFive":"38700","buyFivePri":"7.870","buyFour":"259700","buyFourPri":"7.880","buyThree":"151300","buyThreePri":"7.890","buyTwo":"151300","buyTwoPri":"7.900","buyOne":"286413","buyOnePri":"7.910","competitivePri":"7.910","reservePri":"7.920","date":"2021-05-20","increPer":"1.67","increase":"0.13","nowPri":"7.920","sellFive":"113660","sellFivePri":"7.960","sellFour":"167000","sellFourPri":"7.950","sellThree":"115200","sellThreePri":"7.940","sellTwo":"265080","sellTwoPri":"7.930","sellOne":"92698","sellOnePri":"7.920","time":"15:00:03","todayMax":"8.020","todayMin":"7.800","todayStartPri":"7.820","yestodEndPri":"7.790","traAmount":"299062342.140","traNumber":"378614"},{"id":3210,"gid":"sz000728","buyFive":"251500","buyFivePri":"7.850","buyFour":"147270","buyFourPri":"7.860","buyThree":"82200","buyThreePri":"7.870","buyTwo":"82200","buyTwoPri":"7.880","buyOne":"7000","buyOnePri":"7.890","competitivePri":"7.890","reservePri":"7.900","date":"2021-05-21","increPer":"-0.38","increase":"-0.03","nowPri":"7.880","sellFive":"122500","sellFivePri":"7.940","sellFour":"148400","sellFourPri":"7.930","sellThree":"95540","sellThreePri":"7.920","sellTwo":"109930","sellTwoPri":"7.910","sellOne":"98480","sellOnePri":"7.900","time":"10:11:15","todayMax":"7.940","todayMin":"7.850","todayStartPri":"7.910","yestodEndPri":"7.920","traAmount":"62828266.160","traNumber":"79531"},{"id":3222,"gid":"sz000728","buyFive":"170000","buyFivePri":"7.760","buyFour":"123200","buyFourPri":"7.770","buyThree":"123380","buyThreePri":"7.780","buyTwo":"123380","buyTwoPri":"7.790","buyOne":"290926","buyOnePri":"7.800","competitivePri":"7.800","reservePri":"7.810","date":"2021-05-21","increPer":"-1.52","increase":"-0.12","nowPri":"7.800","sellFive":"172105","sellFivePri":"7.850","sellFour":"46450","sellFourPri":"7.840","sellThree":"122990","sellThreePri":"7.830","sellTwo":"163895","sellTwoPri":"7.820","sellOne":"93545","sellOnePri":"7.810","time":"15:00:03","todayMax":"7.940","todayMin":"7.780","todayStartPri":"7.910","yestodEndPri":"7.920","traAmount":"194092207.990","traNumber":"247133"}]}

class SharesDetailEntity {
  int ret = 0;
  int errorCode = 0;
  late DatasBean datas;

  static SharesDetailEntity fromMap(Map<String, dynamic> map) {
    SharesDetailEntity sharesDetailEntityBean = SharesDetailEntity();
    sharesDetailEntityBean.ret = map['ret'];
    sharesDetailEntityBean.errorCode = map['errorCode'];
    DatasBean? bean = DatasBean.fromMap(map['datas']);
    if (bean == null){
      return sharesDetailEntityBean;
    }
    sharesDetailEntityBean.datas = bean;
    return sharesDetailEntityBean;
  }

  Map toJson() => {
    "ret": ret,
    "errorCode": errorCode,
    "datas": datas,
  };
}

/// sharesDetail : [{"id":3160,"gid":"sz000728","buyFive":"180400","buyFivePri":"7.850","buyFour":"175300","buyFourPri":"7.860","buyThree":"260555","buyThreePri":"7.870","buyTwo":"260555","buyTwoPri":"7.880","buyOne":"79300","buyOnePri":"7.890","competitivePri":"7.890","reservePri":"7.900","date":"2021-05-19","increPer":"-0.63","increase":"-0.05","nowPri":"7.900","sellFive":"68800","sellFivePri":"7.940","sellFour":"116450","sellFourPri":"7.930","sellThree":"77980","sellThreePri":"7.920","sellTwo":"71341","sellTwoPri":"7.910","sellOne":"49200","sellOnePri":"7.900","time":"10:11:06","todayMax":"7.930","todayMin":"7.870","todayStartPri":"7.880","yestodEndPri":"7.940","traAmount":"42553538.940","traNumber":"53903"},{"id":3172,"gid":"sz000728","buyFive":"52200","buyFivePri":"7.840","buyFour":"471400","buyFourPri":"7.850","buyThree":"384315","buyThreePri":"7.860","buyTwo":"384315","buyTwoPri":"7.870","buyOne":"43510","buyOnePri":"7.880","competitivePri":"7.880","reservePri":"7.890","date":"2021-05-19","increPer":"-0.63","increase":"-0.05","nowPri":"7.890","sellFive":"70200","sellFivePri":"7.930","sellFour":"53000","sellFourPri":"7.920","sellThree":"171600","sellThreePri":"7.910","sellTwo":"187400","sellTwoPri":"7.900","sellOne":"162900","sellOnePri":"7.890","time":"15:00:03","todayMax":"7.970","todayMin":"7.860","todayStartPri":"7.880","yestodEndPri":"7.940","traAmount":"152629070.690","traNumber":"193220"},{"id":3184,"gid":"sz000728","buyFive":"92200","buyFivePri":"7.850","buyFour":"107300","buyFourPri":"7.860","buyThree":"101800","buyThreePri":"7.870","buyTwo":"101800","buyTwoPri":"7.880","buyOne":"57784","buyOnePri":"7.890","competitivePri":"7.890","reservePri":"7.900","date":"2021-05-20","increPer":"1.41","increase":"0.11","nowPri":"7.890","sellFive":"284650","sellFivePri":"7.940","sellFour":"251943","sellFourPri":"7.930","sellThree":"232020","sellThreePri":"7.920","sellTwo":"137900","sellTwoPri":"7.910","sellOne":"136360","sellOnePri":"7.900","time":"10:11:06","todayMax":"7.940","todayMin":"7.800","todayStartPri":"7.820","yestodEndPri":"7.790","traAmount":"92948452.720","traNumber":"118044"},{"id":3196,"gid":"sz000728","buyFive":"38700","buyFivePri":"7.870","buyFour":"259700","buyFourPri":"7.880","buyThree":"151300","buyThreePri":"7.890","buyTwo":"151300","buyTwoPri":"7.900","buyOne":"286413","buyOnePri":"7.910","competitivePri":"7.910","reservePri":"7.920","date":"2021-05-20","increPer":"1.67","increase":"0.13","nowPri":"7.920","sellFive":"113660","sellFivePri":"7.960","sellFour":"167000","sellFourPri":"7.950","sellThree":"115200","sellThreePri":"7.940","sellTwo":"265080","sellTwoPri":"7.930","sellOne":"92698","sellOnePri":"7.920","time":"15:00:03","todayMax":"8.020","todayMin":"7.800","todayStartPri":"7.820","yestodEndPri":"7.790","traAmount":"299062342.140","traNumber":"378614"},{"id":3210,"gid":"sz000728","buyFive":"251500","buyFivePri":"7.850","buyFour":"147270","buyFourPri":"7.860","buyThree":"82200","buyThreePri":"7.870","buyTwo":"82200","buyTwoPri":"7.880","buyOne":"7000","buyOnePri":"7.890","competitivePri":"7.890","reservePri":"7.900","date":"2021-05-21","increPer":"-0.38","increase":"-0.03","nowPri":"7.880","sellFive":"122500","sellFivePri":"7.940","sellFour":"148400","sellFourPri":"7.930","sellThree":"95540","sellThreePri":"7.920","sellTwo":"109930","sellTwoPri":"7.910","sellOne":"98480","sellOnePri":"7.900","time":"10:11:15","todayMax":"7.940","todayMin":"7.850","todayStartPri":"7.910","yestodEndPri":"7.920","traAmount":"62828266.160","traNumber":"79531"},{"id":3222,"gid":"sz000728","buyFive":"170000","buyFivePri":"7.760","buyFour":"123200","buyFourPri":"7.770","buyThree":"123380","buyThreePri":"7.780","buyTwo":"123380","buyTwoPri":"7.790","buyOne":"290926","buyOnePri":"7.800","competitivePri":"7.800","reservePri":"7.810","date":"2021-05-21","increPer":"-1.52","increase":"-0.12","nowPri":"7.800","sellFive":"172105","sellFivePri":"7.850","sellFour":"46450","sellFourPri":"7.840","sellThree":"122990","sellThreePri":"7.830","sellTwo":"163895","sellTwoPri":"7.820","sellOne":"93545","sellOnePri":"7.810","time":"15:00:03","todayMax":"7.940","todayMin":"7.780","todayStartPri":"7.910","yestodEndPri":"7.920","traAmount":"194092207.990","traNumber":"247133"}]

class DatasBean {
  late List<SharesDetailBean> sharesDetail;

  static DatasBean? fromMap(Map<String, dynamic> map) {
    DatasBean datasBean = DatasBean();

    List shares = map['sharesDetail'] as List;
    datasBean.sharesDetail = []..addAll(
        shares.map((o) => SharesDetailBean.fromMap(o))
    );
    return datasBean;
  }

  Map toJson() => {
    "sharesDetail": sharesDetail,
  };
}

/// id : 3160
/// gid : "sz000728"
/// buyFive : "180400"
/// buyFivePri : "7.850"
/// buyFour : "175300"
/// buyFourPri : "7.860"
/// buyThree : "260555"
/// buyThreePri : "7.870"
/// buyTwo : "260555"
/// buyTwoPri : "7.880"
/// buyOne : "79300"
/// buyOnePri : "7.890"
/// competitivePri : "7.890"
/// reservePri : "7.900"
/// date : "2021-05-19"
/// increPer : "-0.63"
/// increase : "-0.05"
/// nowPri : "7.900"
/// sellFive : "68800"
/// sellFivePri : "7.940"
/// sellFour : "116450"
/// sellFourPri : "7.930"
/// sellThree : "77980"
/// sellThreePri : "7.920"
/// sellTwo : "71341"
/// sellTwoPri : "7.910"
/// sellOne : "49200"
/// sellOnePri : "7.900"
/// time : "10:11:06"
/// todayMax : "7.930"
/// todayMin : "7.870"
/// todayStartPri : "7.880"
/// yestodEndPri : "7.940"
/// traAmount : "42553538.940"
/// traNumber : "53903"

class SharesDetailBean {
  late int id;
  late String gid;
  late String buyFive;
  late String buyFivePri;
  late String buyFour;
  late String buyFourPri;
  late String buyThree;
  late String buyThreePri;
  late String buyTwo;
  late String buyTwoPri;
  late String buyOne;
  late String buyOnePri;
  late String competitivePri;
  late String reservePri;
  late String date;
  late String increPer;
  late String increase;
  late String nowPri;
  late String sellFive;
  late String sellFivePri;
  late String sellFour;
  late String sellFourPri;
  late String sellThree;
  late String sellThreePri;
  late String sellTwo;
  late String sellTwoPri;
  late String sellOne;
  late String sellOnePri;
  late String time;
  late String todayMax;
  late String todayMin;
  late String todayStartPri;
  late String yestodEndPri;
  late String traAmount;
  late String traNumber;

  static SharesDetailBean fromMap(Map<String, dynamic> map) {
    SharesDetailBean sharesDetailBean = SharesDetailBean();
    sharesDetailBean.id = map['id'];
    sharesDetailBean.gid = map['gid'];
    sharesDetailBean.buyFive = map['buyFive'];
    sharesDetailBean.buyFivePri = map['buyFivePri'];
    sharesDetailBean.buyFour = map['buyFour'];
    sharesDetailBean.buyFourPri = map['buyFourPri'];
    sharesDetailBean.buyThree = map['buyThree'];
    sharesDetailBean.buyThreePri = map['buyThreePri'];
    sharesDetailBean.buyTwo = map['buyTwo'];
    sharesDetailBean.buyTwoPri = map['buyTwoPri'];
    sharesDetailBean.buyOne = map['buyOne'];
    sharesDetailBean.buyOnePri = map['buyOnePri'];
    sharesDetailBean.competitivePri = map['competitivePri'];
    sharesDetailBean.reservePri = map['reservePri'];
    sharesDetailBean.date = map['date'];
    sharesDetailBean.increPer = map['increPer'];
    sharesDetailBean.increase = map['increase'];
    sharesDetailBean.nowPri = map['nowPri'];
    sharesDetailBean.sellFive = map['sellFive'];
    sharesDetailBean.sellFivePri = map['sellFivePri'];
    sharesDetailBean.sellFour = map['sellFour'];
    sharesDetailBean.sellFourPri = map['sellFourPri'];
    sharesDetailBean.sellThree = map['sellThree'];
    sharesDetailBean.sellThreePri = map['sellThreePri'];
    sharesDetailBean.sellTwo = map['sellTwo'];
    sharesDetailBean.sellTwoPri = map['sellTwoPri'];
    sharesDetailBean.sellOne = map['sellOne'];
    sharesDetailBean.sellOnePri = map['sellOnePri'];
    sharesDetailBean.time = map['time'];
    sharesDetailBean.todayMax = map['todayMax'];
    sharesDetailBean.todayMin = map['todayMin'];
    sharesDetailBean.todayStartPri = map['todayStartPri'];
    sharesDetailBean.yestodEndPri = map['yestodEndPri'];
    sharesDetailBean.traAmount = map['traAmount'];
    sharesDetailBean.traNumber = map['traNumber'];
    return sharesDetailBean;
  }

  Map toJson() => {
    "id": id,
    "gid": gid,
    "buyFive": buyFive,
    "buyFivePri": buyFivePri,
    "buyFour": buyFour,
    "buyFourPri": buyFourPri,
    "buyThree": buyThree,
    "buyThreePri": buyThreePri,
    "buyTwo": buyTwo,
    "buyTwoPri": buyTwoPri,
    "buyOne": buyOne,
    "buyOnePri": buyOnePri,
    "competitivePri": competitivePri,
    "reservePri": reservePri,
    "date": date,
    "increPer": increPer,
    "increase": increase,
    "nowPri": nowPri,
    "sellFive": sellFive,
    "sellFivePri": sellFivePri,
    "sellFour": sellFour,
    "sellFourPri": sellFourPri,
    "sellThree": sellThree,
    "sellThreePri": sellThreePri,
    "sellTwo": sellTwo,
    "sellTwoPri": sellTwoPri,
    "sellOne": sellOne,
    "sellOnePri": sellOnePri,
    "time": time,
    "todayMax": todayMax,
    "todayMin": todayMin,
    "todayStartPri": todayStartPri,
    "yestodEndPri": yestodEndPri,
    "traAmount": traAmount,
    "traNumber": traNumber,
  };
}