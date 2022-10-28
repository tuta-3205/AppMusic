import UIKit

final class PlaylistViewController: UIViewController {
    @IBOutlet private weak var playlistTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
    }

    private func configViews() {
        playlistTable.dataSource = self
        playlistTable.delegate = self
        playlistTable.backgroundColor = .black
    }
}

extension PlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataMusic.musics.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as? MusicItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setDataCell(song: DataMusic.musics[indexPath.row])
        cell.backgroundColor = .black
        return cell
    }
}

extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playlistTable.deselectRow(at: indexPath, animated: false)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let detailPageController = sb.instantiateViewController(identifier: "DetailMusic") as? DetailViewController else {
            return
        }
        detailPageController.setDataPage(index: indexPath.row)
        
        self.navigationController?.pushViewController(detailPageController, animated: true)
    }
}
