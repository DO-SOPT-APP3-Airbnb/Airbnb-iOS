//
//  WhereCollectionViewCell.swift
//  Airbnb-iOS
//
//  Created by Hyori Choi on 11/22/23.
//

import UIKit

import SnapKit

final class WhereCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "WhereCollectionViewCell"
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "global")
        return view
    }()
    private let whereLabel: UILabel = {
        let label = UILabel()
        label.text = "전 세계 어디든 좋아요"
        label.textColor = .white
        label.font = .iosSubMedium16
        return label
    }()
    
    private let grayView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayGrayIcon
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .whiteWhite40
        self.makeCornerRound(radius: 10)
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
        contentView.addSubviews(grayView)
        grayView.addSubview(whereLabel)
        contentView.addSubviews(imageView)
    }

    func setConstraints() {
        grayView.snp.makeConstraints{
            $0.height.equalTo(39)
            $0.width.equalToSuperview()
            $0.top.equalTo(contentView.snp.top)
        }
        whereLabel.snp.makeConstraints{
            $0.leading.equalTo(16)
            $0.top.equalTo(12)
        }
        imageView.snp.makeConstraints{
            $0.width.equalTo(276)
            $0.height.equalTo(138)
            $0.top.equalTo(grayView.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
        }
    }
}

