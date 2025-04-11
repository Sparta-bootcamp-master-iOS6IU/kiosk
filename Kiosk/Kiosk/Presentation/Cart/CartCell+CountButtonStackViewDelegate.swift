extension CartCell: CountButtonStackViewDelegate {
    func didTapIncrease() {
        delegate?.didTapIncrease(self)
    }

    func didTapDecrease() {
        delegate?.didTapDecrease(self)
    }
}
