import UIKit
import Alamofire


class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pushViewController(MainTabBarController(), animated: false)
    }
}

class MainTabBarController: UITabBarController {
    let moviewVC = MoviewsVC()
    let secondVC = SecondVC()
    let thirdVC = ThirdVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thirdNavController = UINavigationController(rootViewController: thirdVC)

        viewControllers = [moviewVC, secondVC, thirdNavController]

        moviewVC.tabBarItem = UITabBarItem(title: "Moview", image: nil, tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "SecondVC", image: nil, tag: 1)
        thirdNavController.tabBarItem = UITabBarItem(title: "ThirdVC", image: nil, tag: 2)

        tabBar.barTintColor = .lightGray
        tabBar.tintColor = .systemYellow
        tabBar.unselectedItemTintColor = .systemPink
        tabBar.isTranslucent = false
    }
}

class MoviewsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "BESTMoviews"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .systemYellow
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search for movies"
        searchBar.sizeToFit()
        searchBar.barTintColor = .black
        searchBar.tintColor = .systemYellow
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = .systemYellow
        }
        return searchBar
    }()
    
    private let segmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["Now Showing", "Coming Soon"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.backgroundColor = .black
        segmentControl.tintColor = .systemYellow
        segmentControl.selectedSegmentTintColor = .systemYellow
        return segmentControl
    }()
    
    private lazy var moviesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: view.frame.width / 2 - 20, height: 250)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: nil)
        navigationController?.navigationBar.barTintColor = .systemPink
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
        
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(segmentControl)
        view.addSubview(moviesCollection)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        moviesCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
                        
            segmentControl.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            segmentControl.heightAnchor.constraint(equalToConstant: 30),
            
            moviesCollection.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20),
            moviesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            moviesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            moviesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.backgroundColor = .black
        cell.posterImageView.image = UIImage(named: "alita")
        cell.titleLabel.text = "Alita"
        cell.descriptionLabel.text = "Action | 2hr 10m | PG-13"
        return cell
    }
}


class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .systemYellow
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemYellow
        return label
    }()
    
    private lazy var movieStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(movieStackView)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        movieStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            
            movieStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5),
            movieStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            movieStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            movieStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
}

class SecondVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

class ThirdVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen

        let navigateButton = UIButton(type: .system)
        navigateButton.setTitle("Go to Details", for: .normal)
        navigateButton.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        navigateButton.addTarget(self, action: #selector(navigateToDetails), for: .touchUpInside)

        view.addSubview(navigateButton)
    }

    @objc func navigateToDetails() {
        let detailsVC = DetailsVC()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
class DetailsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemYellow
        title = "Details"
    }
}
