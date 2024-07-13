//
//  DetailWeatherInfoCollectionView.swift
//  Weather
//
//  Created by dopamint on 7/12/24.
//

import UIKit

class DetailWeatherInfoCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailWeatherInfoCollectionViewCell.id, for: indexPath) as? DetailWeatherInfoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}
