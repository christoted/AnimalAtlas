//
//  ApiClient.swift
//  AnimalAtlas
//
//  Created by Christopher Minarto  on 16/01/24.
//

import Foundation
import RxSwift

/// Add Empty Body here
struct EmptyBody: Codable {}

/// Add Empty Response
struct EmptyResponse: Codable {}

protocol APIRequest {
    associatedtype RequestData: Codable
    associatedtype Response: Codable
    
    var pathname: String {get}
    var method: String {get}
    var contentType: String {get}
    var body: RequestData? {get}
}

extension APIRequest {
    typealias Response = EmptyResponse
    var method: String {"get"}
    var body: EmptyBody? {nil}
    var contentType: String {"application/json"}
}

protocol NetworkCapable {
    func fetch<ResponseType: Decodable>(request: URLRequest, decodeTo: ResponseType.Type) -> Observable<ResponseType>
}

class APIClient<Request: APIRequest> {
    private var fetcher: NetworkCapable
    
    init(fecther: NetworkCapable = NetworkFetcher()) {
        self.fetcher = fecther
    }
    
    func fetch(request: Request, baseURL: String) -> Observable<Request.Response> {
        let url = "\(baseURL)\(request.pathname)"
        let customizeURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlRequest = URLRequest(url: URL(string: customizeURL)!)
        var token = ""
        
        urlRequest.httpMethod = request.method
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if baseURL == Constant.animalDataBaseURL {
            token = "pfFQJxLiPMYqvY5rZXbYdw==VBjYVanTRFZdEhx9"
            urlRequest.setValue("\(token)", forHTTPHeaderField: "X-Api-Key")
        } else {
            token = "F0RsC7L6viQO7bzFmZTKs7hwGWhXlwm5TjAozyXUwkTmB8INisxbwjVg"
            urlRequest.setValue("\(token)", forHTTPHeaderField: "Authorization")
        }
       
       
        if request.body != nil {
            do {
                let data = try JSONEncoder().encode(request.body)
                urlRequest.httpBody = data
                print(data)
            } catch {
                print(error)
            }
        }
        
        return self.fetcher.fetch(request: urlRequest, decodeTo: Request.Response)
    }
}
