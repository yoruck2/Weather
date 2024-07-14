//
//  BaseCollectionViewCell.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureHierarchy()
        configureLayout()
        configureView()
        layer.cornerRadius = 15
        clipsToBounds = true
//        backgroundColor = .clear
    }
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
