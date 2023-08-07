//
//  L10Strings.swift
//  DailyToastApp
//
//  Created by jothi on 05/08/23.
//

import Foundation

public enum NewsL10NKey {
    
    case invalidRequest
    case emptyData
    case dateUnavailable
    case headlineError
}

public func NewsL10N(key: NewsL10NKey) -> String{
    switch(key) {
    case .invalidRequest:
        return "Invalid URL"
    case .emptyData:
        return "No data received"
    case .dateUnavailable:
        return "Date Unavailable"
    case .headlineError:
        return "Error Loading Headline for you"
    }
}
