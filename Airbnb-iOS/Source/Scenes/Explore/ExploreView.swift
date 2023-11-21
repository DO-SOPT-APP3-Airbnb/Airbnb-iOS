//
//  ExploreView.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 2023/11/21.
//

import UIKit

import SnapKit

final class ExploreView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        setHierarchy()
        setConstraints()
    }

    func setHierarchy() {
        // self.addSubview(scrollView)
    }

    func setConstraints() {
//        view.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
}
