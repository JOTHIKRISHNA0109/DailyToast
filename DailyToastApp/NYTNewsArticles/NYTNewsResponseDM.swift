//
//  NetworkManager.swift
//  DailyToastApp
//
//  Created by jothi on 05/08/23.
//

import Foundation

struct NYTNewsResponseDM {
    
    func downloadAndParseData(completion: @escaping (Result<[Article]?, Error>) -> Void) {
        
        NYTNewsResponseNS.shared.downloadJSONDataFromAPI { result in
            switch result {
            case .success(let data):
                let articles = self.parseNewsResponseDetail(detail: data)
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func parseNewsResponseDetail(detail: Any?) -> [Article]? {
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(NewsResponse.self, from: detail as! Data)
            return response.response.docs
        }
        catch{
            return nil
        }
    }
        
}
