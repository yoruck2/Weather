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
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        configureHierarchy()
        configureLayout()
        configureView()
        
        let flexibleSpaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let mapItem = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: nil, action: nil)
        let citySearchItem = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: nil, action: nil)
        
        setToolbarItems([mapItem, flexibleSpaceItem, citySearchItem], animated: true)
    }
    
    func configureHierarchy() {}
    func configureLayout() {}
    func configureView() {}
}
