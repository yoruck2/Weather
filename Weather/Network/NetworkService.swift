//
//  OpenWeatherAPI.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import Foundation
import Alamofire

struct NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func request<T: Decodable>(api: APIRouter,
                               model: T.Type,
                               completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(api)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                    print("성공")
                case .failure(let error):
                    completion(.failure(error))
                    print("실패")
                    dump(error)
                }
            }
    }
}
