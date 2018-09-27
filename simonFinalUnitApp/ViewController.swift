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
        colorsFrame.backgroundColor = .purple
        playSound(fileName: "start")
        
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
    
    @IBAction func onStartButtonTapped(_ sender: Any) {
        if gameOver {
            restart()
            displayPattern()
            gameOver = false
            startButton.alpha = 0.0
            messageLabel.text = ""
        }
    }
    
    @IBAction func onColorTapped(_ sender: UITapGestureRecognizer) {
        for number in 0..<colorDisplays.count{
            if colorDisplays[number].frame.contains(sender.location(in: colorsFrame)) {
                if pattern[index] == number {
                    flashColor(number: number)
                    index += 1
                    if index == pattern.count {
                        index = 0
                        playTurn = false
                        messageLabel.text = ""
                        addToPattern()
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                            self.displayPattern()
                        }
                    }
                }
                else {
                    messageLabel.text = "Game Over"
                    gameOver = true
                    playSound(fileName: "lose")
                    restart()
                }
                flashColor(number: number)
                index += 1
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
    func displayPattern() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(ViewController.nextColor)), userInfo: nil, repeats: true)
    }
    @objc func nextColor() {
        if index < pattern.count {
            flashColor(number: pattern[index])
            index += 1
        }
        else {
            timer.invalidate()
            index = 0
            playTurn = true
            messageLabel.text = "Your Turn"
        }
    }
    
}

