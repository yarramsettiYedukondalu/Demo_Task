
struct MovieListResponse: Codable {
    let Search: [Movie] 
    let totalResults: String
    let Response: String
    let Error: String?
}
struct Rating: Codable {
    let Source: String
    let Value: String
}

struct Movie: Codable {
    let Title: String
    let Year: String
    let Poster: String
    let Plot: String?
    let Genre: String?
    let Rated: String?
    let Ratings: [Rating]?
    let Released: String?
    let Runtime: String?
    let Director: String?
    let Writer: String?
    let Actors: String?
    let Language: String?
    let Country: String?
    let Awards: String?
    let Metascore: String?
    let imdbRating: String?
    let imdbVotes: String?
    let imdbID: String?
    let BoxOffice: String?
    let Production: String?
    let Website: String?
}
