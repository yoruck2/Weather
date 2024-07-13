//
//  File.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

class threeHoursForecastCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThreeHoursForecastCollectionViewCell.id, for: indexPath) as? ThreeHoursForecastCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.hourLabel.text = "8시"
        cell.weatherIconImageView.image = UIImage(systemName: "star")
        cell.temperatureLabel.text = "8도"
        
        return cell
    }
}
