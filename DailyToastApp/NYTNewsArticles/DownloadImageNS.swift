//
//  DownloadImageNS.swift
//  DailyToastApp
//
//  Created by jothi on 07/08/23.
//

import Foundation
import UIKit

struct DownloadImageNS {
    
    static let shared = DownloadImageNS()
    
    func downloadImageFromAPI(url: URL?, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = url else {
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Invalid image data")
                completion(nil)
            }
        }.resume()
    }
    
}
