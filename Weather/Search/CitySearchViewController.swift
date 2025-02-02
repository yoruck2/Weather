//
//  CitySearchViewController.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import UIKit

final class CitySearchViewController: BaseViewController<CitySearchView> {
    
    var cityHandler: ((City) -> Void)?
    private let viewModel = CitySearchViewModel()

    init() {
        super.init(nibName: "", bundle: .none)
        setupTableView()
        setupSearchBar()
        viewModel.loadCityList()
        bindViewModel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = true
    }
    
    private func setupTableView() {
        rootView.cityTableView.delegate = self
        rootView.cityTableView.dataSource = self
        rootView.cityTableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.id)
    }
    private func setupSearchBar() {
        rootView.searchBar.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.filteredCities.bind { [weak self] _ in
            self?.rootView.cityTableView.reloadData()
        }
    }
}


extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredCities.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.id, for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.filteredCities.value[indexPath.row]
        cell.setUpCellData(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityData = viewModel.filteredCities.value[indexPath.row]
        
        cityHandler?(cityData)
        UserDefaultsHelper.standard.coordinate = ["lat": cityData.coord.lat,
                                                  "lon": cityData.coord.lon]
        navigationController?.popViewController(animated: true)
    }
}

extension CitySearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            viewModel.filterCityList(with: searchText)
        }
}
