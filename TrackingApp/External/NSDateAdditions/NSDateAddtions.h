//
//  NSDateAddtions.h
#import <Foundation/Foundation.h>

#if TARGET_OS_EMBEDDED
typedef NSDate NSCalendarDate;
#endif

extern NSString *kChineseYear;
extern NSString *kZodiacSignKey;
extern NSString *kZodiacStoneKey;


#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate(NSDateAddtions)

+ (NSDate *)dateFromWebApiFormat:(NSString*)dateString;

+ (id)dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day hour:(NSUInteger)hour minute:(NSUInteger)minute second:(NSUInteger)second timeZone:(NSTimeZone *)aTimeZone;
- (NSInteger)yearOfCommonEra;
- (NSInteger)monthOfYear;
- (NSInteger)dayOfMonth;
- (NSInteger)firstDayOfMonth;
- (NSInteger)dayOfWeek;
- (NSInteger)hourOfDay;
- (NSInteger)minuteOfHour;
- (NSInteger)secondOfMinute;
- (NSDate *)dateByAddingYears:(NSInteger)year months:(NSInteger)month days:(NSInteger)day hours:(NSInteger)hour minutes:(NSInteger)minute seconds:(NSInteger)second;
- (NSInteger)diffrenceInDates:(NSDate*)withDate;
- (NSUInteger)age;
- (NSDictionary*)astrologyDetails;
- (NSInteger)dayOfCurrentYear;
- (NSInteger)getNumberOfDaysForMonth:(NSInteger)month;
- (NSInteger)numberOfWeeksInMonth;

- (NSInteger)quarter;
- (NSInteger)halfYear;

- (NSInteger)weekOfYear;
//- (int)week;
- (NSInteger)weekDay;
- (NSInteger)daysInMonth;
- (NSDate*)getAbosoluteDate;
- (NSDate*)getGMTdate;

- (int)minutesFromDate:(NSDate*)date;

- (NSString*)webApiFormat;
- (NSString*)frenchFormat;
- (NSString*)getShortDay;
- (NSString*)monthFullString;
- (NSString*)dayString;
- (NSString*)timeString;
- (NSString*)hourString;
//- (NSString*)timeStringWithSeconds;

//Erica
// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSUInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSUInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSUInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSUInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSUInteger) dMinutes;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isThisWeekend;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

// Adjusting dates
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;
- (NSDate *) dateAtStartOfWeek;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

-(void)difrenceinDays:(NSString**)days inHours:(NSString**)hours inMinutes:(NSString**)mins inSeconds:(NSString**)seconds toDate:(NSDate *)toDate;


@end
