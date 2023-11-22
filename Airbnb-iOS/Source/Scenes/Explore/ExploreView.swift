//
//  ExploreView.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 2023/11/21.
//

import UIKit

import SnapKit

final class ExploreView: UIView {
    // MARK: - Properties
    ///WhereView로 넘어가는 버튼
    private let gotoTravelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .whiteWhite
        button.layer.cornerRadius = 29.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.grayGrayLine.cgColor
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 8.8
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private let gotoTravelView = UIView()

    private let searchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.icExploreSearch

        return imageView
    }()

    private let whereLabel: UILabel = {
        let label = UILabel()
        label.text = "어디로 여행가세요?"
        label.textColor = .black1
        label.font = .iosCapMedium125

        return label
    }()

    private let whenLabel: UILabel = {
        let label = UILabel()
        label.text = "어디든지•언제든 일주일•게스트 추가"
        label.textColor = .grayGrayText
        label.font = .iosCapMedium125

        return label
    }()

    private let filterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.icExploreFiltering

        return imageView
    }()

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
        self.addSubview(gotoTravelButton)
        gotoTravelButton.addSubview(gotoTravelView)
        gotoTravelView.addSubviews(searchImage, whereLabel, whenLabel, filterImage)
    }

    func setConstraints() {
        gotoTravelButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(62)
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(13)
        }
        gotoTravelView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        searchImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.size.equalTo(28)
            $0.leading.equalToSuperview().inset(19)
        }
        whereLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalTo(searchImage.snp.trailing).offset(14)
        }
        whenLabel.snp.makeConstraints {
            $0.top.equalTo(whereLabel.snp.bottom).offset(1)
            $0.leading.equalTo(searchImage.snp.trailing).offset(14)
        }
        filterImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.size.equalTo(36)
            $0.trailing.equalToSuperview().inset(15)
        }
    }
}
