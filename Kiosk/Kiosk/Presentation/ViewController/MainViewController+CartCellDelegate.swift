extension MainViewController: CartCellDelegate {
    func didTapIncrease(_ cell: CartCell) {
        updateTicketCount(for: cell, delta: CartConstant.Button.positiveDelta)
    }

    func didTapDecrease(_ cell: CartCell) {
        updateTicketCount(for: cell, delta: CartConstant.Button.negativeDelta)
    }

    private func updateTicketCount(for cell: CartCell, delta: Int) {
        guard
            let indexPath = collectionView.collectionView.indexPath(for: cell),
            case let .cart(ticket) = dataSource?.itemIdentifier(for: indexPath)
        else {
            return
        }

        mainViewModel.changeCount(of: ticket, by: delta)
    }
}
