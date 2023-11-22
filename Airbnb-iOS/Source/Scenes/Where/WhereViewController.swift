//
//  WhereViewController.swift
//  Airbnb-iOS
//
//  Created by Hyori Choi on 11/22/23.
//
import UIKit
import SnapKit

final class WhereViewController: UIViewController {
    let navigationBar = CustomNavigationView(level: 1, mode: .darkMode)
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgWhere
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "솝트님,\n 이번엔 어디로 여행가시나요?"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
        
    }()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        setHierarchy()
        setConstraints()
    }
    
    func setHierarchy() {
        self.view.addSubviews(backgroundImageView, navigationBar,titleLabel)
        self.view.addSubview(collectionView)
        
    }
    
    func setConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            
        }
    }
    
    
}


//
//class WhereView: UIView{
//
//}
