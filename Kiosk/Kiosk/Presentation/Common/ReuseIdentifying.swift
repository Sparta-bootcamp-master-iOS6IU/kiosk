//
//  ReuseIdentifying.swift
//  Kiosk
//
//  Created by 곽다은 on 4/8/25.
//

protocol ReuseIdentifying {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
