//
//  MyTableViewCell.swift
//  MovieApp
//
//  Created by 전수민 on 2023/05/17.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var salesAcc: UILabel!
    @IBOutlet weak var audiAcc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
