//
//  GroupView.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

class GroupView: BaseView {
    
    var headerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 15
        clipsToBounds = true
        backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        layer.borderColor = UIColor(white: 0.2, alpha: 0.7).cgColor
        layer.borderWidth = 1
    }
    
    override func configureHierarchy() {
        addSubview(headerLabel)
    }
    
    override func configureLayout() {
        headerLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(20)
        }
    }
}
