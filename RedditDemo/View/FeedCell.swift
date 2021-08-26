//
//  FeedCell.swift
//  RedditDemo
//
//  Created by dhruva beti on 8/25/21.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var titLabel: UILabel!
    @IBOutlet weak var prevImage: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
