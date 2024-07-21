//
//  DetailWeatherInfoCollectionViewCell.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

final class DetailWeatherInfoCollectionViewCell: BaseCollectionViewCell {

    let backView = GroupView()
    let valueLabel = UILabel().then {
        $0.font = Font.medium30
    }
    let unitLabel = UILabel()
    let addtionalInfoLabel = UILabel()
    

    func setUpCellData(header: (String, String), value: String, unit: String?, addtionalInfo: String?) {
        backView.headerLabel.makeIconLabel(with: header.0, text: header.1)
        valueLabel.text = value
        unitLabel.text = unit
        addtionalInfoLabel.text = addtionalInfo
    }
    
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
            make.leading.equalTo(backView.headerLabel.snp.leading)
        }
        unitLabel.snp.makeConstraints { make in
            make.top.equalTo(valueLabel.snp.bottom)
            make.leading.equalTo(valueLabel.snp.leading)
        }
        addtionalInfoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backView.snp.bottom).inset(10)
            make.leading.equalTo(valueLabel)
        }
    }
}
