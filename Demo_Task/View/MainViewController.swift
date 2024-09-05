
import UIKit

func isFavorite(movie: Movie) -> Bool {
    return UserDefaults.standard.bool(forKey: movie.Title)
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var isSearching = false
    let refreshControl = UIRefreshControl() // Add this line
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        fetchMovies()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // Configure and add the refresh control
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = !searchText.isEmpty
        filteredMovies = movies.filter { $0.Title.lowercased().contains(searchText.lowercased()) }
        tableView.reloadData()
    }
    
    func fetchMovies(query: String = "Marvel", completion: (() -> Void)? = nil) {
        MovieService.shared.fetchMovies(query: query) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.filteredMovies = movies
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    completion?()
                }
            case .failure(let error):
                print("Error fetching movies: \(error.localizedDescription)")
                completion?()
            }
        }
    }

    @objc func refreshTableView() {
        fetchMovies {
            self.refreshControl.endRefreshing()
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredMovies.count : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieCell
        let movie = isSearching ? filteredMovies[indexPath.row] : movies[indexPath.row]
        
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = isSearching ? filteredMovies[indexPath.row] : movies[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailsViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController else {
            return
        }
        detailsViewController.movie = movie
        detailsViewController.modalPresentationStyle = .fullScreen
        detailsViewController.modalTransitionStyle = .coverVertical
        self.present(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}
