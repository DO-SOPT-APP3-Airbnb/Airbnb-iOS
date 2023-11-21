//
//  WhenViewController.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/20.
//

import UIKit
import FSCalendar

class WhenViewController: UIViewController {
    // MARK: - Variables
    // MARK: Constants
    
    // MARK: Property
    
    // MARK: Component
    let whenView = WhenView()
    
    // MARK: - Function
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDelegate()
    }
    // MARK: Layout Helpers
    
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        
    }
    
    private func setLayout() {
        view.addSubview(whenView)
        whenView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    private func setDelegate() {
        whenView.dateSelectCollectionView.delegate = self
    }
    
    private func addTarget() {
        
    }
    
    // MARK: Objc Function
    
    
}

// MARK: - Extension
extension WhenViewController: UICollectionViewDelegate { }

extension WhenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = whenView.dateSelectList[indexPath.row]
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let nameSize = (name as NSString).size(withAttributes: attributes as [NSAttributedString.Key: Any])
        let paddingSize = (name == "정확한 날짜") ? 30.adjusted : 45.adjusted
        return CGSize(width: CGFloat(Int((nameSize.width))) + paddingSize, height: 35.adjusted)
    }
}
