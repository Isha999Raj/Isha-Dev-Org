public class assignment5 {
    public static integer day;
    public static integer month;
    public static integer year;
  /*  public assignment5(integer d, integer m, integer y)
    {
        day = d;
        month = m;
        year = y;
    } */
    public void display()
    {
        system.debug('day :' +day);
        system.debug('month :' +month);
        system.debug('year :' +year);
    }
    public void display_date(integer day, integer month, integer year)
    {
        date mydate = Date.newInstance(day,month,year);
        system.debug('Date is :' +mydate);
    }

}