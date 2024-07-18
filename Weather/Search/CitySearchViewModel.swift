//
//  CitySearchViewModel.swift
//  Weather
//
//  Created by dopamint on 7/15/24.
//

import UIKit

final class CitySearchViewModel {
    var cityList: [City] = []
    var filteredCities: Observable<[City]> = Observable([])
    
    func loadCityList() {
        guard let data = loadBundleData() else { return }
        cityList = JSONParser.decode(data, model: [City].self) ?? []
        filteredCities.value = cityList
    }
    
    func loadBundleData() -> Data? {
        guard let fileLocation = Bundle.main.url(forResource: "CityList", withExtension: "json") else { return nil }
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            return nil
        }
    }
    
    func filterCityList(with searchText: String) {
        
        let filtered = searchText.isEmpty ? cityList : cityList.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.country.lowercased().contains(searchText.lowercased())}
        
        self.filteredCities.value = filtered
    }
}

