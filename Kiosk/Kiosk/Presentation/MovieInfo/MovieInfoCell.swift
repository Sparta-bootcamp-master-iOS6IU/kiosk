//
//  MovieInfoCell.swift
//  Kiosk
//
//  Created by 곽다은 on 4/8/25.
//

import UIKit

import SnapKit
import Then

final class MovieInfoCell: UICollectionViewCell {
    // MARK: - Components

    private let containerView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = MovieInfoConstant.Spacing.medium
        $0.distribution = .equalSpacing
    }

    private let topStackView = UIStackView().then {
        $0.spacing = MovieInfoConstant.Spacing.small
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }

    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = Common.Config.defaultCornerRadius
        $0.clipsToBounds = true
    }

    private let infoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = MovieInfoConstant.Spacing.small
    }

    private let titleView = TitleContentView(
        title: MovieInfoConstant.Title.title,
        axis: .horizontal
    )

    private let genreView = TitleContentView(
        title: MovieInfoConstant.Title.genre,
        axis: .horizontal
    )

    private let dateView = TitleContentView(
        title: MovieInfoConstant.Title.date,
        axis: .vertical
    )

    private let actorView = TitleContentView(
        title: MovieInfoConstant.Title.actor,
        axis: .vertical
    )

    private let synopsisLabel = UILabel().then {
        $0.textColor = .kioskWhite
        $0.font = Common.FontStyle.content2
        $0.numberOfLines = MovieInfoConstant.Config.synopsisLine
    }

    private let bottomStackView = UIStackView().then {
        $0.distribution = .fillEqually
    }

    private let buttonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = MovieInfoConstant.Spacing.small
        $0.alignment = .leading
        $0.distribution = .equalSpacing
    }

    private let seniorBenefitButton = RedCircleOptionButton(title: BenefitOption.senior.rawValue)

    private let disabledBenefitButton = RedCircleOptionButton(title: BenefitOption.disabled.rawValue)

    private let addButton = UIButton().then {
        $0.setTitle(MovieInfoConstant.Title.addButton, for: .normal)
        $0.backgroundColor = .kioskGray2
        $0.layer.cornerRadius = Common.Config.buttonCornerRadius
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
        setupAddViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setupUI() {
        layer.backgroundColor = UIColor.kioskGray3.cgColor
        layer.cornerRadius = Common.Config.defaultCornerRadius
        clipsToBounds = true
    }

    private func setupAddViews() {
        addSubview(containerView)

        [topStackView, synopsisLabel, bottomStackView]
            .forEach { containerView.addArrangedSubview($0) }

        [posterImageView, infoStackView]
            .forEach { topStackView.addArrangedSubview($0) }

        [titleView, genreView, dateView, actorView]
            .forEach { infoStackView.addArrangedSubview($0) }

        [seniorBenefitButton, disabledBenefitButton]
            .forEach { buttonStackView.addArrangedSubview($0) }

        [buttonStackView, addButton].forEach { bottomStackView.addArrangedSubview($0) }
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(MovieInfoConstant.Spacing.large)
        }

        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(infoStackView)
            make.width.equalToSuperview().multipliedBy(MovieInfoConstant.Ratio.half)
        }
    }

    func configureCell() {
        // TODO: 입력 파라미터로 Movie를 받아서 컴포넌트 셋팅
        posterImageView.backgroundColor = .kioskRed
        titleView.setContent("미키 17")
        genreView.setContent("SF")
        dateView.setContent("2025.02.28\n21:20 ~ 23:20")
        actorView.setContent("로버트 패틴슨\n나오미 애키")
        synopsisLabel.text =
        """
        “당신은 몇 번째 미키입니까?”
        친구 ‘티모’와 함께 차린 마카롱 가게가 쫄딱 망해 거액의 빚을 지고
        못 갚으면 죽이겠다는 사채업자를 피해 지구를 떠나야 하는 ‘미키’.
        기술이 없는 그는, 정치인 ‘마셜’의 얼음행성 개척단에서
        위험한 일을 도맡고, 죽으면 다시 프린트되는 익스펜더블로 지원한다.
        4년의 항해와 얼음행성 니플하임에 도착한 뒤에도 늘 ‘미키’를 지켜준 여자친구 ‘나샤’.
        그와 함께, ‘미키’는 반복되는 죽음과 출력의 사이클에도 익숙해진다.
        
        그러나 ‘미키 17’이 얼음행성의 생명체인 ‘크리퍼’와 만난 후 죽을 위기에서 돌아와 보니
        이미 ‘미키 18’이 프린트되어 있다.
        행성 당 1명만 허용된 익스펜더블이 둘이 된 ‘멀티플’ 상황
        둘 중 하나는 죽어야 하는 현실 속에 걷잡을 수 없는 사건이 기다리고 있었으니…
        
        “자알 죽고, 내일 만나”
        """
    }
}
