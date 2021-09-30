//
//  News.swift
//  RxSwiftApiServiceProject
//
//  Created by zapbuild on 17/09/21.
//

import Foundation

struct News:Decodable {
    var status: String?
    var articles:[Article]?
    var message: String?
    var demo: String?
    
    private enum CodingKeys: String, CodingKey {
        case status, articles, message,demo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        articles = (try? container.decode(Array.self, forKey: .articles)) ?? [Article(title: "News", description: "News Detail")]
        message = (try? container.decode(String.self, forKey: .message))
        demo = (try? container.decode(String.self, forKey: .demo)) ?? "Hello"
    }
}

struct Article: Decodable {
    var title: String
    var description: String
}
