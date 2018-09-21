
import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    @IBOutlet var colorDisplays: [UIView]!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var colorsFrame: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    var sound = AVAudioPlayer()
    var timer = Timer()
    var pattern = [Int]()
    var index = 0
    var playTurn = false
    var gameOver = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
      colorsFrame.backgroundColor = .red
    
    }

    @IBAction func onColorTapped(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func onStartButtonTapped(_ sender: UIButton) {
    }
    
    

    
    
    
}

