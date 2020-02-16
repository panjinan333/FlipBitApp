//
//  DateRangeModel.swift
//  CryptoApp
//
//  Created by Daniel Stewart on 2/16/20.
//  Copyright © 2020 Instamobile. All rights reserved.
//

import UIKit

struct DateRange {
    var title: String
    var startDate: Date
    var endDate: Date
    var isCustomRange: Bool
}

class DateRangeModel: GenericBaseModel {
    var title: String
    var currentDateRange: DateRange
    
    required init(jsonDict: [String: Any]) {
        title = ""
        currentDateRange = ranges[1]
    }
    
    var description: String {
        return title
    }
    
    init(title: String, dateRangeText: String) {
        self.title = title
        currentDateRange = ranges[1]
    }
    
    var timePeriodText: String {
        if currentDateRange.isCustomRange {
            let format = "MMM dd"
            return TimeFormatHelper.string(for: currentDateRange.startDate, format: format)
                + " - "
                + TimeFormatHelper.string(for: currentDateRange.endDate, format: format)
        }
        return currentDateRange.title
    }
    
    var titleText: String {
        return title
    }
    
    var ranges: [DateRange] = [
        DateRange(title: "Custom Range", startDate: Date(), endDate: Date(), isCustomRange: true),
        DateRange(title: "Today", startDate: Date(), endDate: Date(), isCustomRange: false),
        DateRange(title: "Yesterday", startDate: Date(), endDate: Date(), isCustomRange: false),
        DateRange(title: "Last Week", startDate: Date(), endDate: Date(), isCustomRange: false),
        DateRange(title: "This Month", startDate: Date(), endDate: Date(), isCustomRange: false),
        DateRange(title: "Last Month", startDate: Date(), endDate: Date(), isCustomRange: false),
        DateRange(title: "Year to Date", startDate: Date(), endDate: Date(), isCustomRange: false),
        DateRange(title: "Lifetime", startDate: Date(), endDate: Date(), isCustomRange: false),
    ]
}
