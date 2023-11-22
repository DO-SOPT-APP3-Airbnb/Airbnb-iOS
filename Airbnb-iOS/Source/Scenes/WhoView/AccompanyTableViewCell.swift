//
//  accompanyTableViewCell.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/22.
//

import UIKit

class AccompanyTableViewCell: UITableViewCell {
    static let reusableId = "accompanyTableViewCell"
    
    var amount: Int = 0
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .iosSubMedium16
        label.textColor = .black1
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .iosCapMedium125
        label.textColor = .grayGrayText
        return label
    }()
    
    private lazy var titleStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 6
        stackView.addArrangeSubViews(titleLabel, subTitleLabel)
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.btnMinus, for: .normal)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.btnPlus, for: .normal)
        return button
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .iosBodyBold18Num
        label.textColor = .black1
        label.text = "\(amount)"
        return label
    }()
    
    private lazy var buttonStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangeSubViews(minusButton, amountLabel, plusButton)
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        self.backgroundColor = .clear
        contentView.addSubviews(titleStackView,
                                buttonStackView)
    }
    
    private func setConstraints() {
        
        titleStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.width.equalTo(96)
            $0.trailing.equalToSuperview().inset(18)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    private func addTarget() {
        self.minusButton.addTarget(self, action: #selector(amountButtonDidTapped), for: .touchUpInside)
        self.plusButton.addTarget(self, action: #selector(amountButtonDidTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 19, left: 0, bottom: 19, right: 0))
    }
    
    
    func configureCell(title: String, subTitle: String){
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
    }
    
    @objc func amountButtonDidTapped(_ sender: UIButton) {
        if amount >= 0 {
            if sender == plusButton {
                amount += 1
            } else if sender == minusButton {
                if amount > 0 {
                    amount -= 1
                }
            }
        }
        amountLabel.text = "\(amount)"
    }
    
}
