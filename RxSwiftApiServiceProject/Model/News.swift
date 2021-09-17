//
//  News.swift
//  RxSwiftApiServiceProject
//
//  Created by zapbuild on 17/09/21.
//

import Foundation

struct News:Decodable {
    var articles:[Article] = []
}

struct Article: Decodable {
    var title: String
    var description: String
}
