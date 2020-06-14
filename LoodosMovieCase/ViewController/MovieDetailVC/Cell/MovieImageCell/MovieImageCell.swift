//
//  MovieImageCell.swift
//  LoodosMovieCase
//
//  Created by Abdülbaki Kaplan on 14.06.2020.
//  Copyright © 2020 Baki. All rights reserved.
//

import UIKit

class MovieImageCell: UITableViewCell {

    @IBOutlet weak var movieBigImage: UIImageView!
    @IBOutlet weak var movieSmallImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
//    var movieDetail: MovieDetailModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func setCell(movieDetail: MovieDetailModel) {
        movieBigImage.kf.setImage(with: URL(string: movieDetail.poster ?? ""), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
        movieSmallImage.kf.setImage(with: URL(string: movieDetail.poster ?? ""), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
        genreLabel.text = movieDetail.genre
        titleLabel.text = movieDetail.title
        ratingLabel.text = movieDetail.rated
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
