//
//  MovieInfoConstant.swift
//  Kiosk
//
//  Created by 곽다은 on 4/8/25.
//

import Foundation
import UIKit

enum MovieInfoConstant {
    enum Title {
        static let title = "제목"
        static let genre = "장르"
        static let date = "상영 시간"
        static let actor = "배우"
        static let addButton = "추가"
    }

    enum Spacing {
        static let extraSmall: CGFloat = 8
        static let small: CGFloat = 12
        static let medium: CGFloat = 20
        static let large: CGFloat = 30
    }

    enum Config {
        static let titleLine = 1
        static let defaultContentLine = 1
        static let dateContentLine = 2
        static let synopsisLine = 4
    }

    enum Ratio {
        static let half = 0.5
    }

    enum ButtonImageName {
        static let normalImage = "unselectedCircleButton"
        static let selectedImage = "selectedCircleButton"
    }

    enum PageControlImageName {
        static let defaultPage = "dot_small"
        static let currentPage = "dot_large"
    }
}
