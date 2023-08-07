//
//  ArticleDetailModel.swift
//  DailyToastApp
//
//  Created by jothi on 05/08/23.
//

import Foundation
import UIKit

struct NewsResponse: Decodable {
    let response: NewsData
}

struct NewsData: Decodable {
    let docs: [Article]
}

struct Article: Decodable {
    
    let headline: Headline?
    let web_url: String?
    let snippet: String?
    let multimedia: [Multimedia]?
    let publishedDate: String?
    var articleImage: UIImage? = nil

    private enum CodingKeys: String, CodingKey{
        case headLine = "headline"
        case web_url = "web_url"
        case multimedia = "multimedia"
        case publishedDate = "pub_date"
        case snippet = "snippet"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        headline = try container.decodeIfPresent(Headline.self, forKey: .headLine)
        web_url = try container.decodeIfPresent(String.self, forKey: .web_url)
        snippet = try container.decodeIfPresent(String.self, forKey: .snippet)
        multimedia = try container.decodeIfPresent([Multimedia].self, forKey: .multimedia)
        publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate)
    }
    
}

struct Headline: Decodable {
    
    let main: String?

    private enum CodingKeys: String, CodingKey{
        case main = "main"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        main = try container.decodeIfPresent(String.self, forKey: .main)
    }
}

struct Multimedia: Decodable {
    
    var imageURL: URL? = nil
    
    private enum CodingKeys: String, CodingKey {
        case imageURL = "url"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imageURLString = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        setProperImageURL(imageURLString: imageURLString)
    }
    
    private mutating func setProperImageURL(imageURLString: String) {
        imageURL = URL(string: NetworkCallConstants.imageApiPrefix+imageURLString)
    }
}
