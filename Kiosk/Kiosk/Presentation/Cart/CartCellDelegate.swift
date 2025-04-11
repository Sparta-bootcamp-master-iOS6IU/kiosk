protocol CartCellDelegate: AnyObject {
    func didTapIncrease(_ cell: CartCell)
    func didTapDecrease(_ cell: CartCell)
}
