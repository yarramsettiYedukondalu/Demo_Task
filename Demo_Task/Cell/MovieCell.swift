
import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var designView: UIView!
    private var movie: Movie?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupUI() {
        favoriteButton.layer.cornerRadius = 10
        designView.applyShadow()
    }
    func configure(with movie: Movie) {
        self.movie = movie
        titleLabel.text = movie.Title
        releaseDateLabel.text = "Release: \(movie.Year)"
        loadMovieImage(from: movie.Poster)
        updateFavoriteButton()
    }

    private func loadMovieImage(from url: String) {
        if let imageUrl = URL(string: url) {
                    URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.movieImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    @IBAction func favouriteButtonAction(_ sender: Any) {
        guard let movie = movie else { return }
        toggleFavorite(movie: movie)
        updateFavoriteButton()
    }

    private func toggleFavorite(movie: Movie) {
        let isFavorite = UserDefaults.standard.bool(forKey: movie.imdbID ?? "")
        UserDefaults.standard.set(!isFavorite, forKey: movie.imdbID ?? "")
    }
    private func updateFavoriteButton() {
        guard let movie = movie else { return }
        let isFavorite = UserDefaults.standard.bool(forKey: movie.imdbID ?? "")
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
