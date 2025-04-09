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

// TODO: 섹션별 알맞은 연관값을 가짐 (movie는 Movie, cart는 Ticket)
enum MovieItem: Hashable {
    case movieInfo(Movie)
    case cart
    case payment
}
