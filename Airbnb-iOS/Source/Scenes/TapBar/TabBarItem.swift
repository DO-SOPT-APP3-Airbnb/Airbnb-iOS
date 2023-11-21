//
//  TabBarItem.swift
//  Airbnb-iOS
//
//  Created by 이조은 on 2023/11/21.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case search
    case wishList
    case trip
    case message
    case profile

    var title: String {
        switch self {
        case .search:
            return "검색"
        case .wishList:
            return "위시리스트"
        case .trip:
            return "여행"
        case .message:
            return "메시지"
        case .profile:
            return "프로필"
        }
    }

    var image: UIImage {
        switch self {
        case .search:
            return ImageLiteral.icExploreBtmSearch
        case .wishList:
            return ImageLiteral.icExploreBtmWishlist
        case .trip:
            return ImageLiteral.icExploreBtmTrip
        case .message:
            return ImageLiteral.icExploreBtmMessage
        case .profile:
            return ImageLiteral.icExploreBtmProfile
        }
    }

    /// fix: selectedImage 나오면 이미지 교체하기
//    var selectedImage: UIImage {
//        switch self {
//        case .search:
//            return ImageLiteral.icExploreBtmSearch
//        case .wishList:
//            return ImageLiteral.icExploreBtmWishlist
//        case .trip:
//            return ImageLiteral.icExploreBtmTrip
//        case .message:
//            return ImageLiteral.icExploreBtmMessage
//        case .profile:
//            return ImageLiteral.icExploreBtmProfile
//        }
//    }
}

extension TabBarItem {
    func toTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: image,
            selectedImage: image
        )
    }
}
