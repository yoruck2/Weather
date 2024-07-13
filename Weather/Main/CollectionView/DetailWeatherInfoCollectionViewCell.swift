//
//  DetailWeatherInfoCollectionViewCell.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

class DetailWeatherInfoCollectionViewCell: BaseCollectionViewCell {
    
    let backView = GroupView()
    let valueLabel = UILabel()
    let unitLabel = UILabel()
    let addtionalInfoLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(valueLabel)
        backView.addSubview(unitLabel)
        backView.addSubview(addtionalInfoLabel)
    }
    
    override func configureLayout() {
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.headerLabel.snp.bottom)
        }
        
    }
    
    override func configureView() {
        
    }
}
