//
//  NewsTableViewCell.swift
//  RxSwiftApiServiceProject
//
//  Created by zapbuild on 17/09/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(article: Article){
        newTitleLabel.text = article.title
        newsDescriptionLabel.text = article.description
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
