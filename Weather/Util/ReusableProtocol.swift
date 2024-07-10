//
//  ReusableProtocol.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import UIKit

protocol ReusableProtocol {
    static var id: String { get }
}

extension UICollectionViewCell: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
}
