//
//  ExploreViewController.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 2023/11/21.
//

import UIKit

import SnapKit

final class ExploreViewController: UIViewController {

    let exploreView = ExploreView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteWhite

        setUI()
    }

    func setUI() {
        setHierarchy()
        setConstraints()
    }

    func setHierarchy() {
        self.view.addSubview(exploreView)
    }

    func setConstraints() {
        exploreView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
