//
//  NewsFeedCell.swift
//  VKNewsFeed
//
//  Created by Александр Цветков on 18.04.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCell"
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
