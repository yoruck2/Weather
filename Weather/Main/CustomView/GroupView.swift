//
//  GroupView.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

class GroupView: BaseView {
    
    let headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 15
        clipsToBounds = true
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        alpha = 0.5
        layer.borderColor = UIColor(named: "darkGray")?.cgColor
        layer.borderWidth = 1
        
    }

}
