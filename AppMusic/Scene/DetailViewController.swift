import UIKit
import AVFoundation

final class DetailViewController: UIViewController {
    @IBOutlet private weak var imgMusic: UIImageView!
    @IBOutlet private weak var txtName: UILabel!
    @IBOutlet private weak var txtAuthor: UILabel!
    @IBOutlet private weak var musicTime: UISlider!
    @IBOutlet private weak var playButton: UIButton!
  
    private var index: Int?
    private let player = PlayerViewModel.shared
    private var musicFile: String?
    private var timer: Timer?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadUI()
        playSound()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.stop()
    }
  
    private func reloadUI() {
        imgMusic?.image = UIImage(named: DataMusic.musics[index ?? 0].imageUrl ?? "")
        txtName?.text = DataMusic.musics[index ?? 0].name ?? ""
        txtAuthor?.text = DataMusic.musics[index ?? 0].author ?? ""
        musicFile = DataMusic.musics[index ?? 0].musicFile
    }
    
    func setDataPage(index: Int) {
        self.index = index
    }
    
    private func playSound() {
        player.playSound(musicFile)
        musicTime.maximumValue = Float(player.getDuration())
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateSlider()
        }
    }
  
    
    private func updateSlider() {
        musicTime.value = Float(player.getCurrentTime())
        
        if (Int(player.getCurrentTime()) == Int(player.getDuration())) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.index = ((self?.index ?? 0) + 1) % 3
                self?.viewDidLoad()
            }
        }
    }
    
    @IBAction private func playButtonClick(_ sender: Any) {
        if (player.isPlaying()) {
            player.pause()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @IBAction private func prevButtonClick(_ sender: Any) {
        index = ((index ?? 0) - 1 + 3) % 3
        self.viewDidLoad()
    }

    @IBAction private func nextButtonClick(_ sender: UIButton) {
        index = ((index ?? 0) + 1) % 3
        self.viewDidLoad()
    }
    
    @IBAction private func changeAudioTime(_ sender: Any) {
        player.pause()
        player.setCurrentTime(TimeInterval(musicTime?.value ?? 0))
        player.play()
    }
}
