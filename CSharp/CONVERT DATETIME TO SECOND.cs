
// CSharp - C# -> CONVERT DATETIME TO SECOND

namespace VMK_DATETIME_TO_SECOND
{
    public static double VMK_DATETIME_TO_SECOND(int zYear, int zMon, int zDay, int zHour, int zMinu, int zSec)
    {
        DateTime DTNow = new DateTime(zYear, zMon, zDay, zHour, zMinu, zSec);
        DateTime DT = new DateTime(2000, 1, 1, 1, 1, 1);
        TimeSpan DiFF = DTNow - DT;
        return DiFF.TotalSeconds;
    }

    public static double CREATE_SECOND_FROM_DATETIME_NOW()
    {
        string sDATE = DateTime.Now.ToString();
        DateTime DATE_Value = (Convert.ToDateTime(sDATE.ToString()));
        int DAY = DATE_Value.Day;
        int MONTH = DATE_Value.Month;
        int YEAR = DATE_Value.Year;
        int HOUR = DATE_Value.Hour;
        int MINUTE = DATE_Value.Minute;
        int SECOND = DATE_Value.Second;
        return VMK_DATETIME_TO_SECOND(YEAR, MONTH, DAY, HOUR, MINUTE, SECOND);
    }
}
