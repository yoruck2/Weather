//
//  threeHoursForecastCollectionViewCell.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

class ThreeHoursForecastCollectionViewCell: BaseCollectionViewCell {
    
    let hourLabel = UILabel()
    let weatherIconImageView = UIImageView()
    let temperatureLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(hourLabel)
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(temperatureLabel)
    }
    
    override func configureLayout() {
        hourLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
        weatherIconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
    }
}
