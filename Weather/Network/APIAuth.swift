//
//  APIAuth.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import Foundation

enum APIAuth {
    case APIKey

    var key: String {
        let keyName: String
        
        switch self {
        case .APIKey:
            keyName = "API_KEY"
        }
        guard let key = Bundle.main.object(forInfoDictionaryKey: keyName) as? String else {
            assertionFailure("헤더를 찾을 수 없음")
            return ""
        }
        return key
    }
}
