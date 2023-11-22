//
//  WhoViewViewController.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/22.
//

import UIKit

class WhoViewViewController: UIViewController {
    
    let whoView = WhoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubview(whoView)
    }
    
    private func setConstraints() {
        whoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
