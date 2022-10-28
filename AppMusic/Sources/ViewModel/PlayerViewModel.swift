import Foundation
import AVFoundation

final class PlayerViewModel: NSObject {
    static let shared = PlayerViewModel()
    
    var player: AVAudioPlayer?
    
    private override init() {}
    
    func playSound(_ musicFile: String?) {
        guard let url = Bundle.main.url(forResource: musicFile ?? "", withExtension: "mp3") else {
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
                
            player.prepareToPlay()
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func prepareToPlay() {
        player?.prepareToPlay()
    }
    
    func play() {
        player?.play()
    }
    
    func isPlaying() -> Bool {
        return player?.isPlaying ?? false
    }
    
    func stop() {
        player?.stop()
    }
    
    func pause() {
        player?.pause()
    }
    
    func getDuration() -> TimeInterval {
        return player?.duration ?? 0
    }
    
    func getCurrentTime() -> TimeInterval {
        return player?.currentTime ?? 0
    }
    
    func getDeviceCurrentTime() -> TimeInterval {
        return player?.deviceCurrentTime ?? 0
    }
    
    func setCurrentTime(_ time: TimeInterval) {
        player?.currentTime = time
    }
}
