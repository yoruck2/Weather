//
//  OpenWeatherAPI.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case error
}

struct NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func request<T: Decodable>(api: APIRouter,
                               model: T.Type,
                               completion: @escaping (T?, AFError?) -> Void) {
        AF.request(api)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value, nil)
//                    print("성공")
                case .failure(let error):
                    completion(nil, error)
                    print("실패")
                    dump(error)
                }
            }
    }
}
