//
//  searchTableViewCell.swift
//  demo_relationship_coredata
//
//  Created by Mac172 on 23/01/20.
//  Copyright © 2020 Mac172. All rights reserved.
//

import UIKit

class searchTableViewCell: UITableViewCell {

    @IBOutlet weak var name_txt: UILabel!
    @IBOutlet weak var age_txt: UILabel!
    @IBOutlet weak var desig_txt: UILabel!
    @IBOutlet weak var sal_txt: UILabel!
    @IBOutlet weak var dept_txt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
