//
//  MovieDetailVC.swift
//  LoodosMovieCase
//
//  Created by Abdülbaki Kaplan on 14.06.2020.
//  Copyright © 2020 Baki. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

enum MovieSection: Int, CaseIterable {
    case movieImage = 0
    case movieDesc
    case movieActors
}
class MovieDetailVC: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "MovieImageCell", bundle: nil), forCellReuseIdentifier: "MovieImageCell")
            tableView.register(UINib(nibName: "MovieDescriptionCell", bundle: nil), forCellReuseIdentifier: "MovieDescriptionCell")
            tableView.register(UINib(nibName: "ActorsCell", bundle: nil), forCellReuseIdentifier: "ActorsCell")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
        }
    }
    
    private var movieDetail: MovieDetailModel? {
        didSet{
            Analytics.logEvent("movieDetail", parameters: try! movieDetail?.asDictionary())
            tableView.reloadData()
        }
    }
    var movieId: String? {
        didSet{
            getDetails(movieId ?? "")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: Service
    func getDetails(_ movieId : String) {
        DispatchQueue.main.async {
            PKHUD.sharedHUD.show()
        }
        NetworkManager.shared.getMovieDetail(movieId: movieId) { (movieDetailResponse, error) in
            DispatchQueue.main.async {
                PKHUD.sharedHUD.hide()
            }
            if error != nil {
                self.showAlert(title: "Error", message: error)
            }
            self.movieDetail = movieDetailResponse
        }
    }
}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MovieSection.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = MovieSection(rawValue: section)
        switch sectionType {
        case .movieImage:
            return 1
        case .movieDesc:
            return 1
        case .movieActors:
            return 1
        case .none:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = MovieSection(rawValue: indexPath.section)
        switch sectionType {
        case .movieImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieImageCell", for: indexPath) as! MovieImageCell
            
            if let movie = movieDetail {
                cell.setCell(movieDetail: movie)
            }
            return cell
        case .movieDesc:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDescriptionCell", for: indexPath) as! MovieDescriptionCell
            cell.descriptionLabel.text = movieDetail?.plot
            return cell
        case .movieActors:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActorsCell", for: indexPath) as! ActorsCell
            cell.actorsLabel.text = movieDetail?.actors
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
