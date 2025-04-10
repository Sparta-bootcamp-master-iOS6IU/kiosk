struct Movie: Hashable, Decodable {
    let id: String
    let title: String
    let genre: String
    let date: String
    let actor: String
    let synopsis: String
    let price: Int
    let seniorPrice: Int
    let disabledPrice: Int
    let totalTicketCount: Int
    let image: String

    enum CodingKeys: String, CodingKey {
        case id,
             title,
             genre,
             date,
             actor,
             synopsis,
             price,
             seniorPrice = "senior_price",
             disabledPrice = "disabled_price",
             totalTicketCount,
             image
    }
}

// TODO: 레이아웃 확인용, 데이터 연결 후 삭제
extension Movie {
    static let sampleData: [Movie] = [
        Movie(
            id: "00001",
            title: "보헤미안 랩소디",
            genre: "음악",
            date: "2025.04.14\n14:50 ~ 16:50",
            actor: "라미 말렉, 루시 보인턴",
            synopsis: "전설적인 록 밴드 퀸과 보컬 프레디 머큐리의 일대기를 그린 영화.",
            price: 14000,
            seniorPrice: 7000,
            disabledPrice: 6000,
            totalTicketCount: 200,
            image: "BohemianRhapsody"
        ),
        Movie(
            id: "00002",
            title: "자산어보",
            genre: "드라마",
            date: "2025.04.18\n13:00 ~ 15:00",
            actor: "설경구, 변요한",
            synopsis: "정약전과 청년 어부 창대의 우정을 그린 흑백 사극.",
            price: 13000,
            seniorPrice: 6500,
            disabledPrice: 5500,
            totalTicketCount: 180,
            image: "TheBookOfFish"
        ),
        Movie(
            id: "00003",
            title: "그린 북",
            genre: "드라마",
            date: "2025.04.11\n15:20 ~ 17:20",
            actor: "비고 모텐슨, 마허샬라 알리",
            synopsis: "1960년대 미국 남부를 배경으로 한 피아니스트와 운전사의 우정을 그린 실화.",
            price: 12500,
            seniorPrice: 6200,
            disabledPrice: 5200,
            totalTicketCount: 170,
            image: "GreenBook"
        ),
        Movie(
            id: "00004",
            title: "리틀 포레스트",
            genre: "드라마",
            date: "2025.04.16\n19:30 ~ 21:30",
            actor: "김태리, 류준열",
            synopsis: "도시 생활을 떠나 고향으로 돌아온 주인공이 자연 속에서 치유받는 이야기.",
            price: 11500,
            seniorPrice: 5800,
            disabledPrice: 4800,
            totalTicketCount: 160,
            image: "LittleForest"
        ),
        Movie(
            id: "00005",
            title: "미나리",
            genre: "드라마",
            date: "2025.04.15\n18:00 ~ 20:00",
            actor: "스티븐 연, 한예리, 윤여정",
            synopsis: "1980년대 미국 아칸소로 이주한 한인 가족의 희망과 도전을 그린 이야기.",
            price: 12000,
            seniorPrice: 6000,
            disabledPrice: 5000,
            totalTicketCount: 150,
            image: "Minari"
        ),
    ]
}
