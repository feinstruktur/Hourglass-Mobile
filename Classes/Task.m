//
//  Task.m
//  Hourglass
//
//  Created by Sven A. Schmidt on 17.01.08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Task.h"


@implementation Task

@dynamic startDate;
@dynamic endDate;
@dynamic desc;
@dynamic length;
@dynamic project;

// ----------------------------------------------------------------------

+ (NSSet *)keyPathsForValuesAffectingStartTime {
  return [NSSet setWithObjects:@"startDate", nil];
}

+ (NSSet *)keyPathsForValuesAffectingEndTime {
  return [NSSet setWithObjects:@"endDate", nil];
}

// ----------------------------------------------------------------------

- (void)awakeFromInsert {
  [self setValue:[NSDate date] forKey:@"startDate"];
  [self setValue:[NSDate date] forKey:@"endDate"];
}

// ----------------------------------------------------------------------

- (NSDate*)dateWithDate:(NSDate*)date andTime:(NSDate*)time {
  NSCalendar* cal = [NSCalendar currentCalendar];
  unsigned dateFlags = ( NSYearCalendarUnit 
                        | NSMonthCalendarUnit 
                        | NSDayCalendarUnit );
  NSDateComponents* dateComponents = [cal components:dateFlags
                                            fromDate:date];
  unsigned timeFlags = ( NSHourCalendarUnit
                        | NSMinuteCalendarUnit
                        | NSSecondCalendarUnit );
  NSDateComponents* timeComponents = [cal components:timeFlags 
                                            fromDate:time];
  [dateComponents setHour:[timeComponents hour]];
  [dateComponents setMinute:[timeComponents minute]];
  [dateComponents setSecond:[timeComponents second]];
  return [cal dateFromComponents:dateComponents];
}

// ----------------------------------------------------------------------

- (void)setStartTime:(NSDate*)time {
  NSDate* currentDate = [self valueForKey:@"startDate"];
  [self setValue:[self dateWithDate:currentDate andTime:time]
          forKey:@"startDate"];
}

// ----------------------------------------------------------------------

- (NSDate*)startTime {
  return [self valueForKey:@"startDate"];
}

// ----------------------------------------------------------------------

- (void)setEndTime:(NSDate*)time {
  NSDate* currentDate = [self valueForKey:@"endDate"];
  [self setValue:[self dateWithDate:currentDate andTime:time]
          forKey:@"endDate"];
}

// ----------------------------------------------------------------------

- (NSDate*)endTime {
  return [self valueForKey:@"endDate"];
}

// ----------------------------------------------------------------------

@end
