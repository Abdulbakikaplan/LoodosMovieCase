//
//  HomeVC.swift
//  LoodosMovieCase
//
//  Created by Abdülbaki Kaplan on 14.06.2020.
//  Copyright © 2020 Baki. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        }
    }
    private var movies: [Movie] = [] {
        didSet {
            if movies.count == 0 {
                if searchText == "" {
                    DispatchQueue.main.async {
                        self.tableView.showEmptyLabel(message: "Enter a movie name.", containerView: self.tableView)
                    }
                }
            }else {
                DispatchQueue.main.async {
                    self.tableView.hideTableViewEmptyMessage()
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var page = Constant.pageStartIndex
    private var isNewDataLoading = false
    private var isEnd = false
    private var searchText: String = "" {
        didSet {
            page = Constant.pageStartIndex
            isNewDataLoading = false
            isEnd = false
            NetworkManager.shared.router.cancel()
            getMovies(searchText, page)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }
}

//MARK: TableView Funcs

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.setUI(movie)
        return cell
    }

     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row+Constant.lazyLoadingBeforeCellCount >= movies.count {
            if !isNewDataLoading{
                isNewDataLoading = true
                page = page+1
                getMovies(searchText, page)
            }
        }
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailVC(nibName: "MovieDetailVC", bundle: nil)
        
        let movie = movies[indexPath.row]
        vc.movieId = movie.imdbID
        self.animateNavigate(vc: vc)

    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.movieCellHeight
    }
    

    
}

//MARK: Service Call

extension HomeVC {
    func getMovies(_ query: String, _ page: Int) {
        if !isEnd {
            NetworkManager.shared.getMovies(query: query, page: page) { (moviesResponse, isEnd, responseError, error) in
                if let responseError = responseError {
                    DispatchQueue.main.async {
                        self.tableView.showEmptyLabel(message: responseError, containerView: self.tableView)
                    }
                }
                if page == Constant.pageStartIndex {
                    self.movies = moviesResponse ?? []
                }else {
                    self.movies.append(contentsOf: moviesResponse ?? [])
                }
                self.isEnd = isEnd
                self.isNewDataLoading = false
            }
        }
    }
}

//MARK: SearchBar Delegate
extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}
