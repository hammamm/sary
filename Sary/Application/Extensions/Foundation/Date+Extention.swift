//
//  Date+Extention.swift
//  Sary
//
//  Created by hammam abdulaziz on 08/02/1443 AH.
//

import Foundation

extension Date {
    //    var time:Time {
    //        Time (self)
    //    }
    
    /// Calculating the time from a given date
    ///
    /// - Parameter date: date
    /// - Returns: time diff
    ///
    /// - Author: Hammam Abdulaziz
    func timeSince(_ date: Date) -> TimeInterval {
        let time = Date()
        return time.timeIntervalSince(date)
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    func getDate(formate: DateFormat, local: String = "lang".localized) -> String {
        let dateFormatter2 = DateFormatter()
        dateFormatter2.locale = Locale(identifier: local)
        dateFormatter2.dateFormat = formate.rawValue
        let new = dateFormatter2.string(from: self)
        return new
    }
    
    func getDays(startingAfter: Int = 0,formate: DateFormat = .backendFormate, local: String = "lang".localized, numberOfDays: Int = 7) -> [String]? {
        var allDates: [String] = []
        var index = startingAfter
        // if the time is after 4pm so we need to start from tomowrow
        if let lastTimeOfToday = Calendar.current.date(bySettingHour: 16, minute: 0, second: 0, of: Date()){
            if Date() > lastTimeOfToday{
                index += 1
            }
        }
        for x in index...(numberOfDays + index) {
            if let newDate = Calendar.current.date(byAdding: .day, value: x, to: self)?.getDate(formate: formate, local: local){
                allDates.append(newDate)
            }
        }
        return allDates
    }
    
    func getMerchantRef() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "mmss"
        timeFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
        
        return dateFormatter.string(from: self) + timeFormatter.string(from: self)
    }
    
}

/// Cases of the date formate
public enum DateFormat: String {
    /// MMMMddYYYYWithTime: OCT 10, 2019 at 12:32 am
    case MMMMddyyyyWithTime = "MMMM dd, yyyy 'at' h:mm a"
    /// ddmmyyyyWithTime: 23/10/2019 at 12:32 am
    case ddMMyyyyWithTime = "dd/MM/yyyy 'at' h:mm a"
    //12:32 am
    case timeFormate = "h:mm a"
    //2019-09-15 11:26:22
    case requestDateFormat = "dd-MM-yyyy hh:mm:ss.SSSSS"
    case YYYYMMDD = "yyyyMMdd"
    
    //here is yoma in dateprofile
    case ddMMMyyyy = "ddMMMyyyy"
    
    case DateWithTimeZone = "yyyy-MM-dd'T'HH:mm:Ss.SSSZ" // Time zone date
    case MMMyyy = "MMM yyy" /// For date used in view bills
    case MMM = "MMM"
    case yyyy = "yyyy"
    case yyyy_MM_dd = "yyyy-MM-dd"
    case yyyy_MM_ddMM_HH = "yyyy-MM-dd MM:HH"
    case backendFormate = "yyyy-MM-dd HH:mm:ss"
    case dateFormate = "dd/MM/yyyy"
    case paymentFormate = "MMmmss"
    case stcPaymentFormate = "HHmmss"
    
    case dayName = "EEEE"
    case dayNumber = "dd"
    case monthName = "MMMM"
    /*
     You can add as many format as you want
     and if you not familiar with other date format you can use this website
     to pick your best format http://nsdateformatter.com
     */
}

