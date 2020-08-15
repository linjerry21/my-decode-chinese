//
//  ViewController.swift
//  Test1
//
//  Created by xander on 2020/8/11.
//  Copyright © 2020 com.jerry. All rights reserved.
//

import UIKit
import AVFoundation

struct component : Codable {
    let hanzi : String?
    let pinyin : String?
    let pinyin_tone : Int?
    let meaning : String?
}

struct etymology_note : Codable {
    let character_decomposition : String?
    let decomposition_notes : String?
    let image : [[String : String]]?
    
}

struct radical : Codable {
    let hanzi : String?
    let pinyin : String?
    let pinyin_tone : Int?
    let meaning : String?
    let variation : [String]?
    
}

struct character : Codable {
    let id : Int?
    let hanzi : String?
    let pinyin : String?
    let pinyin_tone : Int?
    let stroke : Int?    
    let meaning : String?
    let radical : radical?
    let component : [component]?
    let etymology_note : etymology_note?
}

struct sentence : Codable {
    let hanzi : String?
    let pinyin : String?
    let meaning : String?
}

struct word : Codable {
    let id : Int?
    let word_order : Int?
    let hanzi : String?
    let pinyin : String?
    let measure_word : String?
    let meaning : String?
    let word_class : String?
    let audio : String?
    let sentence : sentence?
    let characters : [character]?
}

struct ResponseData: Codable {
    let words : [word]
}

// store the result after parsing json data
var word_list : ResponseData!

class ViewController: UIViewController {
    var audioPlayer : AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadJson(fileName: "word_list")
        //playAudioFromProject(filename: "kao3_juan4")
    }
    
    

    func loadJson(fileName: String) -> Void {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {return}
        let data = (try? Data(contentsOf: url))!
        
        do {
            let decoder = JSONDecoder()
            word_list = try decoder.decode(ResponseData.self, from: data)
            print("parsing json data complete.")
//            let first_word = word_list.words[0]
//            print("first_word\(first_word)")
//            //print(first_word.hanzi as Any)
//            let hanzi = (first_word.hanzi ?? "") as String
//            print(hanzi)
        } catch let err {
            print(err.localizedDescription)
        }
        
        
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//            print(json!["words"]!)
//            let words = json!["words"] as? Array<Dictionary<String, Any>>
//            print("word count:\(String(describing: words?.count))")
//            let first_word = (words?[0])! as NSDictionary
//            print("pinyin:\(first_word["pinyin"])")
//            let tmp = first_word["characters"] as? Array<Any>
//            print("tmp[0]\(tmp![0])")
//            let c1 = tmp![0] as! character
//            print("c1:\(c1)")
//
//        } catch let err {print(err.localizedDescription)}
        
    }
    
//    func utf8DecodedString()-> String {
//         let data = self.data(using: .utf8)
//         if let message = String(data: data!, encoding: .nonLossyASCII){
//                return message
//          }
//          return ""
//    }

    
    
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

