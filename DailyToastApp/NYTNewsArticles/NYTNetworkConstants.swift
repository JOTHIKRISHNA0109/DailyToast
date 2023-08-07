//
//  NetworkCallConstants.swift
//  DailyToastApp
//
//  Created by jothi on 05/08/23.
//

import Foundation

class NetworkCallConstants {
    
    static let shared = NetworkCallConstants()
    private let apiKey = "z0hqVlz17r6dpUNU1ZCulk0rWWggV0So"
    private let apiUrl = "https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key="
    static let imageApiPrefix = "https://static01.nyt.com/"
    
    func getApiURL() -> String {
        let urlString = "\(self.apiUrl)\(self.apiKey)"
        return urlString
    }
    
}
