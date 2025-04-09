import UIKit

final class DashedLineView: UIView {
    private let dashedLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        dashedLayer.strokeColor = UIColor.kioskGray2.cgColor
        dashedLayer.lineDashPattern = CartConstant.Layer.lineDashPattern

        layer.addSublayer(dashedLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: bounds.midX, y: bounds.minY),
                                CGPoint(x: bounds.midX, y: bounds.maxY)])
        dashedLayer.path = path
        dashedLayer.frame = bounds
    }
}
