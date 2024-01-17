//
//  NetworkFetcher.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation
import RxSwift

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
