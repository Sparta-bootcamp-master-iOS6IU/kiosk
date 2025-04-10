import SnapKit
import Then
import UIKit

class MainViewController: UIViewController {
    // MARK: - Properties

    lazy var collectionView = MovieCollectionView()

    var dataSource: UICollectionViewDiffableDataSource<MovieSection, MovieItem>?
    var sections: [MovieSection] = []

    let mainViewModel: MainViewModel

    // MARK: - Components

    private let titleLabel = UILabel().then {
        $0.text = Common.Text.title
        $0.textColor = .kioskWhite
        $0.font = Common.FontStyle.title
    }

    private let segmentedControl = SortSegControl(items: [
        Sort.Option.papularity,
        Sort.Option.releaseDate,
        Sort.Option.title,
    ])

    // MARK: - init

    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        mainViewModel.delegate = self
        configureSubview()
        configureAutoLayout()
        configureDataSource()
    }

    // MARK: - Methods

    private func configureSubview() {
        [titleLabel, segmentedControl, collectionView]
            .forEach { view.addSubview($0) }
    }

    private func configureAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Common.Config.verticalSpacing)
            $0.leading.equalToSuperview().offset(Common.Config.defaultSpacing)
        }

        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Common.Config.defaultSpacing)
            $0.leading.equalToSuperview().offset(Common.Config.defaultSpacing)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Sort.Config.height)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(Common.Config.defaultSpacing)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    private func configureBinding() {
        mainViewModel.delegate = self
    }
}
