import UIKit

final class CountButtonStackView: UIStackView {
    private typealias Button = CartConstant.Button

    weak var delegate: CountButtonStackViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        let increaseButton = createButton(image: Button.plus, color: .kioskBlue, action: #selector(didTapIncrease))
        let decreaseButton = createButton(image: Button.minus, color: .kioskRed, action: #selector(didTapDecrease))

        axis = .vertical
        distribution = .fillEqually

        [increaseButton, decreaseButton]
            .forEach { addArrangedSubview($0) }
    }

    private func createButton(image: String, color: UIColor, action: Selector) -> UIButton {
        let config = UIImage.SymbolConfiguration(pointSize: Button.symbolSize, weight: .bold)

        let image = UIImage(systemName: image, withConfiguration: config)

        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tintColor = .kioskWhite
        button.backgroundColor = color
        button.addTarget(self, action: action, for: .touchUpInside)

        return button
    }

    @objc private func didTapIncrease() {
        delegate?.didTapIncrease()
    }

    @objc private func didTapDecrease() {
        delegate?.didTapDecrease()
    }
}
