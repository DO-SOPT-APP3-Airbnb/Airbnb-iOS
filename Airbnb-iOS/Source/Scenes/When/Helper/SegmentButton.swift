//
//  SegmentButton.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/21.
//

import UIKit

class SegmentButton: UIButton {
    // MARK: - Variables
    // MARK: Property
    var isSelect: Bool = false {
        didSet {
            if isSelect {
                self.backgroundColor = .white
                self.makeCornerRound(radius: 18.adjustedHeight)
                self.makeBorder(width: 1, color: .grayGrayLine)
                // 그림자 필요
            } else {
                self.backgroundColor = .clear
                self.makeBorder(width: 0, color: .white)
            }
        }
    }
    
    // MARK: - Function
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Custom Init
    init(buttonTitle: String, isSelected: Bool = false) {
        super.init(frame: .zero)
        self.setTitle(buttonTitle, for: .normal)
        self.titleLabel?.font = .iosBodyMedium14
        self.setTitleColor(.black1, for: .normal)
        isSelect = isSelected
    }
}
