//
//  RecordTableViewCell.swift
//  GGV_test
//
//  Created by Chan Yun Yuen on 15/8/2018.
//  Copyright © 2018 GGV. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var timeSpent: UILabel!
    @IBOutlet weak var maxTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
