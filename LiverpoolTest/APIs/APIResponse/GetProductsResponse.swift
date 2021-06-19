//
//  GetProductsResponse.swift
//  LiverpoolTest
//
//  Created by Eon Igniting on 19/06/21.
//

import Foundation

enum APIError: Error {
    case timeout
    case responseProblem
    case decodingProblem
    case otherProblem
}

struct GetProductsResponse : Decodable {
    var status : status
    var plpResults : Results
}

struct status: Decodable {
    var status : String
    var statusCode : Int
}

struct Results : Decodable {
    var records : [Producto] 
}
