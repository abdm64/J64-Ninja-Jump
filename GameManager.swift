//
//  GameController.swift
//  jack64
//
//  Created by ABD on 24/11/2016.
//  Copyright © 2016 ABD. All rights reserved.
//

import Foundation
import SpriteKit


class GameManager {

    static let instance = GameManager();
    private init(){}
    
    private var gameData : GameData?
    
    var gameStartedFromMainMenu = false
    var gameRestartedPlayerDied = false
    
    func initializeGameData(){
        
        if !FileManager.default.fileExists(atPath: getFilePath() as String){
            gameData = GameData()
            gameData?.setEasyDefficultyScore(easyDefficultyScore: 0)
            gameData?.setEasyDefficultyCoinScore(easyDefficultyCoinScore: 0)
            
            gameData?.setMediumDefficultyScore(mediumDefficultyScore: 0)
            gameData?.setEasyDefficultyCoinScore(easyDefficultyCoinScore: 0)
            
            gameData?.setHardDefficultyScore(hardDefficultyScore: 0)
            gameData?.setHardDefficultyCoinScore(hardDefficultyCoinScore: 0)
            
            gameData?.setEasyDiffculty(easyDifficulty: false)
            gameData?.setMediumDiffculty(mediumDifficulty: true)
            gameData?.setHardDiffculty(hardDifficulty: false)
            
            gameData?.setMusicOn(isMusicOn: true)
            
            saveData()
            
        
        }
            loadData()
    
    }
    
    func loadData(){
      gameData = NSKeyedUnarchiver.unarchiveObject(withFile: (getFilePath()as String?)!) as? GameData
        }
    func saveData(){
        if gameData != nil{
        NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath() as String)
        }
    }
      private func getFilePath() -> String{
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as NSURL!
        
        
    
       return (url?.appendingPathComponent("Game Data")?.path)!
    }
    
    
    
    
    
  
    func setEasyDefficultyScore(easyDefficultyScore: Int32){
    
      self.gameData?.setEasyDefficultyScore(easyDefficultyScore: easyDefficultyScore)
    
    }
    func getEasyDefficultyScore()-> Int32 {
    return (self.gameData?.getEasyDefficultyScore())!
    }
    func setEasyDefficultyCoinScore(easyDefficultyCoinScore: Int32){
        
        self.gameData?.setEasyDefficultyCoinScore(easyDefficultyCoinScore: easyDefficultyCoinScore)
        
    }
    func getEasyDefficultyCoinScore()-> Int32 {
        return (self.gameData?.getEasyDefficultyCoinScore())!
    }

    func setMediumDefficultyScore(mediumDefficultyScore : Int32){
      self.gameData?.setMediumDefficultyScore(mediumDefficultyScore: mediumDefficultyScore)
    
    }
    func getMediumDefficultyScore()-> Int32{
    
    return (self.gameData?.getMediumDefficultyScore())!
    
    }
    func setMediumDefficultyCoinScore(mediumDefficultyCoinScore : Int32){
        self.gameData?.setMediumDefficultyCoinScore(mediumDefficultyCoinScore: mediumDefficultyCoinScore)
        
    }
    func getMediumDefficultyCoinScore()-> Int32{
        
        return (self.gameData?.getMediumDefficultyCoinScore())!
        
    }
    func setHardDefficultyScore(hardDefficultyScore : Int32){
        self.gameData?.setHardDefficultyScore(hardDefficultyScore: hardDefficultyScore)
        
    }
    func getHardDefficultyScore()-> Int32{
        
        return (self.gameData?.getHardDefficultyScore())!
        
    }
    func setHardDefficultyCoinScore(hardDefficultyCoinScore : Int32){
        self.gameData?.setHardDefficultyCoinScore(hardDefficultyCoinScore: hardDefficultyCoinScore)
        
    }
    func getHardDefficultyCoinScore()-> Int32{
        
        return (self.gameData?.getHardDefficultyCoinScore())!
        
    }
    func setEasyDefficulty(easyDefficulty : Bool  ){
      gameData?.setEasyDiffculty(easyDifficulty: easyDefficulty)
    
    }
    func getEasyDefficultty()->Bool{
    
    return (gameData?.getEasyDifficulty())!
    
    }
    func setMediumDefficulty(mediumDefficulty : Bool  ){
        gameData?.setMediumDiffculty(mediumDifficulty: mediumDefficulty)
        
    }
    func getMediumDefficultty()->Bool{
        
        return (gameData?.getMediumDifficulty())!
        
    }
    func setHardDefficulty(hardDefficulty : Bool  ){
        gameData?.setHardDiffculty(hardDifficulty: hardDefficulty)
        
    }
    func getHardDefficultty()->Bool{
        
        return (gameData?.getHardDifficulty())!
        
    }
    func setIsMusicOn(isMusicOn : Bool){
      gameData?.setMusicOn(isMusicOn: isMusicOn)
    
    
    }
    func getIsMusicOn()-> Bool{
    return (gameData?.getMusic())!
    
    
    }






}





