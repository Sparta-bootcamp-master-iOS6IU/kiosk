//
//  MovieSectionItem.swift
//  Kiosk
//
//  Created by 곽다은 on 4/9/25.
//

enum MovieSection: Hashable {
    case movieInfo
    case cart
    case payment
}

enum MovieItem: Hashable {
    case movieInfo(Movie)
    case cart(Ticket)
    case payment(totalPrice: Int, isEnable: Bool)
}
