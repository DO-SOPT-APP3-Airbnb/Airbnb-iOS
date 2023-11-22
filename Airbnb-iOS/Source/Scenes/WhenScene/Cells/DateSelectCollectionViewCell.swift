//
//  DateSelectCollectionViewCell.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/21.
//

import UIKit

class DateSelectCollectionViewCell: UICollectionViewCell {
    // MARK: - Variables
    // MARK: Constants
    static let reusableId = "DateSelectCollectionViewCell"
    
    // MARK: Property
    var isFirstCell = false {
        didSet{
            configureFirstCell()
            isFirstCell = false
        }
    }
    
    // MARK: Component (button, label 등 코드로 만들때)
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black1
        label.font = .iosBodyMedium14
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.icPlusMinus
        return imageView
    }()
    
    lazy var titleStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.addArrangeSubViews(iconImageView, titleLabel)
        stackView.alignment = .center
        return stackView
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
    
    private func setStyle() {
        self.makeCornerRound(radius: 18)
        self.backgroundColor = .whiteWhite40
        
        if isFirstCell {
          
        } else {
            self.makeBorder(width: 1.5, color: .grayGrayLine)
        }
    }
    
    private func setLayout() {
        if isFirstCell {
            
        } else {
            contentView.addSubviews(titleStackView)
            titleStackView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }
    
    // MARK: Custom Function
    func configureFirstCell() {
        titleStackView.removeFromSuperview()
        self.makeBorder(width: 1.5, color: .black1)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        self.makeBorder(width: 1.5, color: .grayGrayLine)
    }
}
