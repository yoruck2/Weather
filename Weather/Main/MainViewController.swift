//
//  ViewController.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import UIKit

final class MainViewController: BaseViewController<MainView> {
    
    let viewModel = MainViewModel()
    private var selectedCity: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        loadCityData()
    }
    
    // MARK: binding -
    private func bindViewModel() {
        viewModel.outputCurrentWeather.bind { [weak self] current in
            guard let current else { return }
            self?.rootView.cityNameLabel.text = current.name
            self?.rootView.temperatureLabel.text = "\(MeasurementFormatter.kelvinToCelsius(current.main.temp, .second))"
            self?.rootView.weatherDescriptionLabel.text = current.weather.first?.description
            self?.rootView.maxMinTemperatureLabel.text = "최고 \(MeasurementFormatter.kelvinToCelsius(current.main.tempMax, .second)) | 최저 \(MeasurementFormatter.kelvinToCelsius(current.main.tempMin, .second))"
        }
        
        viewModel.inputReloadTrigger.bind { [weak self] _ in
            self?.rootView.threeHoursForecastCollectionView.reloadData()
            self?.rootView.fiveDaysForecastTableView.reloadData()
            self?.rootView.detailWeatherInfoCollectionView.reloadData()
        }
        
//        viewModel.outputForecast.bind { [weak self] forecast in
//            guard let forecast else { return }
//
//        }
        
        viewModel.outputThreeHoursForecast.bind { [weak self] _ in
            self?.rootView.threeHoursForecastCollectionView.reloadData()
        }
        viewModel.outputFiveDaysForecast.bind { [weak self] _ in
            self?.rootView.fiveDaysForecastTableView.reloadData()
        }
        
    }
    
    private func loadCityData() {
        guard let coordinate = UserDefaultsHelper.standard.coordinate else {
            viewModel.fetchWeatherData(lat: 37.56826, lon: 126.977829)
            return
        }
        guard let lat = coordinate["lat"] as? Double,
              let lon = coordinate["lon"] as? Double
        else {
            return
        }
        viewModel.fetchWeatherData(lat: lat, lon: lon)
    }
    
    // MARK: setUp toolBar -
    override func configureView() {
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil)
        let mapItem = UIBarButtonItem(image: UIImage(systemName: "map"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(scrollToMap))
        let citySearchItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(citySearchItemTapped))
        setToolbarItems([mapItem, flexibleSpaceItem, citySearchItem], animated: true)
        setUpListViews()
    }
    @objc
    private func scrollToMap() {
        let boundsHeight = rootView.mainScrollView.bounds.size.height
        let maximumOffset = boundsHeight
        
        if maximumOffset > 0 {
            let bottomOffset = CGPoint(x: 0, y: maximumOffset)
            rootView.mainScrollView.setContentOffset(bottomOffset, animated: true)
        }
    }
    @objc
    private func citySearchItemTapped() {
        let nextVC = CitySearchViewController()
        nextVC.cityHandler = { city in
            self.selectedCity = city
            self.viewModel.fetchWeatherData(lat: city.coord.lat, lon: city.coord.lon)
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: setUp listViews -
    private func setUpListViews() {
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
            return viewModel.outputThreeHoursForecast.value.count
        case rootView.detailWeatherInfoCollectionView:
            return 4
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            // MARK: threeHourCollectoinView -
        case rootView.threeHoursForecastCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeHoursForecastCollectionViewCell.id,
                                                                for: indexPath) as? ThreeHoursForecastCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            let forecastData = viewModel.outputThreeHoursForecast.value[indexPath.item]
            
            print(forecastData.dtTxt)
            let date = DateFormatter.formatToHour(with: forecastData.dtTxt)
            cell.hourLabel.text = date
//            if let date = DateFormatter.formatToDate.date(from: forecastData.dtTxt) {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "H시"
//                cell.hourLabel.text = dateFormatter.string(from: date)
//            }
            
            if let iconCode = forecastData.weather.first?.icon {
                let url = URL(string: "https://openweathermap.org/img/wn/\(iconCode).png")
                cell.weatherIconImageView.kf.setImage(with: url)
            }
            
            cell.temperatureLabel.text = MeasurementFormatter.kelvinToCelsius(forecastData.main.temp, .first)
            return cell
            
            // MARK: deatilcollectoinView -
        case rootView.detailWeatherInfoCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWeatherInfoCollectionViewCell.id,
                                                                for: indexPath) as? DetailWeatherInfoCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            guard let weather = viewModel.outputCurrentWeather.value else { return cell }
            switch indexPath.item {
            case 0:
                cell.setUpCellData(header: ("wind", " 바람 속도"),
                                   value: "\(weather.wind.speed)m/s",
                                   unit: nil,
                                   addtionalInfo: "\(weather.wind.gust ?? .nan)m/s")
            case 1:
                cell.setUpCellData(header: ("cloud.fill", " 구름"),
                                   value: "\(weather.clouds.all)%",
                                   unit: nil,
                                   addtionalInfo: nil)
            case 2:
                cell.setUpCellData(header: ("thermometer.high", " 기압"),
                                   value: "\(weather.main.pressure.formatted())",
                                   unit: "hps",
                                   addtionalInfo: nil)
            case 3:
                cell.setUpCellData(header: ("humidity", " 습도"),
                                   value: "\(weather.main.humidity)%",
                                   unit: nil,
                                   addtionalInfo: nil)
            default:
                cell.setUpCellData(header: ("-", "-"),
                                   value: "",
                                   unit: nil,
                                   addtionalInfo: nil)
            }
            return cell
        default:
            return  UICollectionViewCell()
        }
    }
}
// MARK: tableView -
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputFiveDaysForecast.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Weather.FiveDaysForecastTableViewCell.id,
                                                       for: indexPath) as? FiveDaysForecastTableViewCell
        else {
            return UITableViewCell()
        }
        let forecast = viewModel.outputFiveDaysForecast.value[indexPath.row]
        
        // Day Label
        if forecast.isToday {
            cell.dayLabel.text = "오늘"
        } else {
            cell.dayLabel.text = DateFormatter.formatToWeekday.string(from: forecast.date)
        }
        
        let iconUrl = URL(string: "https://openweathermap.org/img/wn/\(forecast.weatherIcon).png")
        cell.weatherIconImageView.kf.setImage(with: iconUrl)
        
        cell.maxTemperatureLabel.text = "최고 " + MeasurementFormatter.kelvinToCelsius(forecast.maxTemp, .first)
        cell.minTemperatureLabel.text = "최저 " + MeasurementFormatter.kelvinToCelsius(forecast.minTemp, .first)
        
        return cell
    }
}
