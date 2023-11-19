//
//  WhenViewController.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/20.
//

import UIKit

class WhenViewController: UIViewController {
    // MARK: - Variables
    // MARK: Constants
    
    // MARK: Property
    
    // MARK: Component
    let whenView = WhenView()
    
    // MARK: - Function
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    // MARK: Layout Helpers
    
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
    
    }
    
    private func setLayout() {
        view.addSubview(whenView)
        whenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    
    // MARK: Objc Function
    

}
