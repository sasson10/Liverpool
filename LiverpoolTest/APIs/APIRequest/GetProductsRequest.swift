//
//  GetProductsRequest.swift
//  LiverpoolTest
//
//  Created by Eon Igniting on 19/06/21.
//

import Foundation

struct GetProductsRequest {
    
    static let path = Bundle.main.path(forResource: "Config", ofType: "plist")
    static let config = NSDictionary(contentsOfFile: path!)
    private static let baseURLString = config!["liverpoolUrl"] as! String
    
    static func createRequest(product : String,
                              completionHandler: @escaping (_ result: Data) -> Void){
        
        let urlPath = "\(baseURLString)\(product)"
        guard let url = URL(string: urlPath) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        let session: URLSession = {
            let config = URLSessionConfiguration.default
            return URLSession(configuration: config)
        }()
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
//            guard let httpResponse = response as? HTTPURLResponse,
//                  httpResponse.statusCode == 200 else{
//                return
//            }
            if let error = error{
                print("Se presento un error al obtener la información del api: ", error)
                return
            }
            if let jsonData = data {
                let result = completionHandler(jsonData)
                print(result)
            } else {
                // error, no data returned
                print("GetContractsRequest: no data returned")
            }
        }
        task.resume()
    }
}
