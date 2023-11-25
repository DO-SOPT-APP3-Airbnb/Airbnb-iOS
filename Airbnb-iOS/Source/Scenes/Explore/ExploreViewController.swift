//
//  ExploreViewController.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 2023/11/21.
//

import UIKit

import SnapKit

final class ExploreViewController: UIViewController {

    let exploreView = ExploreView()

    let themaLables: [String] = ["통나무집", "방", "최고의 전망", "해변 근처"]
    let tnemaIcons: [UIImage] = [ImageLiteral.icExploreTreehouse, ImageLiteral.icExploreRoom, ImageLiteral.icExploreGoodview, ImageLiteral.icExploreSeashore]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteWhite

        exploreView.themaCollectionView.delegate = self
        exploreView.themaCollectionView.dataSource = self

        setUI()
    }

    func setUI() {
        setHierarchy()
        setConstraints()
    }

    func setHierarchy() {
        self.view.addSubview(exploreView)
    }

    func setConstraints() {
        exploreView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                 UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themaLables.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemaCollectionViewCell.identifier, for: indexPath) as! ThemaCollectionViewCell
        cell.themaIcon.image = tnemaIcons[indexPath.row]
        cell.themaLabel.text = themaLables[indexPath.row]
        // deafault 선택: 통나무집
        exploreView.themaCollectionView.selectItem(at: [0,0], animated: false, scrollPosition: .init())

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 31
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 54, height: 72)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        print("클릭: \(index)")
    }
}
