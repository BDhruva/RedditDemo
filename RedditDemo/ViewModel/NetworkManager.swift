//
//  NetworkManager.swift
//  RedditDemo
//
//  Created by dhruva beti on 8/25/21.
//

import Foundation

struct NetworkManager {
    static var shared = NetworkManager()
    
    func getData(urlString:String, completionHandler:@escaping (Result) -> Void){
        guard let url = URL.init(string: urlString) else { return }
        URLSession.init(configuration: .default).dataTask(with: url) { data, response, error in
            do{
                guard let resData = data else { return }
                let resObj = try JSONDecoder().decode(Result.self, from: resData)
                completionHandler(resObj)
            }catch{
                print(error)
            }
            
        }.resume()
    }
}


