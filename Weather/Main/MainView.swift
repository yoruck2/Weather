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


class MainView: BaseView {
    
    let backgroundImageView = UIImageView().then {
        $0.alpha = 0.5
        $0.image = UIImage(named: "cloud")
    }
    let mainScrollView = UIScrollView()
    let contentView = BaseView()
    
    let cityNameLabel = CenterLabel()
    let temperatureLabel = CenterLabel()
    let weatherDescriptionLabel = CenterLabel()
    let maxMinTemperatureLabel = CenterLabel()
    
    let threeHoursForecastView = GroupView().then {
        $0.headerLabel.makeIconLabel(with: "calendar", text: "3시간 간격의 일기예보")
    }
    let fiveDaysForecastView = GroupView().then {
        $0.headerLabel.makeIconLabel(with: "calendar", text: "5일 간의 일기예보")
    }
    let locationMapView = GroupView().then {
        $0.headerLabel.makeIconLabel(with: "thermometer.medium", text: "위치")
    }
    
    let threeHoursForecastCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.threeHoursForecastCollectionViewLayout)
    let fiveDaysForecastTableView = UITableView()
    let mapView = MKMapView()
    let detailWeatherInfoCollectionView = UICollectionView()
    
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
        }
        contentView.snp.makeConstraints { make in
            // horizontal로는 안되나..?
            make.width.equalTo(mainScrollView.snp.width)
            make.verticalEdges.equalTo(mainScrollView)
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
            make.top.equalTo(maxMinTemperatureLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview().inset(15)
            
            
            make.height.equalTo(120)
        }
        fiveDaysForecastView.snp.makeConstraints { make in
            make.top.equalTo(weatherDescriptionLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(420)
        }
        locationMapView.snp.makeConstraints { make in
            make.top.equalTo(weatherDescriptionLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(320)
        }
        
        // MARK: innerViews -
        threeHoursForecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(threeHoursForecastView.headerLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(fiveDaysForecastView.headerLabel)
        }
        fiveDaysForecastTableView.snp.makeConstraints { make in
            make.top.equalTo(fiveDaysForecastView.headerLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(threeHoursForecastView.headerLabel)
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(locationMapView.headerLabel.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalToSuperview().inset(5)
        }
        
        // MARK: Bottom -
        detailWeatherInfoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
        
    }
    
    override func configureView() {
        
    }
}
