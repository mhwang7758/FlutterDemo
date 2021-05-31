import 'package:lottery_forecast/module/ball.dart';
import 'dart:math';
import 'package:lottery_forecast/module/my_net_lottery_data_entity.dart';

typedef OnChooseBallProgress = void Function(String progress, int checkBall);
typedef OnChooseBallSuccess = void Function(Ball ball, double percent);
class LotteryForecast{
  // factory LotteryForecast() => _getInstance();
  // static LotteryForecast _instance;
  // static LotteryForecast get instance => _getInstance();
  //
  // static LotteryForecast _getInstance(){
  //   if (_instance == null){
  //     _instance = new LotteryForecast();
  //   }
  //   return _instance;
  // }

  OnChooseBallProgress progress;
  OnChooseBallSuccess success;
  var redBalls = new List<Ball>();   // 红球，下标为数字，值为出现的频率
  var blueBalls = new List<Ball>();  // 蓝球
  var redBallMap = new Map();
  var blueBallMap = new Map();
  var checkBallList = new List<Ball>();
  List<MyNetLotteryDataDatasLottery> lotterys;
  int checkRedBallIndex = 0;
  int checkBlueBallIndex = 0;
  List<String> toDayLotteryNums = new List<String>();

  static const int WARNING_STATE_TIME = 2;

  _addRedBallFreq(int bNum){
    for (Ball ball in redBalls){
      if (ball.num == bNum){
        ball.freq = ball.freq + 1;
      }
    }
  }

  _addBlueBallFreq(int bNum){
    for (Ball ball in blueBalls){
      if (ball.num == bNum){
        ball.freq = ball.freq + 1;
      }
    }
  }

  initBalls(List<MyNetLotteryDataDatasLottery> lotterys){
    this.lotterys = lotterys;
    redBalls.clear();
    blueBalls.clear();
    // 初始化数组
    for (int i = 0; i < 33; i++){
      Ball ball = new Ball(i+1, 0);
      redBalls.add(ball);
    }
    for (int i = 0; i < 16; i++){
      Ball ball = new Ball(i + 1, 0);
      blueBalls.add(ball);
    }
    for (MyNetLotteryDataDatasLottery lottery in lotterys){
      String res = lottery.res;
      List<String> balls = res.split(",");
      // print(balls);
      for (int i = 0; i < balls.length; i++){
        int ball = int.parse(balls[i]);
        if (i == balls.length - 1){
          _addBlueBallFreq(ball);
        }else {
          _addRedBallFreq(ball);
        }
      }
    }
    // 排序
    redBalls.sort((a,b)=>b.freq.compareTo(a.freq));
    blueBalls.sort((a,b)=>b.freq.compareTo(a.freq));

    // _printBalls();
  }

  setOnBallCheck(OnChooseBallProgress progress, OnChooseBallSuccess success){
    this.progress = progress;
    this.success = success;
  }

  clearCheckBalls(){
    checkBallList.clear();
  }

  checkBalls() async{
    Ball ball;
    if (checkBallList.length < 6) {
      ball = await _checkRedBall();
    }else{
      ball = await _checkBlueBall();
    }

    updateProgress("选球成功=>", ball.num,WARNING_STATE_TIME);
    double percent = ball.freq / this.lotterys.length;
    checkBallList.add(ball);
    await updateSuccess(ball, percent);
  }

  _getRedBall() async{
    // 如果是第一、第二个球，则取出现频率最高的
    // 第三和第四个球选随机
    // 第四和第五选出现
    Ball ball;
    int length = checkBallList.length;
    switch(length){
      case 0:
      case 1:
      {
        ball = redBalls[checkRedBallIndex % redBalls.length];
        checkRedBallIndex = checkRedBallIndex + 1;
        await updateProgress("选取到出现频率高的红球=>", ball.num, 1);
      }
      break;
      case 2:
      case 3:
      {
        // 随机获取
        int index = new Random().nextInt(redBalls.length);
        ball = redBalls[index];
        await updateProgress("选取随机出现的红球=>", ball.num,1);
      }
      break;
      case 4:
        {
          // 取中间
          int len = length;
          int index = (len / 2).round();
          ball = redBalls[index];
          // 因为这里的Len是固定的，无论重复取多少次结果都一样，所以提前判断是否不合适
          while (_isListExistsBall(ball.num) || _checkIsAppearFromLastTwoTimes(ball.num)) {
            await updateProgress("选取中间值的红球出现重复，将重新选择=>", ball.num,WARNING_STATE_TIME);
            index = index + 1;
            ball = redBalls[index];
          }
          await updateProgress("选取到中间值的红球=>", ball.num,1);
        }
        break;
      case 5:
        {
          // 取出现最少次数的和一个随机的球的中间值
          Ball minBall = redBalls[length - 1];
          int rand = new Random().nextInt(redBalls.length);
          Ball randBall = redBalls[rand];
          int num = ((minBall.num + randBall.num) / 2).round();
          for (Ball b in redBalls) {
            if (b.num == num) {
              ball = b;
            }
          }
          await updateProgress("选取到出现频率低及随机红球的平均球=>", ball.num,1);
        }
        break;
      default:{
        await updateProgress("超出边界，重新选球", -1, WARNING_STATE_TIME);
        checkBallList.clear();
        _getRedBall();
        break;
      }

    }

    return ball;
  }

  _getBlueBall(bool rand){
    Ball ball;
    if (rand){
      int seed = new Random().nextInt(16);
      ball = blueBalls[seed];
    }else{
      ball = blueBalls[checkBlueBallIndex % blueBalls.length];
      checkBlueBallIndex = checkBlueBallIndex + 1;
    }
    return ball;
  }

  _checkBlueBall() async{
    int appearCount = 0;
    Ball ball = _getBlueBall(false);
    while(_checkIsAppearFromLastTwoTimes(ball.num)){
      await updateProgress("该蓝球最近2期出现过2次,将再次选择=>", ball.num, WARNING_STATE_TIME);
      if (appearCount > 2){
        ball = _getBlueBall(true);
      }else {
        ball = _getBlueBall(false);
      }
      appearCount = appearCount+1;
    }
    return ball;
  }

  _checkRedBall() async{
    // 取出第一个数字
    Ball ball = await _getRedBall();
    await updateProgress("计算该红球是否符合=>",ball.num, WARNING_STATE_TIME);
    // 查看是否已存在选球列表中
    while(_isListExistsBall(ball.num)){
      await updateProgress("该球已存在列表中,将再次选择=>", ball.num, WARNING_STATE_TIME);
      ball = await _getRedBall();
    }
    // 查看是否在前2期出现过
    while(_checkIsAppearFromLastTwoTimes(ball.num)){
      await updateProgress("最近2期出现过2次,将再次选择", ball.num, WARNING_STATE_TIME);
      ball = await _getRedBall();
    }
    return ball;
  }
  
  updateProgress(String msg, int num, int time) async{
    this.progress(msg, num);
    await Future.delayed(Duration(seconds: time), (){

    });
  }

  Future updateSuccess(Ball ball, double percent) async{
    this.success(ball,percent);
    await Future.delayed(Duration(seconds: 1), (){

    });
  }

  // 最近两期都出现过算出现
  _checkIsAppearFromLastTwoTimes(int bNum){
    String res1 = this.lotterys[0].res;
    String res2 = this.lotterys[1].res;
    return res1.contains(bNum.toString()) && res2.contains(bNum.toString());
  }

  _isListExistsBall(bNum){
    for (Ball ball in checkBallList){
      if (ball.num == bNum){
        return true;
      }
    }
    return false;
  }

  _printBalls(){
    // 输出打印
    for (int i = 0; i < redBalls.length; i++){
      print("红球从高到低出现频率依次是=>"+redBalls[i].num.toString()
          + " 频率=>"+redBalls[i].freq.toString());
    }
    // 输出打印
    for (int i = 0; i < blueBalls.length; i++){
      print("蓝球从高到低出现频率依次是=>"+blueBalls[i].num.toString()
          + " 频率=>"+blueBalls[i].freq.toString());
    }
  }
}