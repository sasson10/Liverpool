//
//  LiverpoolAPI.swift
//  LiverpoolTest
//
//  Created by Eon Igniting on 19/06/21.
//

import Foundation

struct LiverpoolAPI {
    
    static func getProducts(
        product : String,
        completionHandler : @escaping(Result<GetProductsResponse,APIError>)->Void)
    {
        GetProductsRequest.createRequest(product: "estufa") { (jsonData) in
            let decoder = JSONDecoder()
            do{
                let json = try decoder.decode(GetProductsResponse.self, from: jsonData)
                print(json)
                DispatchQueue.main.async {
                    completionHandler(.success(json))
                }
            }catch{
                print("ConautoAPI: Error deserializing response")
                DispatchQueue.main.async {
                    completionHandler(.failure(APIError.decodingProblem))
                }
            }
        }
    }
}
