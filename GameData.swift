//
//  GameData.swift
//  jack64
//
//  Created by ABD on 27/11/2016.
//  Copyright © 2016 ABD. All rights reserved.
//

import Foundation



class GameData : NSObject , NSCoding {
    
    struct Keys {
         static let EasyDefficultyScore = "EasyDefficultyScore"
         static let MediumDefficultyScore = "MediumDefficultyScore"
         static let HardDefficultyScore = "HardDefficultyScore"
        
        static let EasyDefficultyCoinScore = "EasyDefficultyCoinScore"
        static let MediumDefficultyCoinScore = "MediumDefficultyCoinScore"
        static let HardDefficultyCoinScore = "HardDefficultyCoinScore"
        
        static let EasyDefficulty = "EasyDefficulty"
        static let MediumDefficulty = "MediumDefficulty"
        static let HardDefficulty = "HardDefficulty"
        
        static let Music = "Music"

    }

    private var  easyDefficultyScore = Int32()
    private var mediumDefficultyScore = Int32()
    private var hardDefficultyScore = Int32()
    
    private var  easyDefficultyCoinScore = Int32()
    private var mediumDefficultyCoinScore = Int32()
    private var hardDefficultyCoinScore = Int32()
    
    private var easyDefficulty = false
    private var mediumDefficulty = false
    private var hardDefficulty = false
    
    private var isMusicOn = false
    override init() {}
    required init(coder aDecoer : NSCoder) {
        super.init()
        self.easyDefficultyScore = aDecoer.decodeCInt(forKey: Keys.EasyDefficultyScore)
        self.easyDefficultyCoinScore = aDecoer.decodeCInt(forKey: Keys.EasyDefficultyCoinScore)
        
        self.mediumDefficultyScore = aDecoer.decodeCInt(forKey: Keys.MediumDefficultyScore)
        self.mediumDefficultyCoinScore = aDecoer.decodeCInt(forKey: Keys.MediumDefficultyCoinScore)
        
        self.hardDefficultyScore = aDecoer.decodeCInt(forKey: Keys.HardDefficultyScore)
        self.hardDefficultyCoinScore = aDecoer.decodeCInt(forKey: Keys.HardDefficultyCoinScore)
        
        self.easyDefficulty = aDecoer.decodeBool(forKey: Keys.EasyDefficulty)
        self.mediumDefficulty = aDecoer.decodeBool(forKey: Keys.MediumDefficulty)
        self.hardDefficulty = aDecoer.decodeBool(forKey: Keys.HardDefficulty)
        
        self.isMusicOn = aDecoer.decodeBool(forKey: Keys.Music)
        
    }
    func encode(with aCoder: NSCoder) {
        //Easy
        aCoder.encode(self.easyDefficultyScore, forKey: Keys.EasyDefficultyScore)
        aCoder.encode(self.easyDefficultyCoinScore, forKey: Keys.EasyDefficultyCoinScore)
        //medium
        aCoder.encode(self.mediumDefficultyScore, forKey: Keys.MediumDefficultyScore)
        aCoder.encode(self.mediumDefficultyCoinScore, forKey: Keys.MediumDefficultyCoinScore)
        //Hard
        aCoder.encode(self.hardDefficultyScore, forKey: Keys.HardDefficultyScore)
        aCoder.encode(self.hardDefficultyCoinScore, forKey: Keys.HardDefficultyCoinScore)
        
        aCoder.encode(self.easyDefficulty, forKey: Keys.EasyDefficulty)
        aCoder.encode(self.mediumDefficulty, forKey: Keys.MediumDefficulty)
        aCoder.encode(self.hardDefficulty, forKey: Keys.HardDefficulty)
        
        aCoder.encode(self.isMusicOn, forKey: Keys.Music)
    }
    
    func setEasyDefficultyScore(easyDefficultyScore:Int32){
      self.easyDefficultyScore = easyDefficultyScore
    
    }
    func setEasyDefficultyCoinScore(easyDefficultyCoinScore:Int32){
        self.easyDefficultyCoinScore = easyDefficultyCoinScore
        
    }
    func getEasyDefficultyScore() -> Int32 {
    
    return self.easyDefficultyScore
    
    }
    func getEasyDefficultyCoinScore() -> Int32 {
        
        return self.easyDefficultyCoinScore
        
    }
    //medium
    func setMediumDefficultyScore(mediumDefficultyScore:Int32){
        self.mediumDefficultyScore = mediumDefficultyScore
        
    }
    func setMediumDefficultyCoinScore(mediumDefficultyCoinScore:Int32){
        self.mediumDefficultyCoinScore = mediumDefficultyCoinScore
        
    }
    func getMediumDefficultyScore() -> Int32 {
        
        return self.mediumDefficultyScore
        
    }
    func getMediumDefficultyCoinScore() -> Int32 {
        
        return self.mediumDefficultyCoinScore
        
    }
    //hard
    func setHardDefficultyScore(hardDefficultyScore:Int32){
        self.hardDefficultyScore = hardDefficultyScore
        
    }
    func setHardDefficultyCoinScore(hardDefficultyCoinScore:Int32){
        self.hardDefficultyCoinScore = hardDefficultyCoinScore
        
    }
    func getHardDefficultyScore() -> Int32 {
        
        return self.hardDefficultyScore
        
    }
    func getHardDefficultyCoinScore() -> Int32 {
        
        return self.hardDefficultyCoinScore
        
    }
          //set Options
    // easy option
    func setEasyDiffculty(easyDifficulty : Bool){
      self.easyDefficulty = easyDifficulty
    
    
    }
    
    func getEasyDifficulty() -> Bool{
     return self.easyDefficulty
    
    }
    // medium
    func setMediumDiffculty(mediumDifficulty : Bool){
        self.mediumDefficulty = mediumDifficulty
        
        
    }
    
    func getMediumDifficulty() -> Bool{
        return self.mediumDefficulty
        
    }
  // Hard
    func setHardDiffculty(hardDifficulty : Bool){
        self.hardDefficulty = hardDifficulty
        
        
    }
    
    func getHardDifficulty() -> Bool{
        return self.hardDefficulty
        
    }
    // music
    func setMusicOn(isMusicOn : Bool){
        self.isMusicOn = isMusicOn
        
        
    }
    
    func getMusic() -> Bool{
        return self.isMusicOn
        
    }
    



}
