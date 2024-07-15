//
//  ViewController.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import UIKit

class MainViewController: BaseViewController<MainView> {
    
    let viewModel = MainViewModel()
    let network = NetworkService.shared
    
    var selectedCity: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.fetchWeatherData(lat: 37.56826, lon: 126.977829)
    }
    
    override func configureView() {
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let mapItem = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(scroll))
        let citySearchItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(citySearchItemTapped))
        setToolbarItems([mapItem, flexibleSpaceItem, citySearchItem], animated: true)
        setUpListViews()
    }
    @objc
    func scroll() {
        let boundsHeight = rootView.mainScrollView.bounds.size.height
        let maximumOffset = boundsHeight
        
        if maximumOffset > 0 {
            let bottomOffset = CGPoint(x: 0, y: maximumOffset)
            rootView.mainScrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
    @objc
    func citySearchItemTapped() {
        let nextVC = CitySearchViewController()
        nextVC.cityHandler = { city in
            self.selectedCity = city
            self.viewModel.fetchWeatherData(lat: city.coord.lat, lon: city.coord.lon)
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func bindViewModel() {
        viewModel.outputCurrentWeather.bind { [weak self] current in
            self?.updateCurrentWeatherUI(current)
        }
        
        viewModel.outputForecast.bind { [weak self] forecast in
            self?.rootView.threeHoursForecastCollectionView.reloadData()
            self?.rootView.fiveDaysForecastTableView.reloadData()
            self?.rootView.detailWeatherInfoCollectionView.reloadData()
        }
    }
    func updateCurrentWeatherUI(_ current: Current?) {
            guard let current else { return }
            rootView.cityNameLabel.text = current.name
            rootView.temperatureLabel.text = "\(Int(current.main.temp))°"
            rootView.weatherDescriptionLabel.text = current.weather.first?.description
            rootView.maxMinTemperatureLabel.text = "최고 \(Int(current.main.tempMax))° | 최저 \(Int(current.main.tempMin))°"
        
        }
    
    func setUpListViews() {
        rootView.threeHoursForecastCollectionView.delegate = self
        rootView.threeHoursForecastCollectionView.dataSource = self
        rootView.threeHoursForecastCollectionView.register(ThreeHoursForecastCollectionViewCell.self,
                                                           forCellWithReuseIdentifier: ThreeHoursForecastCollectionViewCell.id)
        rootView.detailWeatherInfoCollectionView.delegate = self
        rootView.detailWeatherInfoCollectionView.dataSource = self
        rootView.detailWeatherInfoCollectionView.register(DetailWeatherInfoCollectionViewCell.self,
                                                           forCellWithReuseIdentifier: DetailWeatherInfoCollectionViewCell.id)
        rootView.fiveDaysForecastTableView.delegate = self
        rootView.fiveDaysForecastTableView.dataSource = self
        rootView.fiveDaysForecastTableView.register(FiveDaysForecastTableViewCell.self,
                                                    forCellReuseIdentifier: FiveDaysForecastTableViewCell.id)
    }
}
// MARK: collectionView -
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case rootView.threeHoursForecastCollectionView:
            return viewModel.outputForecast.value?.list.prefix(10).count ?? 0
        case rootView.detailWeatherInfoCollectionView:
            return 4
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case rootView.threeHoursForecastCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeHoursForecastCollectionViewCell.id, 
                                                                for: indexPath) as? ThreeHoursForecastCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.hourLabel.text = "8시"
            cell.weatherIconImageView.image = UIImage(systemName: "star")
            cell.temperatureLabel.text = "8도"
            return cell
        case rootView.detailWeatherInfoCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWeatherInfoCollectionViewCell.id,
                                                                for: indexPath) as? DetailWeatherInfoCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.addtionalInfoLabel.text = "sd"
            cell.backView.headerLabel.makeIconLabel(with: "star", text: "star")
            cell.addtionalInfoLabel.text = "sd"
            cell.unitLabel.text = "%"
            cell.addtionalInfoLabel.text = "bbb"
            return cell
            
        default:
            return  UICollectionViewCell()
        }
    }
}
// MARK: tableView -
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Weather.FiveDaysForecastTableViewCell.id,
                                                       for: indexPath) as? FiveDaysForecastTableViewCell 
        else {
            return UITableViewCell()
        }
        
        cell.dayLabel.text = "오늘"
        cell.weatherIconImageView.image = UIImage(systemName: "star")
        cell.maxTemperatureLabel.text = "최저 -3"
        cell.minTemperatureLabel.text = "최고 8"
        return cell
    }
}
