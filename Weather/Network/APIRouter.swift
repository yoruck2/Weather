//
//  APIURL.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case current(lat: Double, lon: Double)
    case forecast(lat: Double, lon: Double)
    
    private var baseURL: URL {
        return URL.make(with: "https://api.openweathermap.org")
    }
    
    private var method: HTTPMethod {
        switch self {
        case .current, .forecast:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .current:
            return "/data/2.5/weather"
        case .forecast:
            return "/data/2.5/forecast"
        }
    }
    
    private var header: HTTPHeaders  {
        return [:]
    }
    
    private var parameters: Parameters?  {
        switch self {
        case .current(let lat, let lon):
            return ["lat": "\(lat)",
                    "lon": "\(lon)",
                    "appid": "\(APIAuth.APIKey.key)"]
        case .forecast(let lat, let lon):
            return ["lat": "\(lat)",
                    "lon": "\(lon)",
                    "appid": "\(APIAuth.APIKey.key)"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        let request = URLRequest(url: url)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}
