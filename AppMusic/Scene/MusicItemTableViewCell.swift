import UIKit

final class MusicItemTableViewCell: UITableViewCell {

    @IBOutlet private weak var imgBannerMusic: UIImageView!
    @IBOutlet private weak var txtName: UILabel!
    @IBOutlet private weak var txtAuthor: UILabel!

    func setDataCell(song: MusicModel) {
        imgBannerMusic?.image = UIImage(named: song.imageUrl ?? "")
        txtName?.text = song.name ?? ""
        txtAuthor?.text = song.author ?? ""
    }
}
