//
//  URL+.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import Foundation

extension URL {
    static func make(with urlString: String) -> URL {
        guard let url = URL(string: urlString) else {
            return URL(fileURLWithPath: "")
        }
        return url
    }
//    init(staticString: StaticString) {
//        self.init(string: String(staticString))!
//    }
}
