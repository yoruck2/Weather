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
    
    let backgroundImage = UIImageView().then {
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
    
    let threeHoursForecastCollectionView = UICollectionView()
    let fiveDaysForecastTableView = UITableView()
    let mapView = MKMapView()
    let detailWeatherInfoCollectionView = UICollectionView()
    
    override func configureHierarchy() {
        addSubview(backgroundImage)
        addSubview(mainScrollView)
        
        mainScrollView.addSubview(contentView)
        
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(weatherDescriptionLabel)
        contentView.addSubview(maxMinTemperatureLabel)
        
        contentView.addSubview(threeHoursForecastView)
        contentView.addSubview(fiveDaysForecastView)
        contentView.addSubview(locationMapView)
        contentView.addSubview(detailWeatherInfoCollectionView)
        
        threeHoursForecastView.addSubview(threeHoursForecastCollectionView)
        fiveDaysForecastView.addSubview(fiveDaysForecastTableView)
        locationMapView.addSubview(mapView)
        
    }
    
    override func configureLayout() {
        
    }
    
    override func configureView() {
        
    }
}
