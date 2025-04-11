# 편한예매: 노년층 맞춤형 영화 예매 키오스크

노년층의 디지털 소외 문제를 해결하고 **스스로** 키오스크를 다룰 수 있도록 도와주는  
**사용자 친화적 영화 예매 키오스크** 프로젝트입니다.

## 프로젝트 목적
1. **디지털 소외 해소**  
   노년층이 기술에 대한 두려움 없이 사용할 수 있도록 키오스크 설계를 단순화하고 가독성을 극대화하였습니다.
2. **자립성 향상**  
   타인의 도움 없이 노년층이 **직접 예매**를 진행할 수 있도록 유도합니다.

## 프로젝트 개요

- **프로젝트 기간**: 2025.04.07 ~ 2025.04.11
- **UI 구성 및 레이아웃**: `Swift` · `UIKit` · `SnapKit` · `Then` · `Compositional Layout` 
- **아키텍처 및 설계 패턴**: `Clean Architecture` · `MVVM` · `Delegate Pattern`


## 학습 목표
  - UIKit 코드 기반 UI 설계 및 구성
  - SnapKit을 활용한 AutoLayout 구현 역량 강화
  - UICollectionView의 Compositional Layout으로 유연한 셀 구성 학습
  - MVVM, Delegate 패턴을 통한 View-ViewModel 간 데이터 및 이벤트 전달 학습
  - Clean Architecture 기반의 계층 분리를 통한 구조적 설계 경험


## 주요 기능

| 기능 구분 | 세부 설명 |
|----------|-----------|
| 영화 정보 정렬 | 인기순, 개봉일순, 이름순으로 영화 선택 기능 |
| 영화 정보 (Section 1) | 영화 정보, 할인 옵션 선택, 장바구니 추가 기능 |
| 장바구니 (Section 2) | 선택한 항목 표시 및 수량 조절 (`+`, `-` 버튼), 총 수량 및 금액 표시 |
| 결제 / 취소 (Section 3) | 전체 삭제 및 결제 버튼 이벤트, 장바구니에 따른 총 수량 표시  |
| 페이징 기능 | 영화 정보 화면 슬라이드 페이징 구현 |
| 예외 처리 | 수량 0 이하 불가, 최대 10개 초과 시 Alert, 결제 항목 없을 시 Alert 등 |


## 폴더 구조
```
Kiosk
├── Application                         // 앱 생명 주기 및 DIContainer 설정
│   ├── AppDelegate                     
│   ├── SceneDelegate                  
│   └── DIContainer                     // 의존성 주입을 위한 DI 커테이너
│       ├── AppDIContainer
│       ├── DataSourceDIContainer
│       ├── RepositoryDIContainer
│       └── UseCaseDIContainer
├── Data                                // 외부로부터 데이터를 가져오고 가공하는 계층
│   ├── Model                          
│   │   └── Movie
│   ├── Repository                      // UseCase에 전달할 실제 Repository 구현
│   │   └── DefaultMovieRepository
│   ├── Source                          // API 호출
│   │   └── Remote
│   │       └── DefaultMovieDataSource
│   ├── UseCase                         // 비즈니스 로직을 처리하는 기본 구현체
│   │   ├── DefaultMovieUseCase
│   │   ├── DefaultTicketCountUseCase
│   │   ├── DefaultTicketPriceUseCase
│   │   └── DefaultTicketRegisterUseCase
│   └── DataConstant                    // Data 계층 관련 상수들
├── Domain                              // 비즈니스 로직 순수 계층
│   ├── Entity                          // 도메인 목록 정의
│   │   └── Ticket
│   ├── Error                           // 도메인 에러 정의
│   │   ├── RegisterTicketError
│   │   └── TicketCountError
│   ├── Repository                      // Repository Protocol 정의
│   │   └── MovieRepository
│   ├── Source                          // 데이터 소스 Protocol 정의
│   │   └── Remote
│   │       └── MovieDataSource
│   ├── UseCase                         // 비즈니스 UseCase 정의
│   │   ├── MovieUseCase
│   │   ├── TicketCountUseCase
│   │   ├── TicketPriceUseCase
│   │   └── TicketRegisterUseCase
│   └── DomainConstant                  // 도메인 계층 관련 상수
├── Presentation                        // UI 및 사용자 상호작용 처리 계층
│   ├── Cart                            // 장바구니 화면 구성 요소
│   │   ├── Subview                    
│   │   │   ├── CountButtonStackView
│   │   │   ├── CountButtonStackViewDelegate
│   │   │   ├── DashedLineView
│   │   │   ├── SectionHeaderView
│   │   │   └── TitlePriceStackView
│   │   ├── CartCell
│   │   ├── CartCell + CountButtonStackViewDelegate
│   │   ├── CartCellDelegate
│   │   └── CartConstant
│   ├── CollectionView                  
│   │   ├── CollectionViewConstant
│   │   ├── MovieCollectionView
│   │   ├── MovieCollectionViewDelegate
│   │   └── MovieSectionItem
│   ├── Common                          // 공통 유틸 및 상수 정의
│   │   ├── BenefitOption
│   │   ├── CommonConstant
│   │   ├── PriceFormatHelper
│   │   └── ReuseIdentifying
│   ├── MovieInfo                       // 영화 정보 상세 뷰
│   │   ├── Subview                    
│   │   │   ├── PageControlFooterView
│   │   │   ├── RedCircleOptionButton
│   │   │   ├── RedCircleOptionButtonDelegate
│   │   │   └── TitleContentView
│   │   ├── MovieInfoCell
│   │   ├── MovieInfoCell + RedCircleOptionButtonDelegate
│   │   ├── MovieInfoCellDelegate
│   │   └── MovieInfoConstant
│   ├── Payment                         // 결제 화면 관련 뷰
│   │   ├── PaymentCell
│   │   ├── PaymentCellDelegate
│   │   └── PaymentConstant
│   ├── Sort                            // 영화 정렬 UI 관련 컴포넌트
│   │   ├── SortingOption
│   │   ├── SortSegConstant
│   │   ├── SortSegControl
│   │   └── SortSegControlDelegate
│   ├── ViewController                  // 전체 화면의 기능 처리 및 Delegate 구성
│   │   ├── MainViewController
│   │   ├── MainViewController+CartCellDelegate
│   │   ├── MainViewController+CartDelegate
│   │   ├── MainViewController+DataSource
│   │   ├── MainViewController+CollectionViewDelegate
│   │   ├── MainViewController+MovieInfoCellDelegate
│   │   ├── MainViewController+PaymentCellDelegate
│   │   └── MainViewController+SortSegControlDelegate
│   └── ViewModel                       // 화면에 바인딩 되는 ViewModel
│       ├── CartDelegate
│       └── MainViewModel
├── Resource                            // 리소스 목록
│   ├── MovieData                       // 더미 영화 데이터
│   ├── Assets.xcassets                 // 이미지 및 색상 애셋
│   ├── Info.plist                      
│   └── LaunchScreen.storyboard       
```


## 팀 소개

<table align=>
  <tr align="center">
    <td><a href="https://github.com/KwakDADA"><img width="100" src="https://github.com/KwakDADA.png" alt="KwakDADA"/><br/>KwakDADA</a></td>
    <td><a href="https://github.com/meowbutlerdev"><img width="100" src="https://github.com/meowbutlerdev.png" alt="meowbutlerdev"/><br/>meowbutlerdev</a></td>
    <td><a href="https://github.com/amazingDove367"><img width="100" src="https://github.com/amazingDove367.png" alt="amazingDove367"/><br/>amazingDove367</a></td>
  </tr>
</table>
