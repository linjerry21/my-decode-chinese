//
//  Second.swift
//  Test1
//
//  Created by 林杰承 on 2020/8/13.
//  Copyright © 2020 com.jerry. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class Third: UIViewController {
    var audioPlayer : AVPlayer!
    var test : component?
    var firstWord : word?
        
    @IBOutlet weak var p1: UILabel!
    @IBOutlet weak var p2: UILabel!
    @IBOutlet weak var p3: UILabel!
    @IBOutlet weak var p4: UILabel!
    @IBOutlet weak var h1: UILabel!
    @IBOutlet weak var h2: UILabel!
    @IBOutlet weak var h3: UILabel!
    @IBOutlet weak var h4: UILabel!
    @IBOutlet weak var mean: UILabel!
    @IBOutlet weak var s1: UILabel!
    @IBOutlet weak var s2: UILabel!
    @IBOutlet weak var s3: UILabel!
    
    @IBOutlet weak var wordBtn1: UIButton!
    @IBOutlet weak var wordBtn2: UIButton!
    @IBOutlet weak var wordBtn3: UIButton!
    @IBOutlet weak var wordBtn4: UIButton!
    
    
    //stroke btn
    @IBOutlet weak var strokeBtn1: UIButton!
    @IBOutlet weak var strokeBtn2: UIButton!
    @IBOutlet weak var strokeBtn3: UIButton!
    @IBOutlet weak var strokeBtn4: UIButton!
    
    //Radical part
    @IBOutlet weak var r1: UILabel!
    @IBOutlet weak var r2: UILabel!
    @IBOutlet weak var r3: UILabel!
    @IBOutlet weak var rv1: UILabel!
    @IBOutlet weak var rv2: UILabel!
    
    //Component  part
    @IBOutlet weak var comp1: UILabel!
    @IBOutlet weak var comp2: UILabel!
    @IBOutlet weak var comp3: UILabel!
    
    //etymology_note part
    @IBOutlet weak var ety1: UITextView!
    @IBOutlet weak var ety2: UITextView!
    @IBOutlet weak var ety_image1: UIImageView!
    @IBOutlet weak var ety_hStack: UIStackView!
    @IBOutlet weak var ety_image2: UIImageView!
    @IBOutlet weak var ety_image3: UIImageView!
    
    var imageTapped :  UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        tap1.numberOfTapsRequired = 1
        ety_image1.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        tap2.numberOfTapsRequired = 1
        ety_image2.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        tap3.numberOfTapsRequired = 1
        ety_image3.addGestureRecognizer(tap3)

        
        
        firstWord = word_list.words[1]
        loadFirstWord(word: firstWord!)
        
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        // do something here
        //print("tag:\(sender.view?.tag)")
        switch sender.view?.tag {
        case 11:
            imageTapped = ety_image1.image
        case 12:
            imageTapped = ety_image2.image
        case 13:
            imageTapped = ety_image3.image
        default:
            break
        }
        
        self.performSegue(withIdentifier: "toZoomImage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toZoomImage" {
            let vc = segue.destination as! ZoomImage
            vc.image = imageTapped
            
        }
    }
    
    
    func loadFirstWord(word : word) -> Void {
        //first character
        let c1 = word.characters![0]
        p1.textColor = UIColor(hex: getColorCode(tone: c1.pinyin_tone!))
        p1.text = c1.pinyin
        h1.textColor = UIColor(hex: getColorCode(tone: c1.pinyin_tone!))
        h1.text = c1.hanzi
        strokeBtn1.setTitle("\(c1.stroke ?? 0)", for: .normal)
        
        //second character
        let c2 = word.characters![1]
        p2.textColor = UIColor(hex: getColorCode(tone: c2.pinyin_tone!))
        p2.text =  c2.pinyin
        h2.textColor = UIColor(hex: getColorCode(tone: c2.pinyin_tone!))
        h2.text = c2.hanzi
        strokeBtn2.setTitle("\(c2.stroke ?? 0)", for: .normal)
        
        //third character
        let c3 = word.characters![0]
        p3.textColor = UIColor(hex: getColorCode(tone: c3.pinyin_tone!))
        p3.text = c3.pinyin
        h3.textColor = UIColor(hex: getColorCode(tone: c3.pinyin_tone!))
        h3.text = c3.hanzi
        strokeBtn3.setTitle("\(c3.stroke ?? 0)", for: .normal)
        
        //fourth character
        let c4 = word.characters![2]
        p4.textColor = UIColor(hex: getColorCode(tone: c4.pinyin_tone!))
        p4.text = c4.pinyin
        h4.textColor = UIColor(hex: getColorCode(tone: c4.pinyin_tone!))
        h4.text = c4.hanzi
        strokeBtn4.setTitle("\(c4.stroke ?? 0)", for: .normal)
        
        
        
        //meaning
        mean.text = word.meaning
        
        //sentence
        s1.text = word.sentence?.hanzi
        s2.text = word.sentence?.pinyin
        s3.text = word.sentence?.meaning
        
        //
        wordBtn1.setTitleColor(UIColor(hex: getColorCode(tone: c1.pinyin_tone!)), for: .normal)
        wordBtn1.setTitle((c1.hanzi! + " " + c1.pinyin!), for: .normal)
        wordBtn2.setTitleColor(UIColor.lightGray, for: .normal)
        wordBtn2.setTitle((c2.hanzi! + " " + c2.pinyin!), for: .normal)
        wordBtn3.setTitleColor(UIColor.lightGray, for: .normal)
        wordBtn3.setTitle((c3.hanzi! + " " + c2.pinyin!), for: .normal)
        wordBtn4.setTitleColor(UIColor.lightGray, for: .normal)
        wordBtn4.setTitle((c4.hanzi! + " " + c2.pinyin!), for: .normal)
        
        
        //Radical
        r1.text = c1.radical?.hanzi
        r2.textColor = UIColor(hex: getColorCode(tone: c1.pinyin_tone!))
        r2.text = c1.radical?.hanzi
        r3.text = c1.radical?.meaning
        if c1.radical?.variation?.count == 0 {
            rv1.isHidden = true
            rv2.isHidden = true
        } else {
            rv2.text = c1.radical?.variation![0]
        }
        
        //Component
        if c1.component?.count  == 0 {
            comp1.text = ""
            comp2.text = ""
            comp3.text = ""
        } else {
            let c1_component = c1.component![0]
            comp1.text = c1_component.hanzi
            comp2.textColor = UIColor(hex: getColorCode(tone: c1_component.pinyin_tone!))
            comp2.text = c1_component.pinyin
            comp3.text = c1_component.meaning
        }
        
        //etymology_note part
        ety1.text = c1.etymology_note?.character_decomposition
        ety1.adjustUITextViewHeight()
        ety2.text = c1.etymology_note?.decomposition_notes
        //ety2.adjustUITextViewHeight()
        loadImage(c: c1)

    }
    
    //Play word
    @IBAction func playSound(_ sender: UIButton) {
        let filename = firstWord?.audio?.components(separatedBy: ".")
        playAudioFromProject(filename: filename![0])
    }
    
    @IBAction func nextCard(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func checkC1Press(_ sender: UIButton) {
        let c1 = firstWord?.characters![0]
        //let c2 = firstWord?.characters![1]
        wordBtn1.setTitleColor(UIColor(hex: getColorCode(tone: (c1?.pinyin_tone!)!)), for: .normal)
        //wordBtn1.setTitle(((c1?.hanzi!)! + " " + (c1?.pinyin!)!), for: .normal)
        wordBtn2.setTitleColor(UIColor.lightGray, for: .normal)
        //wordBtn2.setTitle(((c2?.hanzi!)! + " " + (c2?.pinyin!)!), for: .normal)
        wordBtn3.setTitleColor(UIColor.lightGray, for: .normal)
        wordBtn4.setTitleColor(UIColor.lightGray, for: .normal)
        
        //radical part
        r1.text = c1?.radical?.hanzi
        r2.textColor = UIColor(hex: getColorCode(tone: (c1?.pinyin_tone!)!))
        r2.text = c1?.radical?.hanzi
        r3.text = c1?.radical?.meaning
        if c1?.radical?.variation?.count == 0 {
            rv1.isHidden = true
            rv2.isHidden = true
        } else {
            rv2.text = c1?.radical?.variation![0]
        }
        
        //Component
        if c1?.component?.count  == 0 {
            comp1.text = ""
            comp2.text = ""
            comp3.text = ""
        } else {
            let c1_component = c1?.component![0]
            comp1.text = c1_component?.hanzi
            comp2.textColor = UIColor(hex: getColorCode(tone: (c1_component?.pinyin_tone!)!))
            comp2.text = c1_component?.pinyin
            comp3.text = c1_component?.meaning
        }
        
        //etymology_note part
        ety1.text = c1?.etymology_note?.character_decomposition
        ety1.adjustUITextViewHeight()
        ety2.text = c1?.etymology_note?.decomposition_notes
        //ety2.adjustUITextViewHeight()
        loadImage(c: c1!)
        
    }
    
    @IBAction func checkC2Press(_ sender: UIButton) {
        //let c1 = firstWord?.characters![0]
        let c2 = firstWord?.characters![1]
        wordBtn1.setTitleColor(UIColor.lightGray, for: .normal)
        //wordBtn1.setTitle(((c1?.hanzi!)! + " " + (c1?.pinyin!)!), for: .normal)
        wordBtn2.setTitleColor(UIColor(hex: getColorCode(tone: (c2?.pinyin_tone!)!)), for: .normal)
        //wordBtn2.setTitle(((c2?.hanzi!)! + " " + (c2?.pinyin!)!), for: .normal)
        wordBtn3.setTitleColor(UIColor.lightGray, for: .normal)
        wordBtn4.setTitleColor(UIColor.lightGray, for: .normal)
        
        //radical part
        r1.text = c2?.radical?.hanzi
        r2.textColor = UIColor(hex: getColorCode(tone: (c2?.pinyin_tone!)!))
        r2.text = c2?.radical?.hanzi
        r3.text = c2?.radical?.meaning
        if c2?.radical?.variation?.count == 0 {
            rv1.isHidden = true
            rv2.isHidden = true
        } else {
            rv2.text = c2?.radical?.variation![0]
        }
        
        //Component
        if c2?.component?.count  == 0 {
            comp1.text = ""
            comp2.text = ""
            comp3.text = ""
        } else {
            let c2_component = c2?.component![0]
            comp1.text = c2_component?.hanzi
            comp2.textColor = UIColor(hex: getColorCode(tone: (c2_component?.pinyin_tone!)!))
            comp2.text = c2_component?.pinyin
            comp3.text = c2_component?.meaning
        }
        
        //etymology_note part
        ety1.text = c2?.etymology_note?.character_decomposition
        ety1.adjustUITextViewHeight()
        ety2.text = c2?.etymology_note?.decomposition_notes
        //ety2.adjustUITextViewHeight()
        loadImage(c: c2!)
    }
    
    @IBAction func checkC3Press(_ sender: Any) {
        let c3 = firstWord?.characters![0]
        wordBtn1.setTitleColor(UIColor.lightGray, for: .normal)
        wordBtn2.setTitleColor(UIColor.lightGray, for: .normal)
        wordBtn3.setTitleColor(UIColor(hex: getColorCode(tone: (c3?.pinyin_tone!)!)), for: .normal)
        wordBtn4.setTitleColor(UIColor.lightGray, for: .normal)
        
        //radical part
        r1.text = c3?.radical?.hanzi
        r2.textColor = UIColor(hex: getColorCode(tone: (c3?.pinyin_tone!)!))
        r2.text = c3?.radical?.hanzi
        r3.text = c3?.radical?.meaning
        if c3?.radical?.variation?.count == 0 {
            rv1.isHidden = true
            rv2.isHidden = true
        } else {
            rv2.text = c3?.radical?.variation![0]
        }
        
        //Component
        if c3?.component?.count  == 0 {
            comp1.text = ""
            comp2.text = ""
            comp3.text = ""
        } else {
            let c3_component = c3?.component![0]
            comp1.text = c3_component?.hanzi
            comp2.textColor = UIColor(hex: getColorCode(tone: (c3_component?.pinyin_tone!)!))
            comp2.text = c3_component?.pinyin
            comp3.text = c3_component?.meaning
        }
        
        //etymology_note part
        ety1.text = c3?.etymology_note?.character_decomposition
        ety1.adjustUITextViewHeight()
        ety2.text = c3?.etymology_note?.decomposition_notes
        //ety2.adjustUITextViewHeight()
        loadImage(c: c3!)
        
        
    }
    
    @IBAction func checkC4Press(_ sender: Any) {
        let c4 = firstWord?.characters![2]
        wordBtn1.setTitleColor(UIColor.lightGray, for: .normal)
        wordBtn2.setTitleColor(UIColor.lightGray, for: .normal)
        wordBtn3.setTitleColor(UIColor.lightGray, for: .normal)
        wordBtn4.setTitleColor(UIColor(hex: getColorCode(tone: (c4?.pinyin_tone!)!)), for: .normal)
        
        //radical part
        r1.text = c4?.radical?.hanzi
        r2.textColor = UIColor(hex: getColorCode(tone: (c4?.pinyin_tone!)!))
        r2.text = c4?.radical?.hanzi
        r3.text = c4?.radical?.meaning
        if c4?.radical?.variation?.count == 0 {
            rv1.isHidden = true
            rv2.isHidden = true
        } else {
            rv2.text = c4?.radical?.variation![0]
        }
        
        //Component
        if c4?.component?.count  == 0 {
            comp1.text = ""
            comp2.text = ""
            comp3.text = ""
        } else {
            let c4_component = c4?.component![0]
            comp1.text = c4_component?.hanzi
            comp2.textColor = UIColor(hex: getColorCode(tone: (c4_component?.pinyin_tone!)!))
            comp2.text = c4_component?.pinyin
            comp3.text = c4_component?.meaning
        }
        
        //etymology_note part
        ety1.text = c4?.etymology_note?.character_decomposition
        ety1.adjustUITextViewHeight()
        ety2.text = c4?.etymology_note?.decomposition_notes
        //ety2.adjustUITextViewHeight()
        loadImage(c: c4!)
        
    }
    
    func loadImage(c : character) -> Void {
        let image_list = c.etymology_note?.image
        if image_list?.count == 0 {
            ety_image1.isHidden = true
            ety_hStack.isHidden = true
        }  else  {
            switch c.etymology_note?.image?.count {
            case 1:
                ety_image1.isHidden = false
                ety_hStack.isHidden = true
                let imageObj = image_list![0]
                let filename = imageObj["file_name"]
                ety_image1.image = UIImage(named: filename!)
            case 2:
                ety_image1.isHidden = true
                ety_hStack.isHidden = false
                var imageObj = image_list![0]
                var filename = imageObj["file_name"]
                ety_image2.image = UIImage(named: filename!)
                imageObj = image_list![1]
                filename  = imageObj["file_name"]
                ety_image3.image = UIImage(named: filename!)
            default:
                break
            }
        }
    }
        
    func getColorCode(tone : Int) -> String {
        var hexColor = ""
        
        switch tone {
        case 1:
            hexColor = "#C96250"
        case 2:
            hexColor = "#DFB36C"
        case 3:
            hexColor = "#9FD147"
        case 4:
            hexColor = "#157DB0"
        case 5:
            hexColor = "#48566A"
        default:
            break
        }
        return hexColor
    }
    
    //Play Stroke
    @IBAction func playStroke1(_ sender: UIButton) {
        guard let videoURL = Bundle.main.url(forResource: "Video3", withExtension: "mp4") else {
            print("error to get the mp4 file")
            return
        }
        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player

        present(vc, animated: true) {
            vc.player?.play()
        }
        
    }
    
    @IBAction func playStroke2(_ sender: UIButton) {
        guard let videoURL = Bundle.main.url(forResource: "Video4", withExtension: "mp4") else {
            print("error to get the mp4 file")
            return
        }
        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player

        present(vc, animated: true) {
            vc.player?.play()
        }
        
    }
    
    @IBAction func playStroke3(_ sender: UIButton) {
        guard let videoURL = Bundle.main.url(forResource: "Video5", withExtension: "mp4") else {
            print("error to get the mp4 file")
            return
        }
        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player

        present(vc, animated: true) {
            vc.player?.play()
        }
        
    }
    
   
    
    
    func playAudioFromProject(filename : String) -> Void {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            print("error to get the mp3 file")
            return
        }
        
        audioPlayer = AVPlayer(url: url)
        audioPlayer?.play()
    }
    
    func playAudioFromURL(urlPath : String) {
        guard let url = URL(string: urlPath) else {
            print("error to get the mp3 file")
            return
        }
        
        audioPlayer = AVPlayer(url: url as URL)
        audioPlayer?.play()
    }
    

}
