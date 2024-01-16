//
//  NetworkFetcher.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation
import RxSwift

func dataToJSONString(data: Data) -> String? {
    do {
        // Deserialize the data into a JSON object
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

        // Serialize the JSON object back to a JSON string
        let jsonString = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)

        // Convert the JSON data to a string
        if let jsonString = String(data: jsonString, encoding: .utf8) {
            return jsonString
        } else {
            return nil
        }
    } catch {
        print("Error converting Data to JSON string: \(error)")
        return nil
    }
}

class NetworkFetcher: NetworkCapable {
    func fetch<ResponseType>(request: URLRequest, decodeTo: ResponseType.Type) -> Observable<ResponseType> where ResponseType : Decodable {
        // AF.request(request).validate()
        return Observable<ResponseType>.create { observer in
            URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                guard let data = data else { return }
                
                if let error = error {
                   observer.onError(error)
                   return
                }
                
                guard let httpResponse = urlResponse as? HTTPURLResponse else {
                   observer.onError(APIError.requestFailed)
                   return
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    do {
                        let decodedData = try JSONDecoder().decode(ResponseType.self, from: data)
                        observer.onNext(decodedData)
                        observer.onCompleted()
                    } catch {
                        observer.onError(APIError.invalidResponse)
                    }
                } else {
                    observer.onError(APIError.requestFailed)
                }
                
            }.resume()
            return Disposables.create()
        }
    }
    
}
