import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messeageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        messeageBubble.layer.cornerRadius = messeageBubble.frame.size.height / 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
