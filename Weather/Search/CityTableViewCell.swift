//
//  CityTableViewCell.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import UIKit

class CityTableViewCell: BaseTableViewCell {
    
    var cityData: City? = nil {
        didSet {
            cityNameLabel.text = cityData?.name
            countryCode.text = cityData?.country
        }
    }
    
    let hashTagLabel = UILabel().then {
        $0.text = "#"
    }
    let cityNameLabel = UILabel()
    let countryCode = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(hashTagLabel)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(countryCode)
    }
    
    override func configureLayout() {
        hashTagLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(5)
        }
        cityNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(hashTagLabel.snp.trailing).offset(10)
            make.top.equalTo(hashTagLabel)
        }
        countryCode.snp.makeConstraints { make in
            make.leading.equalTo(cityNameLabel)
            make.top.equalTo(cityNameLabel.snp.bottom).offset(5)
        }
    }
}
