//
//  CenterLabel.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

class CenterLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
