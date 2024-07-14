//
//  CitySearchView.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import UIKit

import SnapKit
import Then

class CitySearchView: BaseView {
    
    let cityLabel = UILabel()
    let searchBar = UISearchBar()
    let cityTableView = UITableView().then {
        $0.rowHeight = 60
    }
    
    override func configureHierarchy() {
        addSubview(cityLabel)
        addSubview(searchBar)
        addSubview(cityTableView)
    }
    override func configureLayout() {
        cityLabel.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).inset(10)
            make.top.equalTo(safeAreaLayoutGuide).inset(15)
        }
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).inset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(5)
        }
        cityTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        
    }
}
