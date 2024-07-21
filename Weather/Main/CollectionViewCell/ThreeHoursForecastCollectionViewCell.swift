//
//  threeHoursForecastCollectionViewCell.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

final class ThreeHoursForecastCollectionViewCell: BaseCollectionViewCell {
    
    let hourLabel = UILabel()
    let weatherIconImageView = UIImageView()
    let temperatureLabel = UILabel().then {
        $0.font = Font.bold20
    }
    
    override func configureHierarchy() {
        contentView.addSubview(hourLabel)
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(temperatureLabel)
    }
    
    override func configureLayout() {
        hourLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).inset(5)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
        weatherIconImageView.snp.makeConstraints { make in
            make.centerX.equalTo(hourLabel)
            make.top.equalTo(hourLabel.snp.bottom).inset(5)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(hourLabel)
            make.top.equalTo(weatherIconImageView.snp.bottom).inset(5)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
    }
}
