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

    var themaCardInfo: ThemaCardDTO?
    var themaCardImage: ThemaCardImageDTO?
    var scrollOffset: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteWhite

        exploreView.themaCollectionView.delegate = self
        exploreView.themaCollectionView.dataSource = self
        exploreView.themaCardCollectionView.delegate = self
        exploreView.themaCardCollectionView.dataSource = self

        setUI()
        addTarget()

        self.navigationController?.isNavigationBarHidden = true
        getThemaCard(id: 1)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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

    private func addTarget() {
        exploreView.gotoTravelButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }

    // MARK: Objc Function
    @objc func nextButtonDidTap() {
        self.tabBarController?.tabBar.isHidden = true
        let nextVC = WhereViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                 UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == exploreView.themaCollectionView {
            return themaLables.count
        } else {
            self.exploreView.pageControl.numberOfPages = themaCardInfo?.data.count ?? 0
            return themaCardInfo?.data.count ?? 0
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
            cell.setThemaCard(title: themaCardInfo?.data[indexPath.row].description ?? "",
                              distance: String(themaCardInfo?.data[indexPath.row].distance ?? 0),
                              date: themaCardInfo?.data[indexPath.row].travelDate ?? "",
                              cost: String(themaCardInfo?.data[indexPath.row].price ?? 0),
                              star: String(themaCardInfo?.data[indexPath.row].scope ?? 0))
            cell.themaCard.setImage(urlString: themaCardImage?.data[indexPath.row].imageURL ?? "", defaultImage: ImageLiteral.imgExplore)
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
            getThemaCard(id: index+1)
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        var page = Int(targetContentOffset.pointee.x / 348)
        if scrollOffset {
            targetContentOffset.pointee.x = 0.0
            page = 0
            self.scrollOffset = false
        }
        print("===page: \(page)")
        print("===targetContentOffset: \(targetContentOffset.pointee.x)")
        exploreView.pageControl.currentPage = page
    }
}

extension ExploreViewController {
    func getThemaCard(id: Int) {
        themaCardService().getThemaCard(id: id) { result in
            switch result {
            case .success(let themaCardResponse):
                self.themaCardInfo = themaCardResponse
                if self.themaCardInfo != nil {
                    self.getThemaCardImage(id: id)
                } else {
                    print("RESPONSE ERROR")
                }
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }

    func getThemaCardImage(id: Int) {
        themaCardImageService().getThemaCardImage(id: id) { result in
            switch result {
            case .success(let themaCardImageResponse):
                self.themaCardImage = themaCardImageResponse
                if self.themaCardImage != nil {
                    DispatchQueue.main.async {
                        self.exploreView.themaCardCollectionView.reloadData()
                        if self.themaCardInfo?.data.count ?? 0 > 0 {
                            self.exploreView.themaCardCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                            //self.exploreView.themaCardCollectionView.setContentOffset(.zero, animated: false)
                            //self.scrollOffset = true
                        }
                    }
                } else {
                    print("RESPONSE ERROR")
                }
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }
}
