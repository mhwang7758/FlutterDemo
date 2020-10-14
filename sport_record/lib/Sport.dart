class Sport{
  String name;
  int id;
  int time;
  bool finish = false;
  bool delete = false;

  Sport({this.name, this.id, this.time});


  String getName(){
    return this.name;
  }

  void setName(String name){
    this.name = name;
  }

  int getId(){
    return this.id;
  }

  void setId(int id){
    this.id = id;
  }

  int getTime(){
    return this.time;
  }

  void setTime(int time){
    this.time = time;
  }

  bool isFinish(){
    return this.finish;
  }

  void setFinish(bool checked){
    this.finish = checked;
  }

  bool isDelete(){
    return this.delete;
  }

  void setDelete(bool delete){
    this.delete = delete;
  }

}