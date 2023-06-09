//
//  DataCategories.swift
//  Proyecto Getonbrd
//
//  Created by Camila Canales on 06-04-23.
//

import Foundation


struct CategoriesResponse: Decodable {
    let data: [Category]
}

struct Category: Decodable {
    let id: String
    let attributes: AttributesCategory
}

struct AttributesCategory: Decodable {
    let name: String?
}
