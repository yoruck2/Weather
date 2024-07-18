//
//  CityTableViewCell.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import UIKit

final class CityTableViewCell: BaseTableViewCell {
    
    func setUpCellData(data: City) {
        cityNameLabel.text = data.name
        countryCode.text = data.country
    }
    
    //셀이 데이터를 가지고있을 필요는 없다
//    var cityData: City? = nil {
//        didSet {
//            
//        }
//    }
    
    private let hashTagLabel = UILabel().then {
        $0.text = "#"
    }
    private let cityNameLabel = UILabel()
    private let countryCode = UILabel()
    
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
