import UIKit

final class CountButtonStackView: UIStackView {
    private typealias Button = CartConstant.Button

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        let increaseButton = createButton(image: Button.plus, color: .kioskBlue)
        let decreaseButton = createButton(image: Button.minus, color: .kioskRed)

        axis = .vertical
        distribution = .fillEqually

        [increaseButton, decreaseButton]
            .forEach { addArrangedSubview($0) }
    }

    private func createButton(image: String, color: UIColor) -> UIButton {
        let config = UIImage.SymbolConfiguration(pointSize: Button.symbolSize, weight: .bold)

        let image = UIImage(systemName: image, withConfiguration: config)

        let button = UIButton()
        button.setImage(image, for: .normal)
        button.tintColor = .kioskWhite
        button.backgroundColor = color

        return button
    }
}
