//
//  MainView.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit
import MapKit
import CoreLocation

import SnapKit
import Then


final class MainView: BaseView {
    
    let backgroundImageView = UIImageView().then {
        $0.alpha = 0.5
        $0.image = UIImage(named: "cloud")
    }
    let mainScrollView = UIScrollView()
    let contentView = BaseView()
    
    let cityNameLabel = CenterLabel().then {
        $0.font = Font.medium30
    }
    let temperatureLabel = CenterLabel().then {
        $0.font = Font.medium90
    }
    let weatherDescriptionLabel = CenterLabel().then {
        $0.font = Font.medium20
    }
    let maxMinTemperatureLabel = CenterLabel().then {
        $0.font = Font.medium20
    }
    
    let threeHoursForecastView = GroupView().then {
        $0.headerLabel.makeIconLabel(with: "calendar", text: " 3시간 간격의 일기예보")
    }
    let fiveDaysForecastView = GroupView().then {
        $0.headerLabel.makeIconLabel(with: "calendar", text: " 5일 간의 일기예보")
    }
    let locationMapView = GroupView().then {
        $0.headerLabel.makeIconLabel(with: "thermometer.medium", text: " 위치")
    }
    
    let threeHoursForecastCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.threeHoursForecastCollectionViewLayout).then {
        $0.register(ThreeHoursForecastCollectionViewCell.self, forCellWithReuseIdentifier: ThreeHoursForecastCollectionViewCell.id)
        $0.backgroundColor = .clear
    }
    let fiveDaysForecastTableView = UITableView().then {
        $0.register(FiveDaysForecastTableViewCell.self, forCellReuseIdentifier: FiveDaysForecastTableViewCell.id)
        $0.backgroundColor = .clear
    }
    let mapView = MKMapView()
    let detailWeatherInfoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.detailWeatherInfoCollectionViewLayout).then {
        $0.register(DetailWeatherInfoCollectionViewCell.self, forCellWithReuseIdentifier: DetailWeatherInfoCollectionViewCell.id)
        $0.backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        addSubview(backgroundImageView)
        addSubview(mainScrollView)
        
        mainScrollView.addSubview(contentView)
        
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherDescriptionLabel)
        contentView.addSubview(maxMinTemperatureLabel)
        
        contentView.addSubview(threeHoursForecastView)
        contentView.addSubview(fiveDaysForecastView)
        contentView.addSubview(locationMapView)
        
        threeHoursForecastView.addSubview(threeHoursForecastCollectionView)
        fiveDaysForecastView.addSubview(fiveDaysForecastTableView)
        locationMapView.addSubview(mapView)
        contentView.addSubview(detailWeatherInfoCollectionView)
    }
    
    override func configureLayout() {
        // MARK: backgroundViews -
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // MARK: topLabels -
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom)
            make.centerX.equalTo(cityNameLabel)
        }
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.centerX.equalTo(cityNameLabel)
        }
        maxMinTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherDescriptionLabel.snp.bottom)
            make.centerX.equalTo(cityNameLabel)
        }
        // MARK: GroupViews -
        threeHoursForecastView.snp.makeConstraints { make in
            make.top.equalTo(maxMinTemperatureLabel.snp.bottom).offset(70)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(locationMapView.snp.width).multipliedBy(0.55)
        }
        fiveDaysForecastView.snp.makeConstraints { make in
            make.top.equalTo(threeHoursForecastView.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(locationMapView.snp.width).multipliedBy(0.9)
        }
        locationMapView.snp.makeConstraints { make in
            make.top.equalTo(fiveDaysForecastView.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(locationMapView.snp.width)
        }
        // MARK: innerViews -
        threeHoursForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(threeHoursForecastView.headerLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(fiveDaysForecastView.headerLabel)
            make.bottom.equalTo(threeHoursForecastView)
        }
        fiveDaysForecastTableView.snp.makeConstraints { make in
            make.top.equalTo(fiveDaysForecastView.headerLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(threeHoursForecastView.headerLabel)
            make.bottom.equalTo(fiveDaysForecastView)
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(locationMapView.headerLabel.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalToSuperview().inset(15)
            make.bottom.equalTo(locationMapView)
        }
        // MARK: Bottom -
        detailWeatherInfoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(detailWeatherInfoCollectionView.snp.width).multipliedBy(1.2)
            make.bottom.equalToSuperview()
        }
    }
}
