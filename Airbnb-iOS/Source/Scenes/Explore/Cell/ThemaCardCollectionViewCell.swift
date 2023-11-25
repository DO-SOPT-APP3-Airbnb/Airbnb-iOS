//
//  ThemaCardCollectionViewCell.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 11/23/23.
//

import UIKit

import SnapKit

final class ThemaCardCollectionViewCell: UICollectionViewCell {
    static let identifier = "ThemaCardCollectionViewCell"

    private var isButtonClicked: Bool = false

    let themaCard: UIImageView = {
        let imageview = UIImageView()
        imageview.image = ImageLiteral.imgExplore

        return imageview
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "일본 Shinano,\nKamiminochi"
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .whiteWhite
        label.font = .iosTitleSemi32
        label.textAlignment = .center

        return label
    }()

    let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.icHeart, for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

        return button
    }()

    // 버튼 클릭시 이미지 변경
    @objc func buttonClicked() {
        if isButtonClicked == false {
            heartButton.setImage(ImageLiteral.icHeartFill, for: .normal)
            isButtonClicked = true
        } else {
            heartButton.setImage(ImageLiteral.icHeart, for: .normal)
            isButtonClicked = false
        }
    }

    let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "998km 거리"
        label.textColor = .whiteWhite
        label.font = .iosBodyMedium14
        label.textAlignment = .center

        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1월 14일 ~ 19일"
        label.textColor = .whiteWhite
        label.font = .iosBodyMedium14
        label.textAlignment = .center

        return label
    }()

    let costLabel: UILabel = {
        let label = UILabel()
        label.text = "₩609,521 /박"
        label.textColor = .whiteWhite
        label.font = .iosBodyBold14
        label.textAlignment = .center

        return label
    }()

    let starIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.image = ImageLiteral.icSharpStar

        return imageview
    }()

    let starLabel: UILabel = {
        let label = UILabel()
        label.text = "4.96"
        label.textColor = .whiteWhite
        label.font = .iosSubMedium16
        label.textAlignment = .center

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(themaCard, titleLabel, heartButton, distanceLabel, dateLabel, costLabel, starIcon, starLabel)

        setUpLayouts()
    }
    func setUpLayouts() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(348)
            $0.height.equalTo(464)
        }
        themaCard.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(348)
            $0.height.equalTo(464)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.width.equalTo(228)
            $0.leading.equalToSuperview().inset(21)
        }
        heartButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.trailing.equalToSuperview().inset(27)
            $0.size.equalTo(28)
        }
        distanceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(361)
            $0.leading.equalToSuperview().inset(21)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(distanceLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(21)
        }
        costLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(21)
        }
        starIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(409)
            $0.leading.equalTo(costLabel.snp.trailing).offset(163)
        }
        starLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(409)
            $0.leading.equalTo(starIcon.snp.trailing).offset(1)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
