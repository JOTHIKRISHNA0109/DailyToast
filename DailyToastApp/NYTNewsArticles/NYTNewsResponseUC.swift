//
//  NYTNewsResponseUC.swift
//  DailyToastApp
//
//  Created by jothi on 05/08/23.
//

import Foundation


struct NYTNewsResponseUC {
    
    let nytNewsResponseDM = NYTNewsResponseDM()
    
    func getNewsUC(completion: @escaping (Result<[Article], Error>) -> Void) {
        nytNewsResponseDM.downloadAndParseData{ result in
            switch(result) {
            case .success(let newsArticles):
                completion(.success(newsArticles ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
