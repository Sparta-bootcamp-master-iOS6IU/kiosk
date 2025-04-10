//
//  CollectionViewConstant.swift
//  Kiosk
//
//  Created by 곽다은 on 4/9/25.
//
import Foundation

enum CollectionViewConstant {
    enum Dimension {
        static let defaultFractional: CGFloat = 1
        static let defaultEstimated: CGFloat = 100
        static let movieHeightEstimated: CGFloat = 500
        static let movieGroupWidthRatio: CGFloat = 0.92
        static let supplementaryHeight: CGFloat = 30
    }

    enum Spacing {
        static let interGroup: CGFloat = 8
    }

    enum Inset {
        static let sectionTop: CGFloat = 15
        static let sectionBottom: CGFloat = 25
    }
}
