//
//  NetworkManager.swift
//  ChuckNorisJokes
//
//  Created by Ramill Ibragimov on 12.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import Foundation

let endpointLink = "https://api.icndb.com/jokes"
let random = "/random"
let count = "/count"
let specificJoke = "/42"

struct CatalogPage: Decodable {
    let used: Bool?
    let source: String?
    let type: String?
    let deleted: Bool?
    let _id: String?
    let user: String?
    let text: String?
    let createdAt: String?
    let updatedAt: String?
    let __v: Int?
}

struct AllItems: Decodable {
    let all: [Item]
}

struct Item: Decodable {
    let id: UUID = UUID()
    let _id: String?
    let text: String?
    let type: String?
    let user: User?
    let upvotes: Int?
    let userUpvoted: String?
}

struct User: Decodable {
    let _id: String?
    let name: Name?
}

struct Name: Decodable {
    let first: String?
    let last: String?
}





struct Random: Decodable {
    let type: String?
    let value: Value?
}

struct Value: Decodable {
    let id: Int?
    let joke: String?
}

struct JokeCount: Decodable {
    let type: String?
    let value: Int?
}

class NetworkManager {
    
//    static func fetchPage(_ path: String? = nil, completionHandler: @escaping (CatalogPage) -> Void) {
//        if let url = URL.init(string: path ?? endpointLink + facts + "/random") {
//            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//                if let page: CatalogPage = try? JSONDecoder().decode(CatalogPage.self, from: data!) {
//                    completionHandler(page)
//                }
//            })
//            task.resume()
//        }
//    }
//
//    static func fetchAllPages(_ path: String? = nil, completionHandler: @escaping (AllItems) -> Void) {
//        if let url = URL.init(string: path ?? endpointLink + facts) {
//            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//                if let page: AllItems = try? JSONDecoder().decode(AllItems.self, from: data!) {
//                    completionHandler(page)
//                }
//            })
//            task.resume()
//        }
//    }
    static func fetchRandom(_ path: String? = nil, completionHandler: @escaping (Random) -> Void) {
        if let url = URL.init(string: path ?? endpointLink + random) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let page: Random = try? JSONDecoder().decode(Random.self, from: data!) {
                    completionHandler(page)
                }
            })
            task.resume()
        }
    }
    
    static func fetchJokeCount(_ path: String? = nil, completionHandler: @escaping (JokeCount) -> Void) {
        if let url = URL.init(string: path ?? endpointLink + count) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let page: JokeCount = try? JSONDecoder().decode(JokeCount.self, from: data!) {
                    completionHandler(page)
                }
            })
            task.resume()
        }
    }
    
    static func fetchSpecificJoke(_ specificJoke: String? = nil, completionHandler: @escaping (Random) -> Void) {
        if let joke = specificJoke {
            if let url = URL.init(string: endpointLink + joke) {
                let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if let page: Random = try? JSONDecoder().decode(Random.self, from: data!) {
                        completionHandler(page)
                    }
                })
                task.resume()
            }
        }
    }
}
