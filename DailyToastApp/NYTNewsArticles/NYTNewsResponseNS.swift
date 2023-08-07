//
//  SearchArticleApiNS.swift
//  DailyToastApp
//
//  Created by jothi on 05/08/23.
//

import Foundation

struct NYTNewsResponseNS {
    
    static let shared = NYTNewsResponseNS()
    
    func downloadJSONDataFromAPI(completion: @escaping (Result<Data, Error>) -> Void) {

        guard let url = URL(string: NetworkCallConstants.shared.getApiURL()) else {
            completion(.failure(NSError(domain: NewsL10N(key: .invalidRequest), code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: NewsL10N(key: .emptyData), code: 0, userInfo: nil)))
                return
            }
            
            completion(.success(data))

        }.resume()
    }
}

