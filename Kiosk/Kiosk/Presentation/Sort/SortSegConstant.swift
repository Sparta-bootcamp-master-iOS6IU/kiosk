//
//  SortSegConstant.swift
//  Kiosk
//
//  Created by kingj on 4/8/25.
//

import Foundation

typealias Sort = SortSegConstant

enum SortSegConstant {
    enum Option {
        static let papularity = "인기순"
        static let releaseDate = "개봉일순"
        static let title = "이름순"
    }

    enum Config {
        static let height: Int = 40
    }
}
