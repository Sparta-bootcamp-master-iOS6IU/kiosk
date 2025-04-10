extension MainViewController: CartCellDelegate {
    func didTapIncrease(_: CartCell) {
        mainViewModel.changeCount(by: CartConstant.Button.positiveDelta)
    }

    func didTapDecrease(_: CartCell) {
        mainViewModel.changeCount(by: CartConstant.Button.negativeDelta)
    }
}
