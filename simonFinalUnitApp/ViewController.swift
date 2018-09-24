


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet var colorDisplays: [UIView]!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var colorsFrame: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    var sound: AVAudioPlayer?
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
        for number in 0..<colorDisplays.count{
            if colorDisplays[number].frame.contains(sender.location(in: colorsFrame)) {
            flashColor(number: number)
                index += 1
        }
    }
    
    @IBAction func onStartButtonTapped(_ sender: UIButton) {
    }
    func playSound(fileName: String){
        if let path = Bundle.main.path(forResource: fileName, ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            do {
                self.sound = try AVAudioPlayer(contentsOf: url)
                self.sound?.play()
            }
            catch {
                print("Can't find file")
            }
        }
    }
    func addToPattern() {
        pattern.append(Int(arc4random_uniform(4)))
    }
    func restart() {
        pattern.removeAll()
        index = 0
        addToPattern()
        startButton.alpha = 1.0
    }
    func flashColor(number: Int) {
        self.playSound(fileName: String(number))
        UIView.transition(with: colorDisplays[number], duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.colorDisplays[number].alpha = 1.0
        }) { (true) in
            UIView.transition(with: self.colorDisplays[number], duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.colorDisplays[number].alpha = 0.4
            }, completion: nil)
        }
        
    }
}














