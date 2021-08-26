//
//  Result.swift
//  RedditDemo
//
//  Created by dhruva beti on 8/26/21.
//

import Foundation

struct Result:Codable {
    var data:ChildData
}

struct ChildData:Codable {
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
    var source:Source
}

struct Source:Codable {
    var url:String
}
