//
//  FiveDaysForecastTableViewCell.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

class FiveDaysForecastTableViewCell: BaseTableViewCell {
    
    let dayLabel = UILabel().then {
        $0.font = Font.medium25
    }
    let weatherIconImageView = UIImageView()
    let minTemperatureLabel = UILabel().then {
        $0.font = Font.medium25
        $0.textColor = .lightGray
    }
    let maxTemperatureLabel = UILabel().then {
        $0.font = Font.medium25
    }
    
    override func configureHierarchy() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(minTemperatureLabel)
        contentView.addSubview(maxTemperatureLabel)
        
    }
    
    override func configureLayout() {
        dayLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5)
            make.width.equalTo(60)
            make.centerY.equalToSuperview()
        }
        weatherIconImageView.snp.makeConstraints { make in
            make.leading.equalTo(dayLabel.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
        }
        minTemperatureLabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherIconImageView.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
        maxTemperatureLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
    }
    override func configureView() {
        selectionStyle = .none
    }
}
