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
    let gotoTravelButton: UIButton = {
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
    
    ///테마 클릭
    let themaUIView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteWhite
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        view.layer.shadowOpacity = 1.0
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let themaCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(ThemaCollectionViewCell.self, forCellWithReuseIdentifier: ThemaCollectionViewCell.identifier)
        collectionView.backgroundColor = .whiteWhite
        
        return collectionView
    }()
    
    let themaCardCollectionView: UICollectionView = {
        var layout = CustomCollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 348, height: 464)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ThemaCardCollectionViewCell.self, forCellWithReuseIdentifier: ThemaCardCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false
        
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.pageIndicatorTintColor = .whiteWhite40
        pageControl.currentPageIndicatorTintColor = .whiteWhite
        
        return pageControl
    }()
    
    let mapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black1
        button.layer.cornerRadius = 22
        
        return button
    }()
    
    private let mapLabel: UILabel = {
        let label = UILabel ()
        label.text = "지도"
        label.textColor = .white
        label.font = .iosSubMedium15
        
        return label
    }()
    
    private let mapImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.icExploreMap
        
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
        self.addSubviews(gotoTravelButton, themaUIView, themaCardCollectionView, pageControl, mapButton)
        gotoTravelButton.addSubviews(searchImage, whereLabel, whenLabel, filterImage)
        themaUIView.addSubview(themaCollectionView)
        mapButton.addSubviews(mapLabel, mapImage)
    }
    
    func setConstraints() {
        gotoTravelButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(13)
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
        themaUIView.snp.makeConstraints {
            $0.top.equalTo(gotoTravelButton.snp.bottom).offset(5)
            $0.height.equalTo(72)
            $0.leading.trailing.equalToSuperview()
        }
        themaCollectionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(318)
            $0.centerX.equalToSuperview()
        }
        themaCardCollectionView.snp.makeConstraints {
            $0.top.equalTo(themaCollectionView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(464)
        }
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(themaCardCollectionView.snp.bottom).inset(14)
        }
        mapButton.snp.makeConstraints {
            $0.top.equalTo(themaCardCollectionView.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(44)
        }
        mapLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(18)
        }
        mapImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11)
            $0.trailing.equalToSuperview().inset(23)
            $0.size.equalTo(24)
        }
    }
}
