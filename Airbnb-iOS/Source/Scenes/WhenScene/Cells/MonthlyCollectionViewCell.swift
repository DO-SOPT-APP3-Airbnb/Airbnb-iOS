//
//  MonthlyCollectionViewCell.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/21.
//

import UIKit

import SnapKit

class MonthlyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Variables
    // MARK: Constants
    static let reusableId = "MonthlyCollectionViewCell"
    
    
    // MARK: Component
    let monthlydayLabel: UILabel = {
        let label = UILabel()
        label.font = .iosBodyBold14
        label.textColor = .black1
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Helpers
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {   }
    
    private func setLayout() {
        self.addSubviews(monthlydayLabel)
        
        monthlydayLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    
}
