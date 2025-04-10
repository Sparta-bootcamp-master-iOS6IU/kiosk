//
//  MovieInfoCell.swift
//  Kiosk
//
//  Created by 곽다은 on 4/8/25.
//

import UIKit

import SnapKit
import Then

final class MovieInfoCell: UICollectionViewCell, ReuseIdentifying {
    // MARK: - Properties

    weak var delegate: MovieInfoCellDelegate?

    // MARK: - Components

    private let containerView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = MovieInfoConstant.Spacing.medium
        $0.distribution = .fill
    }

    private let topStackView = UIStackView().then {
        $0.spacing = MovieInfoConstant.Spacing.medium
        $0.alignment = .center
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
        axis: .horizontal,
        contentNumberOfLines: MovieInfoConstant.Config.defaultContentLine
    )

    private let genreView = TitleContentView(
        title: MovieInfoConstant.Title.genre,
        axis: .horizontal,
        contentNumberOfLines: MovieInfoConstant.Config.defaultContentLine
    )

    private let dateView = TitleContentView(
        title: MovieInfoConstant.Title.date,
        axis: .vertical,
        contentNumberOfLines: MovieInfoConstant.Config.dateContentLine
    )

    private let actorView = TitleContentView(
        title: MovieInfoConstant.Title.actor,
        axis: .vertical,
        contentNumberOfLines: MovieInfoConstant.Config.defaultContentLine
    )

    private let synopsisContainerView = UIView()

    private let synopsisLabel = UILabel().then {
        $0.textColor = .kioskWhite
        $0.font = Common.FontStyle.content2
        $0.numberOfLines = MovieInfoConstant.Config.synopsisLine
    }

    private let bottomStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = MovieInfoConstant.Spacing.small
    }

    private let buttonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = MovieInfoConstant.Spacing.extraSmall
        $0.alignment = .leading
    }

    private let seniorBenefitButton = RedCircleOptionButton(
        title: BenefitOption.senior.rawValue
    )

    private let disabledBenefitButton = RedCircleOptionButton(
        title: BenefitOption.disabled.rawValue
    )

    private let addButton = UIButton().then { button in
        button.setTitle(MovieInfoConstant.Title.addButton, for: .normal)
        button.titleLabel?.font = Common.FontStyle.buttonTitle
        button.backgroundColor = .kioskGray2
        button.layer.cornerRadius = Common.Config.buttonCornerRadius

        let touchDownAction = UIAction { _ in button.backgroundColor = .kioskGray3 }
        let touchUpAction = UIAction { _ in button.backgroundColor = .kioskGray2 }

        button.addAction(touchDownAction, for: .touchDown)
        button.addAction(touchUpAction, for: [.touchUpInside, .touchUpOutside])
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setDelegate()
        setupUI()
        setupAddViews()
        setupConstraints()
        addActions()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func setDelegate() {
        seniorBenefitButton.delegate = self
        disabledBenefitButton.delegate = self
    }

    private func setupUI() {
        layer.backgroundColor = UIColor.kioskGray3.cgColor
        layer.cornerRadius = Common.Config.defaultCornerRadius
        clipsToBounds = true
    }

    private func setupAddViews() {
        addSubview(containerView)

        [topStackView, synopsisContainerView, bottomStackView]
            .forEach { containerView.addArrangedSubview($0) }

        [posterImageView, infoStackView]
            .forEach { topStackView.addArrangedSubview($0) }

        [titleView, genreView, dateView, actorView]
            .forEach { infoStackView.addArrangedSubview($0) }

        [synopsisLabel]
            .forEach { synopsisContainerView.addSubview($0) }

        [seniorBenefitButton, disabledBenefitButton]
            .forEach { buttonStackView.addArrangedSubview($0) }

        [buttonStackView, addButton].forEach { bottomStackView.addArrangedSubview($0) }
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(MovieInfoConstant.Spacing.large)
        }

        posterImageView.snp.makeConstraints { make in
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
            make.width.equalToSuperview().multipliedBy(MovieInfoConstant.Ratio.half)
        }

        synopsisLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }

        synopsisContainerView.snp.makeConstraints { make in
            make.height.equalTo(synopsisLabel.font.lineHeight * CGFloat(MovieInfoConstant.Config.synopsisLine))
        }
    }

    private func addActions() {
        let addButtonTapped = UIAction { [weak self] _ in
            guard let self else { return }
            self.delegate?.didTapAddButton(in: self)
        }
        addButton.addAction(addButtonTapped, for: .touchUpInside)
    }

    func updateCell(movie: Movie) {
        posterImageView.image = UIImage(named: movie.image)
        titleView.setContent(movie.title)
        genreView.setContent(movie.genre)
        dateView.setContent(movie.date)
        actorView.setContent(movie.actor)
        synopsisLabel.text = movie.synopsis
    }

    func updateSeniorButton() {
        if !seniorBenefitButton.isSelected {
            disabledBenefitButton.isSelected = false
        }
    }

    func updateDisabledButton() {
        if !disabledBenefitButton.isSelected {
            seniorBenefitButton.isSelected = false
        }
    }

    func setSelectedOption(isSeniorSelected: Bool, isDisabledSelected: Bool) {
        seniorBenefitButton.isSelected = isSeniorSelected
        disabledBenefitButton.isSelected = isDisabledSelected
    }
}
