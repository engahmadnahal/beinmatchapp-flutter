class ConvertTimeMatch {
  /// Get DateTime For Now
  static DateTime dateNow = DateTime.now();
  /// Method Pass Date
  /// @return String Result [live,wait,end,time]
  static String getDate(String date){
    DateTime dateMatch = DateTime.parse(date);
    /// Get hours in timestamp
    int hoursMatch = dateMatch.hour;
    int hoursNow = dateNow.hour;
    /// Get Munit in timestamp
    int munitMatch = dateMatch.minute;
    int munitNow = dateNow.minute;
    /// Get Munit in timestamp
    int dayMatch = dateMatch.day;
    int dayNow = dateNow.day;
    if(dateMatch.isAfter(dateNow)){
      /// Match is not start , hear is calculate if time hours equal && less than 30 munit
      /// else return time start [hours]
      /// @return [wait]

      /// when minus one hour , this main check , before start match equal one hour
      if((hoursMatch - 1 ) == hoursNow){
        return "ساعة";
      }
      return "$hoursMatch:$munitMatch KSA";

    }else{
      /// Match is start , hear is calculate if time hours equal && grater than 2 hours
      /// if time hours equal && grater return [live]
      /// @return [end]

      /// add 2 hour to time match , because cond (when add 2 hour) less then now , this is main match end
      if(((hoursMatch + 2) < hoursNow) || (dayMatch < dayNow)){
        return "انتهت";
      }
      return "جارية";
    }
  }
}