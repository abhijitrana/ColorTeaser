//
//  Settings.swift
//  AmazingThiefBlueprint
//
//  Created by Alex Nagy on 16/11/2016.
//  Copyright © 2016 Rebeloper. All rights reserved.
//

import SpriteKit

//------- In-App Purchases -------//

// IMPORTANT: Remember to modify these in the MKStoreKitConfigs.plist file too!!!
// You will be able to edit the amount of coins the user will get for the IAP

let InAppPurchaseID1 = "com.abhijit.colordefence.no_ad" // non-consumable with suggested price $0.99

//------- Chartboost IDs -------//

let chartboostAppID = "5401fcfbc26ee42e8d2affd6"
let chartboostAppSignature = "65703bb555f73d99ba64ab74739894d79b896cd2"

//Admob

let admob_full_ad = "ca-app-pub-7621766805955606/4326575379"

let showMoreAppsButton = true

let showAdsOnGameplay = true
let showAdsOnGameOver = true

//------- Leaderboard ID -------//

//let leaderboardID = "com.Rebeloper.AmazingThiefBlueprint.Scores"
let leaderboardID = "com.abhijit.colordefence.leaderboard"
//------- App ID -------//

let appID = "1234755860"

//------- Log Fonts -------//

let logAllAvailableFonts = false

//------- Custom Font Name -------//
// To find out the actual name of your custom font:
// 1. Set 'logAllAvailableFonts' to 'true'
// 2. Run the app
// 3. Find the Font Name in the Log
// 4. Copy it here

let FontName = "Komika Axis"

// IMPORTANT: You will also need to add the font FILE NAME into your Info.plist file under 'Fonts provided by application'

//------- Custom Font Size -------//

let FontSize = 160

//------- Custom Font Color -------//

let FontColor = SKColor.white

//------- Score Line Color -------//

let ScoreLineColor = SKColor.clear

//------- Music & Sounds File Names -------//

let backgroundMusicName = "BackgroundMusic"
let backgroundMusicExtension = "mp3"
let hitSoundFile = "hit.wav"
let scoreSoundFile = "score.wav"
let woshSoundFile = "wosh.wav"
let tapSoundFile = "tap.wav"

//------- Rate Popup -------//

let rateAlertTitle = "Rate the app"
let rateAlertMessagePart1 = "If you found"

// IMPORTANT: Next comes the name of the App that will be fetched by code from the Info.plist file; please go and set it up at the 'Bundle Display Name' now!!!

let rateAlertMessagePart2 = "useful, please take a moment to rate it"
let rateAlertOKTitle = "Rate it now"
let rateAlertCancelTitle = "Don't bother me again"
let rateAlertRemindLaterTitle = "Remind me later"
let rateAlertPromptAfterDays = 1.0 // Ex. '1.5' means one and a half days
let rateAlertPromptAfterUses = 3
let rateAlertDaysBeforeReminding = 1.0

//------- Share Text Score -------//

// text that will be displayed when user taps on "Share"
let ShareScoreTextFirstPart = "Wow! I have Scored "
let ShareScoreTextSecondPart = " Points so far in 'Color Defence'!!! Download it from the App Store now!"

//------- Gameplay Speed -------//

// set the gameplay speed by choosing a float between 0.5 and 3.5

let gameplaySpeed = 2.0
