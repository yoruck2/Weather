//
//  BaseView.swift
//  Weather
//
//  Created by dopamint on 7/11/24.
//

import UIKit

class BaseViewController<RootView: UIView>: UIViewController {
    
    let rootView = RootView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = false
    }
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
}
