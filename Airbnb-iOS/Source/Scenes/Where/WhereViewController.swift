//
//  WhereViewController.swift
//  Airbnb-iOS
//
//  Created by Hyori Choi on 11/22/23.
//
import UIKit
import SnapKit

final class WhereViewController: UIViewController {
    
    var nickname:String = ""
    var MapDataList: [MapData] = []
    
    let navigationBar = CustomNavigationView(level: 1, mode: .lightMode)
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgWhere
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "sopt님,\n이번엔 어디로 여행가시나요?"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.textAlignment = .left
        return label
        
    }()
    
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 340, height: 190)
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionview.backgroundColor = .clear
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewConfig()
        setUI()
        getUser(id: 1)
        getMapImage()
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
        
        collectionView.snp.makeConstraints{
            $0.height.equalTo(195)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(62)
        }
    }
    
    private func setCollectionViewConfig() {
        self.collectionView.register(WhereCollectionViewCell.self,
                                     forCellWithReuseIdentifier: WhereCollectionViewCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension WhereViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MapDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: WhereCollectionViewCell.identifier,for: indexPath) as? WhereCollectionViewCell else {return UICollectionViewCell()}
        item.ConfigCell(text: MapDataList[indexPath.item].regionName, imageString: MapDataList[indexPath.item].imageURL)
        return item
    }
    
}
extension WhereViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextViewConroller = WhenViewController()
        navigationController?.pushViewController(nextViewConroller, animated: false)
    }
}

extension WhereViewController {
    func getUser(id: Int) {
        NicknameService().getUser(id: id) { [self] result in
            switch result {
            case .success(let UserResponse):
                self.nickname = UserResponse.data.nickname
                DispatchQueue.main.async {
                    self.titleLabel.text = "\(self.nickname)님,\n이번엔 어디로 여행가시나요?"
                }
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }
    
    func getMapImage() {
        MapImageService().getMapImage { result in
            switch result {
            case .success(let data):
                data.data.forEach {
                    self.MapDataList.append($0)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }
    
}
