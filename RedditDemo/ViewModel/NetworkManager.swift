//
//  NetworkManager.swift
//  RedditDemo
//
//  Created by dhruva beti on 8/25/21.
//

import Foundation

struct NetworkManager {
    static var shared = NetworkManager()
    
    func getData(completionHandler:@escaping (Result) -> Void){
        guard let url = URL.init(string: "https://www.reddit.com/.json") else { return }
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

struct Result:Codable {
    var data:Data
}

struct Data:Codable {
    var children:[Children]
}

struct Children:Codable {
    var data:DataSec
}

struct DataSec:Codable {
    var title:String
    var thumbnail:String
    var score:Int
    var num_comments:Int
    var preview:Preview?
}

struct Preview:Codable {
    var images:[Image]
}

struct Image:Codable {
    var resolutions:[Resolution]
}

struct Resolution:Codable {
    var url:String
}

