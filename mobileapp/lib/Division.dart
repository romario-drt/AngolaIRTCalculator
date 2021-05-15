class Division{
  int number;
  double min;
  double max;
  double fixedParcel;
  double tax;
  double excess;
  
  Division(this.number,this.min, this.max, this.fixedParcel, this.tax,this.excess);
  
  String toString(){
    return "[number:$number],[min:$min],[,max:$max],[fixedParcel:$fixedParcel],[tax:$tax],[excess:$excess]";
  }
  
}
