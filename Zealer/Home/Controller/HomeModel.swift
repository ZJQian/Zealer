//
//  HomeModel.swift
//  Zealer
//
//  Created by ZJQian on 2018/5/2.
//  Copyright © 2018年 zjq. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftyJSON

//包含查询返回的所有库模型
struct HomeModels: Mappable {
    var totalCount: Int!
    var incompleteResults: Bool!
    var items: [HomeModel]! //本次查询返回的所有仓库集合
    
    init() {
        totalCount = 0
        incompleteResults = false
        items = []
    }
    
    init?(map: Map) { }
    
    // Mappable
    mutating func mapping(map: Map) {
        totalCount <- map["total_count"]
        incompleteResults <- map["incomplete_results"]
        items <- map["items"]
    }
}

//单个仓库模型
struct HomeModel: Mappable {
    /*
    "rating": {},
    "genres": [],
    "title": "后来的我们",
    "casts": [],
    "collect_count": 85234,
    "original_title": "后来的我们",
    "subtype": "movie",
    "directors": [],
    "year": "2018",
    "images": {},
    "alt": "https://movie.douban.com/subject/26683723/",
    "id": "26683723"
 */
    var rating: JSON!
    var genres: Array<Any>?
    var title: String!
    var casts: Array<Any>?
    var collect_count: Int!
    var original_title: String!
    var subtype: String!
    var directors: Array<Any>?
    var year: String!
    var alt: String!
    var id: String!
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        rating <- map["rating"]
        genres <- map["genres"]
        title <- map["title"]
        casts <- map["casts"]
        collect_count <- map["collect_count"]
        original_title <- map["original_title"]
        subtype <- map["subtype"]
        directors <- map["directors"]
        year <- map["year"]
        alt <- map["alt"]
        id <- map["id"]

    }
}
