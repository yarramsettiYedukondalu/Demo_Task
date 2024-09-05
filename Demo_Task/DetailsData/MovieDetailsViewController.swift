
import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var designView: UIView!
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
       setUP()
    }
    func setUP(){
        designView.layer.cornerRadius = 5
        moviePosterImageView.layer.cornerRadius = 5
        configureView()
        dismissButton.layer.cornerRadius = 12.5
    }
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    private func configureView() {
        guard let movie = movie else { return }
        genreLabel.text = "\(movie.Genre ?? "N/A")"
        descriptionLabel.text = "\(movie.Plot ?? "N/A")"
        ratingsLabel.text = "\(movie.Ratings?.first(where: { $0.Source == "Internet Movie Database" })?.Value ?? "N/A")"
        if let imageUrl = URL(string: movie.Poster) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.moviePosterImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
