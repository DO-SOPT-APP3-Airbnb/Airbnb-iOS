//
//  ThemaCollectionViewCell.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 2023/11/22.
//

import UIKit

import SnapKit

final class ThemaCollectionViewCell: UICollectionViewCell {
    static let identifier = "ThemaCollectionViewCell"

    let themaIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.image = ImageLiteral.icExploreTreehouse
        imageview.tintColor = .grayGrayIcon

        return imageview
    }()

    let themaLabel: UILabel = {
        let label = UILabel()
        label.text = "통나무집"
        label.textColor = .grayGrayText
        label.font = .iosCapMedium125
        label.textAlignment = .center

        return label
    }()

    let underline: UIView = {
        let view = UIView()
        view.backgroundColor = .black1
        view.isHidden = true

        return view
    }()

    override var isSelected: Bool {
        didSet {
            if isSelected {
                themaIcon.tintColor = .black1
                themaLabel.textColor = .black1
                underline.isHidden = false
            } else {
                themaIcon.tintColor = .grayGrayIcon
                themaLabel.textColor = .grayGrayText
                underline.isHidden = true
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(themaIcon)
        contentView.addSubview(themaLabel)
        contentView.addSubview(underline)

        setUpLayouts()
    }
    func setUpLayouts() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(54)
            $0.height.equalTo(72)
        }
        themaIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.size.equalTo(28)
            $0.centerX.equalToSuperview()
        }
        themaLabel.snp.makeConstraints {
            $0.top.equalTo(themaIcon.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        underline.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(themaLabel.snp.bottom).offset(12)
            $0.width.equalTo(40)
            $0.height.equalTo(2)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
