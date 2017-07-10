//
//  NSDateAddtions.m
//

#import "NSDateAddtions.h"
@interface NSDate(NSDateAddtionsPrivate)
+(NSDictionary*)chineseDictDetails;
+(NSDictionary*)stoneSignDict;
@end

@implementation NSDate(NSDateAddtions)

#define DATE_OFFSET 730486	/* Number of days from January 1, 1
to January 1, 2001 */
NSString *kChineseYear = @"ChineseYear";
NSString *kZodiacSignKey = @"Sign";
NSString *kZodiacStoneKey = @"Stone";

+ (NSDate *)dateFromWebApiFormat:(NSString*)dateString
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *date = [formatter dateFromString:dateString];

    return date;
}

-(NSInteger)monthOfYear
{
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];		
	unsigned unitFlags =  NSMonthCalendarUnit;
	NSDateComponents *monthYearDateComp = [calender components:unitFlags fromDate:self];
	return [monthYearDateComp month];
	
}

-(NSInteger)yearOfCommonEra
{
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];		
	unsigned unitFlags =  NSYearCalendarUnit;
	NSDateComponents *monthYearDateComp = [calender components:unitFlags fromDate:self];
	NSInteger year = [monthYearDateComp year];
	return year;
}

- (NSInteger)dayOfMonth
{
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];		
	unsigned unitFlags =  NSDayCalendarUnit;
	NSDateComponents *monthYearDateComp = [calender components:unitFlags fromDate:self];
	return [monthYearDateComp day];
	
}

- (NSInteger)dayOfWeek
{
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];		
	unsigned unitFlags =  NSWeekdayCalendarUnit;
	NSDateComponents *monthYearDateComp = [calender components:unitFlags fromDate:self];
	return [monthYearDateComp weekday]-1;
}

- (NSInteger)hourOfDay
{
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];		
	unsigned unitFlags =  NSHourCalendarUnit;
	NSDateComponents *monthYearDateComp = [calender components:unitFlags fromDate:self];
	return [monthYearDateComp hour];
}

- (NSInteger)minuteOfHour
{
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];	
	unsigned unitFlags =  NSMinuteCalendarUnit;
	NSDateComponents *monthYearDateComp = [calender components:unitFlags fromDate:self];
	return [monthYearDateComp minute];
}

- (NSInteger)secondOfMinute
{
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];	
	unsigned unitFlags =  NSSecondCalendarUnit;
	NSDateComponents *monthYearDateComp = [calender components:unitFlags fromDate:self];
	return [monthYearDateComp second];
	
}

- (NSInteger)daysInMonth
{
	NSInteger month = [self monthOfYear];
	switch (month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
		case 4:
		case 6:
		case 9:
		case 11:
			return 30;
		case 2:	
			if( ([self yearOfCommonEra] % 4) == 0)
				return 29;
			else
				return 28;
	}
	
	return -1;
}

- (NSInteger)firstDayOfMonth {
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setYear:[self yearOfCommonEra]];
	[components setMonth:[self monthOfYear]];
	[components setDay:1];
	[components setHour:12];
	[components setMinute:0];
	[components setSecond:0];
	
	NSDate* firstDateOfMonth = [calender dateFromComponents:components];

    components = nil;
	
	components = [calender components:NSWeekdayCalendarUnit fromDate:firstDateOfMonth];
	NSInteger weekday = [components weekday];
	return weekday;	
}

-(NSInteger)quarter
{
	NSInteger month = [self monthOfYear];
	if(month < 4)
		return 1;
	else if(month < 7)
		return 4;
	else if(month < 10)
		return 7;
	else
		return 10;
}
-(NSInteger)halfYear
{
	NSInteger month = [self monthOfYear];
	if(month < 7)
		return 1;
	else
		return 7;
}


+ (id)dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day hour:(NSUInteger)hour minute:(NSUInteger)minute second:(NSUInteger)second timeZone:(NSTimeZone *)aTimeZone
{
//NSDate 
	NSCalendar *currentCalender = [NSCalendar currentCalendar];
//	[currentCalender setFirstWeekday:1];
	[currentCalender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];
	NSDateComponents *dateComps = [[NSDateComponents alloc] init];
	[dateComps setYear:year];
	[dateComps setMonth:month];
	[dateComps setDay:day];
	[dateComps setHour:hour];
	[dateComps setMinute:minute];
	[dateComps setSecond:second];
	NSDate *dateOBj = [currentCalender dateFromComponents:dateComps];

    return dateOBj;
}

- (NSDate *)dateByAddingYears:(NSInteger)year months:(NSInteger)month days:(NSInteger)day hours:(NSInteger)hour minutes:(NSInteger)minute seconds:(NSInteger)second
{
	NSDateComponents *dateComps = [[NSDateComponents alloc] init];
	[dateComps setYear:year];
	[dateComps setMonth:month];
	[dateComps setDay:day];
	[dateComps setHour:hour];
	[dateComps setMinute:minute];
	[dateComps setSecond:second];
	NSCalendar *currentCalender = [NSCalendar currentCalendar];
//	[currentCalender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];	
	NSDate *dateOBj = [currentCalender dateByAddingComponents:dateComps toDate:self options:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit];

    return dateOBj;
}


-(NSInteger)diffrenceInDates:(NSDate*)withDate
{
	CFAbsoluteTime at1,at2;
	NSDate *birthDay = [self dateByAddingYears:([withDate yearOfCommonEra]-[self yearOfCommonEra]) months:0 days:0 hours:0 minutes:0 seconds:0];
	at1 = [birthDay timeIntervalSinceReferenceDate];
	at2 = [withDate timeIntervalSinceReferenceDate];
	CFGregorianUnits units = CFAbsoluteTimeGetDifferenceAsGregorianUnits(at1, at2, NULL, (kCFGregorianUnitsDays|kCFGregorianUnitsHours|kCFGregorianUnitsMinutes));
	if(units.hours == 23 && units.minutes == 59)
		units.days++;
	if( units.days < 0)
	{
		birthDay = [birthDay dateByAddingYears:1 months:0 days:0 hours:0 minutes:0 seconds:0];
		at1 = [birthDay timeIntervalSinceReferenceDate];
		units = CFAbsoluteTimeGetDifferenceAsGregorianUnits(at1, at2, NULL, (kCFGregorianUnitsDays|kCFGregorianUnitsHours|kCFGregorianUnitsMinutes));
		if(units.hours == 23 && units.minutes == 59)
			units.days++;

	}

	return units.days;
}

-(NSUInteger)age
{
	CFAbsoluteTime at1,at2;
	at1 = [NSDate timeIntervalSinceReferenceDate];
	at2 = [self timeIntervalSinceReferenceDate];
	CFGregorianUnits units = CFAbsoluteTimeGetDifferenceAsGregorianUnits(at1, at2, NULL, (kCFGregorianUnitsYears));
	return units.years+1;
}

- (NSDictionary*)astrologyDetails
{
	NSMutableDictionary *details =[[NSMutableDictionary alloc] init];
	NSDictionary *chineseDetails= [[NSDate chineseDictDetails] objectForKey:[NSString stringWithFormat:@"%ld",(long)[self yearOfCommonEra]]];
	NSDate *startDate = [chineseDetails objectForKey:@"StartDate"];
	NSDate *endDate = nil; 
	NSComparisonResult result = [self compare:startDate];
	NSDictionary *stoneSignDictionary = nil;
	if(result == NSOrderedAscending)
	{
		//read last years
		chineseDetails= [[NSDate chineseDictDetails] objectForKey:[NSString stringWithFormat:@"%ld",(long)([self yearOfCommonEra]-1)]];
	}
	else	
	{
		endDate =  [chineseDetails objectForKey:@"EndDate"];
		result = [self compare:endDate];
		if(result == NSOrderedDescending)
		{
			//read next years
			chineseDetails= [[NSDate chineseDictDetails] objectForKey:[NSString stringWithFormat:@"%ld",(long)([self yearOfCommonEra])]];

		}
	}
	
	//add chinese details to details
	[details setObject:[NSString stringWithFormat:@"Year Of %@ %@",[chineseDetails objectForKey:@"Element"],[chineseDetails objectForKey:@"Animal"]] forKey:kChineseYear];
	//read stone and sign details
	stoneSignDictionary = [[NSDate stoneSignDict] objectForKey:[NSString stringWithFormat:@"%ld",(long)[self monthOfYear]]];
	//add birth stone and Zodiac sign to details dictionary it is directly based on month
	[details setObject:[NSString stringWithFormat: @"%@",[stoneSignDictionary objectForKey:@"Stone"]] forKey:kZodiacStoneKey];

	int lastDateInMonth = [[stoneSignDictionary objectForKey:@"EndDate"] intValue];
	//sign may change according to date
	if( [self dayOfMonth] > lastDateInMonth )
	{
		stoneSignDictionary = [[NSDate stoneSignDict] objectForKey:[NSString stringWithFormat:@"%ld",(long)(([self monthOfYear]%12)+1)]];
	}
	[details setObject:[NSString stringWithFormat: @"%@",[stoneSignDictionary objectForKey:@"Sign"]] forKey:kZodiacSignKey];
	
	return details;
}

+(NSDictionary*)chineseDictDetails
{
	static NSDictionary * chineseDict = nil;
	if( !chineseDict)
	{
		chineseDict = [[NSDictionary alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Chinese" ofType:@"plist"]];
	}
	return chineseDict;
}

+(NSDictionary*)stoneSignDict
{
	static NSDictionary * zodiacDict = nil;
	if( !zodiacDict)
	{
		zodiacDict = [[NSDictionary alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ZodiacStone" ofType:@"plist"]];
	}
	return zodiacDict;
}


-(NSInteger)dayOfCurrentYear
{
	NSInteger month = (int)[self monthOfYear];
	NSInteger daysInMonth = 0;
	for(NSInteger i=1; i< month ; i++)
	{
		daysInMonth += [self getNumberOfDaysForMonth:i];
	}
	return daysInMonth+[self dayOfMonth];
	
}


-(NSInteger)getNumberOfDaysForMonth:(NSInteger)month;
{
	month = month % 13;
	switch (month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
		case 4:
		case 6:
		case 9:
		case 11:
			return 30;
		case 2:		
			return 28;
	}
	return -1;
}


-(NSInteger)weekOfYear
{
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];	
	unsigned unitFlags =  NSWeekCalendarUnit;
	NSDateComponents *weekCalenderUnit = [calender components:unitFlags fromDate:self];
	return [weekCalenderUnit week];
	
}

-(NSInteger)weekDay
{
	
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];		
	unsigned unitFlags =  NSWeekdayCalendarUnit;
	NSDateComponents *weekCalenderUnit = [calender components:unitFlags fromDate:self];
	return [weekCalenderUnit weekday];
	
}


-(NSDate*)getAbosoluteDate // Date is sent with time elements as Zero//
{
	
	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];		
	unsigned unitFlags =  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *calenderUnits = [calender components:unitFlags fromDate:self];
	NSDate* date = [self dateByAddingYears:0 months:0 days:0 hours:-[calenderUnits hour] minutes:-[calenderUnits minute] seconds:-[calenderUnits second]];
	return date;
	
}

-(NSDate*)getGMTdate
{

	NSCalendar *calender = [NSCalendar currentCalendar];
	[calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-[[NSTimeZone defaultTimeZone] secondsFromGMT]]];		
	unsigned unitFlags =  NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *calenderUnits = [calender components:unitFlags fromDate:self];
	NSDate* date = [NSDate dateWithYear:[calenderUnits year] month:[calenderUnits month] day:[calenderUnits day] hour:[calenderUnits hour] 
						   minute:[calenderUnits minute] second:[calenderUnits second] timeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
	
	return date;

								   
}

//------------------------------------------------------------------------------------------------------------------------
- (int)minutesFromDate:(NSDate*)date
{
	return [self timeIntervalSinceDate:date]/60;
}

- (NSString *)webApiFormat
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *dateString = [formatter stringFromDate:self];

    return dateString;
}

- (NSString *)frenchFormat
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"dd/MM/yyyy á HH:mm"];
	NSString *dateString = [formatter stringFromDate:self];
	return dateString;
}

- (NSString*)getShortDay
{
	NSInteger day = [self dayOfWeek];
	switch (day) 
	{
		case 0:
			return NSLocalizedString(@"Dim",nil);
			break;
		case 1:
			return NSLocalizedString(@"Lun",nil);
			break;
		case 2:
			return NSLocalizedString(@"Mar",nil);
			break;
		case 3:
			return NSLocalizedString(@"Mer",nil);
			break;
		case 4:
			return NSLocalizedString(@"Jeu",nil);
			break;
		case 5:
			return NSLocalizedString(@"Ven",nil);
			break;
		case 6:
			return NSLocalizedString(@"Sam",nil);
			break;
		default:
			break;
	}
	return nil;
}

- (NSString*)monthFullString
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"MMMM"];
	NSString* monthString = [dateFormatter stringFromDate:self];
	
	return monthString;
	
	// DUMB APPROACH
/*	NSString* month = nil;
	switch ([self monthOfYear]) 
	{
		case 1:
			month = NSLocalizedString(@"JAUNARY",nil);
			break;
		case 2:
			month = NSLocalizedString(@"FEBRUARY",nil);
			break;
		case 3:
			month = NSLocalizedString(@"MARCH",nil);
			break;
		case 4:
			month = NSLocalizedString(@"APRIL",nil);
			break;
		case 5:
			month = NSLocalizedString(@"MAY",nil);
			break;
		case 6:
			month = NSLocalizedString(@"JUNE",nil);
			break;
		case 7:
			month = NSLocalizedString(@"JULY",nil);
			break;
		case 8:
			month = NSLocalizedString(@"AUGUST",nil);
			break;
		case 9:
			month = NSLocalizedString(@"SEPTEMBER",nil);
			break;
		case 10:
			month = NSLocalizedString(@"OCTOBER",nil);
			break;
		case 11:
			month = NSLocalizedString(@"NOVEMBER",nil);
			break;
		case 12:
			month = NSLocalizedString(@"DECEMBER",nil);
			break;
		default:
			break;
	}
	return month;
 */
}

- (NSString*)dayString
{
	NSString *dayText;
//	NSString *dateString	= [NSString dualStringFrom:[self dayOfMonth]];
//	NSString *monthString	= [NSString dualStringFrom:[self monthOfYear]];
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEEE"];
	dayText = [dateFormatter stringFromDate:self];
	return dayText;
									   //	
//	if ([GVUtilities isEnglishLang]) // For English: mm/dd/yyy
//	{
//		dayText = [NSString stringWithFormat:@"%@/%@/%d",monthString,dateString,[self yearOfCommonEra]];
//	}
//	else  // For French: dd/mm/yyyy
//	{
//		dayText = [NSString stringWithFormat:@"%@/%@/%d",dateString,monthString,[self yearOfCommonEra]];
//	}
//	return dayText;
}
- (NSString*)hourString {
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"h a"];
	NSString* hourString = [dateFormatter stringFromDate:self];
	return hourString;	
}

- (NSString*)timeString {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm a"];
    NSString* timeString = [dateFormatter stringFromDate:self];
    return timeString;
}
//
//- (NSString*)timeStringWithSeconds {
//	return [NSString stringWithFormat:@"%@:%@:%@",[NSString dualStringFrom:[self hourOfDay]],[NSString dualStringFrom:[self minuteOfHour]],[NSString dualStringFrom:[self secondOfMinute]]];
//}

- (NSInteger)numberOfWeeksInMonth {
	NSInteger  firstDayOfMonth	= [self firstDayOfMonth] - [[NSCalendar currentCalendar] firstWeekday];
	NSInteger  daysOfMonth		= [self daysInMonth];
	float weeks = (daysOfMonth + firstDayOfMonth)/7.0f;
	return ceil(weeks);
}

//Erica
#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
#pragma mark Relative Dates

+ (NSDate *) dateWithDaysFromNow:(NSUInteger) days {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_DAY * days;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_DAY * days;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateTomorrow {
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday {
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSUInteger) dHours {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithHoursBeforeNow: (NSUInteger) dHours {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;	
}

+ (NSDate *) dateWithMinutesFromNow: (NSUInteger) dMinutes {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSUInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

#pragma mark Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	return (([components1 year] == [components2 year]) &&
			([components1 month] == [components2 month]) && 
			([components1 day] == [components2 day]));
}

- (BOOL) isToday
{
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if ([components1 week] != [components2 week]) return NO;
	
	// Must have a time interval under 1 week. Thanks @aclark
	return (abs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isThisWeekend { 
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSUInteger weekdayOfDate = [components weekday];
    
    return (weekdayOfDate == 7 || weekdayOfDate == 1);
}

- (BOOL) isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameYearAsDate:newDate];
}

- (BOOL) isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameYearAsDate:newDate];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
	return ([components1 year] == [components2 year]);
}

- (BOOL) isThisYear
{
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return ([components1 year] == ([components2 year] + 1));
}

- (BOOL) isLastYear
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	
	return ([components1 year] == ([components2 year] - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
	return ([self earlierDate:aDate] == self);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
	return ([self laterDate:aDate] == self);
}


#pragma mark Adjusting Dates

- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
	return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;		
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
	return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;			
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *)dateAtStartOfWeek {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	[components setWeek:0];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	return [CURRENT_CALENDAR dateFromComponents:components];	
}

- (NSDate *) dateAtStartOfDay
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *) dateAtEndOfDay
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	[components setHour:24];
	[components setMinute:0];
	[components setSecond:0];
	return [CURRENT_CALENDAR dateFromComponents:components];
}


- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
	NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [[self dateAtStartOfDay] timeIntervalSinceDate:[aDate dateAtStartOfDay]];
	return (NSInteger) (ti / D_DAY);
//	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    
//    NSDateComponents *components = [gregorian components:NSDayCalendarUnit
//                                                fromDate:aDate
//                                                  toDate:self
//                                                 options:0];
//    NSInteger days = [components day];
//    [gregorian release];
//    return days;	
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_DAY);
}

#pragma mark Decomposing Dates

- (NSInteger) nearestHour
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
	return [components hour];
}

- (NSInteger) hour
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components hour];
}

- (NSInteger) minute
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components minute];
}

- (NSInteger) seconds
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components second];
}

- (NSInteger) day
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components day];
}

- (NSInteger) month
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components month];
}

- (NSInteger) week
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components week];
}

- (NSInteger) weekday
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components weekday];
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components weekdayOrdinal];
}
- (NSInteger) year
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return [components year];
}

-(void)difrenceinDays:(NSString**)days inHours:(NSString**)hours inMinutes:(NSString**)mins inSeconds:(NSString**)seconds toDate:(NSDate *)toDate;
{
    //  NSTimeInterval interVal =   [[NSDate date] timeIntervalSinceDate:nextDate];
    //    int tmpmins                =   fabs(interVal/60);
    //    int tmpHours           =   fabs(tmpmins/60);
    //    int tmpdays       =   fabs(tmpHours/24);
    //    tem
    
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    // [gregorian setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSUInteger unitFlags =  NSDayCalendarUnit|NSHourCalendarUnit|NSCalendarUnitSecond|NSCalendarUnitMinute;
    
    // NSUInteger calFlag      =NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:self
                                                  toDate:toDate options:0];
    
    if ([components hour]<0 || [components minute]<0 ) {
        components = [gregorian components:unitFlags
                                  fromDate:self
                                    toDate:[NSDate date] options:0];
        
    }
    
    int daysInInt = [components day];
    int hoursInInt = [components hour];
    int minsInInt = [components minute];
    int secondsInInt = [components second];
    *days  =   (daysInInt<10)?[NSString stringWithFormat:@"0%d",daysInInt]:[NSString stringWithFormat:@"%d",daysInInt];
    *hours  =   (hoursInInt<10)?[NSString stringWithFormat:@"0%d",hoursInInt]:[NSString stringWithFormat:@"%d",hoursInInt];
    *mins  =   (minsInInt<10)?[NSString stringWithFormat:@"0%d",minsInInt]:[NSString stringWithFormat:@"%d",minsInInt];
    *seconds  =   (secondsInInt<10)?[NSString stringWithFormat:@"0%d",secondsInInt]:[NSString stringWithFormat:@"%d",secondsInInt];
    
    
    
}


@end
