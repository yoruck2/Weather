//
//  ViewController.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import UIKit

class MainViewController: BaseViewController<MainView> {
    
    let network = NetworkService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        network.request(api: .forecast(lat: 20, lon: 20), model: Forecast.self) { response, error in
            dump(response)
        }
    }
    
}

