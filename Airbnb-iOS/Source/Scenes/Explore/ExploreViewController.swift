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
        exploreView.themaCardCollectionView.delegate = self
        exploreView.themaCardCollectionView.dataSource = self

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
        if collectionView == exploreView.themaCollectionView {
            return themaLables.count
        } else {
            return 5
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == exploreView.themaCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemaCollectionViewCell.identifier, for: indexPath) as! ThemaCollectionViewCell
            cell.themaIcon.image = tnemaIcons[indexPath.row]
            cell.themaLabel.text = themaLables[indexPath.row]
            // deafault 선택: 통나무집
            exploreView.themaCollectionView.selectItem(at: [0,0], animated: false, scrollPosition: .init())
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemaCardCollectionViewCell.identifier, for: indexPath) as! ThemaCardCollectionViewCell
            // data binding
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == exploreView.themaCollectionView {
            return 31
        } else {
            return 8
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == exploreView.themaCollectionView {
            return CGSize(width: 54, height: 72)
        } else {
            return CGSize(width: 348, height: 464)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == exploreView.themaCardCollectionView {
            let deviceWidth = UIScreen.main.bounds.width
            if section == 0 {
                // 가운데 위치 시키도록 (현재 디바이스의 width-cell.width)/2를 inset으로 지정
                return UIEdgeInsets(top: 0, left: (deviceWidth-348)/2, bottom: 0, right: 14)
            } else {
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if collectionView == exploreView.themaCollectionView {
            print("클릭: \(themaLables[index])")
        }
    }
}
