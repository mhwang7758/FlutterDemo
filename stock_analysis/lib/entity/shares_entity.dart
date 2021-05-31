/// ret : 1
/// errorCode : 0
/// datas : {"shares":[{"id":3146,"gid":"sh600550","name":"保变电器","createTime":"20210519100749","isDelete":0},{"id":3147,"gid":"sh605277","name":"新亚电子","createTime":"20210519100824","isDelete":0},{"id":3148,"gid":"sz0000728","name":"国元证券","createTime":"20210519100857","isDelete":0},{"id":3149,"gid":"sz000728","name":"国元证券","createTime":"20210519100926","isDelete":0},{"id":3150,"gid":"sz000651","name":"格力电器","createTime":"20210519100945","isDelete":0},{"id":3151,"gid":"sh601778","name":"晶科科技","createTime":"20210519101017","isDelete":0},{"id":3152,"gid":"sh603815","name":"交建股份","createTime":"20210519101047","isDelete":0},{"id":3153,"gid":"sh601318","name":"中国平安","createTime":"20210519101109","isDelete":0},{"id":3154,"gid":"sh601609","name":"金田铜业","createTime":"20210519101137","isDelete":0},{"id":3155,"gid":"sh603709","name":"中源家居","createTime":"20210519101201","isDelete":0},{"id":3156,"gid":"sz002699","name":"美盛文化","createTime":"20210519101242","isDelete":0},{"id":3157,"gid":"sz002127","name":"南极电商","createTime":"20210519101306","isDelete":0}]}

class ShareEntity {
  late int ret;
  late int errorCode;
  late DatasBean datas;

  static ShareEntity fromMap(Map<String, dynamic> map) {
    ShareEntity shareEntityBean = ShareEntity();
    shareEntityBean.ret = map['ret'];
    shareEntityBean.errorCode = map['errorCode'];
    DatasBean? bean = DatasBean.fromMap(map['datas']);
    if (bean == null){
      return shareEntityBean;
    }
    shareEntityBean.datas = bean;
    return shareEntityBean;
  }

  Map toJson() => {
    "ret": ret,
    "errorCode": errorCode,
    "datas": datas,
  };
}

/// shares : [{"id":3146,"gid":"sh600550","name":"保变电器","createTime":"20210519100749","isDelete":0},{"id":3147,"gid":"sh605277","name":"新亚电子","createTime":"20210519100824","isDelete":0},{"id":3148,"gid":"sz0000728","name":"国元证券","createTime":"20210519100857","isDelete":0},{"id":3149,"gid":"sz000728","name":"国元证券","createTime":"20210519100926","isDelete":0},{"id":3150,"gid":"sz000651","name":"格力电器","createTime":"20210519100945","isDelete":0},{"id":3151,"gid":"sh601778","name":"晶科科技","createTime":"20210519101017","isDelete":0},{"id":3152,"gid":"sh603815","name":"交建股份","createTime":"20210519101047","isDelete":0},{"id":3153,"gid":"sh601318","name":"中国平安","createTime":"20210519101109","isDelete":0},{"id":3154,"gid":"sh601609","name":"金田铜业","createTime":"20210519101137","isDelete":0},{"id":3155,"gid":"sh603709","name":"中源家居","createTime":"20210519101201","isDelete":0},{"id":3156,"gid":"sz002699","name":"美盛文化","createTime":"20210519101242","isDelete":0},{"id":3157,"gid":"sz002127","name":"南极电商","createTime":"20210519101306","isDelete":0}]

class DatasBean {
  late List<SharesBean> shares;

  static DatasBean? fromMap(Map<String, dynamic> map) {
    DatasBean datasBean = DatasBean();
    List shares = map['shares'] as List;
    // if (shares == null) return null;
    datasBean.shares = []..addAll(
        shares.map((o) => SharesBean.fromMap(o))
    );
    return datasBean;
  }

  Map toJson() => {
    "shares": shares,
  };
}

/// id : 3146
/// gid : "sh600550"
/// name : "保变电器"
/// createTime : "20210519100749"
/// isDelete : 0

class SharesBean {
  late int id;
  late String gid;
  late String name;
  late String createTime;
  late int isDelete;

  static SharesBean fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;
    SharesBean sharesBean = SharesBean();
    sharesBean.id = map['id'];
    sharesBean.gid = map['gid'];
    sharesBean.name = map['name'];
    sharesBean.createTime = map['createTime'];
    sharesBean.isDelete = map['isDelete'];
    return sharesBean;
  }

  Map toJson() => {
    "id": id,
    "gid": gid,
    "name": name,
    "createTime": createTime,
    "isDelete": isDelete,
  };
}