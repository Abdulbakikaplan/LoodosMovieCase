//
//  MovieCell.swift
//  LoodosMovieCase
//
//  Created by Abdülbaki Kaplan on 14.06.2020.
//  Copyright © 2020 Baki. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func setUI(_ movie: Movie){
        DispatchQueue.main.async {
            self.movieImageView.kf.setImage(with: URL(string: movie.poster ?? ""), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            self.titleLabel.text = movie.title
            self.yearLabel.text = movie.year
        }
    }
}
