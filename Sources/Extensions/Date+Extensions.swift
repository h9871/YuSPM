//
//  Date+Extensions.swift
//  
//
//  Created by yuhyeonjae on 2021/09/24.
//

/*
 Date 타입을 보다 간단히 사용하기 위한 확장
 */

extension Date {
    /// 년
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    /// 월
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    /// 일
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    /// 년 날짜 데이터
    public var yearDate: Date {
        var dateComponets = DateComponents()
        dateComponets.year = self.year
        return Calendar.current.date(from: dateComponets) ?? self
    }
    
    /// 년, 월 날짜 데이터
    public var monthDate: Date {
        var dateComponets = DateComponents()
        dateComponets.year = self.year
        dateComponets.month = self.month
        return Calendar.current.date(from: dateComponets) ?? self
    }
    
    /// 년, 월, 일 날짜 데이터
    public var dayDate: Date {
        var dateComponets = DateComponents()
        dateComponets.year = self.year
        dateComponets.month = self.month
        dateComponets.day = self.day
        return Calendar.current.date(from: dateComponets) ?? self
    }
    
    /// 월 영어 이름
    public var monthName: String {
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMMM"
        return nameFormatter.string(from: self)
    }
    
    /// 주 인덱스 (0부터 시작을 위해 -1)
    public var weekIndex: Int {
        return Calendar.current.component(.weekOfMonth, from: self) - 1
    }
    
    /// 몇요일인지 (1: 일요일 ~ 7: 토요일) (0 부터 시작을 위해 -1)
    public var dayIndex: Int {
        return Calendar.current.component(.weekday, from: self) - 1
    }
    
    /// 어제
    public var prevDay: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self) ?? self
    }
    
    /// 내일
    public var nextDay: Date {
        return Calendar.current.date(byAdding: .day, value: +1, to: self) ?? self
    }
    
    /// 저번달
    public var prevMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self) ?? self
    }
    
    /// 다음달
    public var nextMonth: Date {
        return Calendar.current.date(byAdding: .month, value: +1, to: self) ?? self
    }
    
    /// 작년
    public var prevYear: Date {
        return Calendar.current.date(byAdding: .year, value: -1, to: self) ?? self
    }
    
    /// 내년
    public var nextYear: Date {
        return Calendar.current.date(byAdding: .year, value: +1, to: self) ?? self
    }
    
    /// 해당 월 첫번째 날짜
    public var firstDate: Date {
        var components = DateComponents()
        components.year = self.year
        components.month = self.month
        components.day = 1
        
        return Calendar.current.date(from: components) ?? self
    }
    
    /// 해당 월 마지막 날짜
    public var lastDate: Date {
        let nextMonth = self.nextMonth
        
        var components = DateComponents()
        components.year = nextMonth.year
        components.month = nextMonth.month
        components.day = 1
        
        // 다음달의 첫 날
        let nextMonthFirsyDay = Calendar.current.date(from: components)
        
        // 다음달의 첫 날의 전 날 = 이번 달의 마지막 날
        return nextMonthFirsyDay?.prevDay ?? self
    }
    
    /// 해당 월의 주의 수
    public var monthWeeksCount: Int {
        return Calendar.current.component(.weekOfMonth, from: self.lastDate)
    }
    
    /// 해당 월의 날짜 수
    public var monthDaysCount: Int {
        return Calendar.current.range(of: .day, in: .month, for: self.firstDate)?.count ?? 0
    }
    
    /// 해당 월의 날짜들
    public var monthDays: Array<Array<Date>> {
        var returnArray: Array<Array<Date>> = []
        
        // 첫날, 마지막날, 해당 월의 주 갯 수
        let firstDate = self.firstDate
        let lastDate = self.lastDate
        let monthWeeksCount = self.monthWeeksCount
        
        // 첫날 요일 인덱스, 마지막날 요일 인덱스
        let firtDateDayIndex = firstDate.dayIndex
        let lastDateDayIndex = lastDate.dayIndex
        
        // 날짜 구하기
        var components = DateComponents()
        components.year = self.year
        components.month = self.month
        var dayValue = 1
        
        // 주의 갯 수만큼 반복
        for weekCount in 0..<monthWeeksCount {
            // 첫 주
            if weekCount == 0 {
                var dayArray: Array<Date> = []
                
                // 전 달 갯수 확인 (첫 날의 요일 인덱스를 확인하여 계산)
                var prevCount = -1
                for _ in 0..<firtDateDayIndex {
                    let makeDate = Calendar.current.date(byAdding: .day, value: prevCount, to: firstDate) ?? Date()
                    dayArray.insert(makeDate, at: 0)
                    prevCount -= 1
                }
                
                // 나머지는 1일부터 대입
                for _ in firtDateDayIndex...6 {
                    components.day = dayValue
                    let makeDate = Calendar.current.date(from: components) ?? Date()
                    dayArray.append(makeDate)
                    dayValue += 1
                }
                
                returnArray.append(dayArray)
            }
            // 마지막 주
            else if weekCount == monthWeeksCount {
                var dayArray: Array<Date> = []
                
                // 마지막 주 마지막 일 요일 인덱스까지 반복
                for _ in 0...lastDateDayIndex {
                    components.day = dayValue
                    let makeDate = Calendar.current.date(from: components) ?? Date()
                    dayArray.append(makeDate)
                    dayValue += 1
                }
                
                // 다음 달 갯수 확인 (마지막 날의 인덱스를 확인하여 계산)
                var nextCount = 1
                for _ in lastDateDayIndex..<6 {
                    let makeDate = Calendar.current.date(byAdding: .day, value: nextCount, to: lastDate) ?? Date()
                    dayArray.append(makeDate)
                    nextCount += 1
                }
                
                returnArray.append(dayArray)
            } else {
                var dayArray: Array<Date> = []
                
                // 각 날짜들 전진전진
                for _ in 0...6 {
                    components.day = dayValue
                    let makeDate = Calendar.current.date(from: components) ?? Date()
                    dayArray.append(makeDate)
                    dayValue += 1
                }
                
                returnArray.append(dayArray)
            }
        }
        return returnArray
    }
    
    /// 해당 주의 날짜들
    public var weekDays: Array<Date> {
        var returnValue: Array<Date> = []
        
        // 해당 일의 요일 인덱스
        let dayIndex = self.dayIndex
        
        // 날짜 재구성
        var components = DateComponents()
        components.year = self.year
        components.month = self.month
        components.day = self.day
        
        // 만들어진 해당 일
        let targetDate = Calendar.current.date(from: components) ?? Date()
        
        // 전 날 캐치
        var prevCount = -1
        for _ in 0..<dayIndex {
            let makeDate = Calendar.current.date(byAdding: .day, value: prevCount, to: targetDate) ?? Date()
            returnValue.insert(makeDate, at: 0)
            prevCount -= 1
        }
        
        // 해당일 대입
        returnValue.append(targetDate)
        
        // 다음 날 캐치
        var nextCount = 1
        for _ in dayIndex..<6 {
            let makeDate = Calendar.current.date(byAdding: .day, value: nextCount, to: targetDate) ?? Date()
            returnValue.append(makeDate)
            nextCount += 1
        }
        
        return returnValue
    }
    
    /// 해당 날짜가 오늘인지
    public var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
}

// MARK:- ㄴ 함수
extension Date {
    /// 원하는 포맷으로 반환
    public func getStringFormatter(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: GlobalVal.sharedInstance.nativeLocale)
        
        return dateFormatter.string(from: self)
    }
    
    /// 해당 데이터 년,월,일 반환
    public func getYearMonthDayValue() -> (year: Int, month: Int, day: Int) {
        return (self.year, self.month, self.day)
    }
    
    /// 해당 데이터 Int형 배열로 반환
    public func getIntArrayValue() -> [Int] {
        return [self.year, self.month, self.day]
    }
}
