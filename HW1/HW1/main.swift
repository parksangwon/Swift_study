//  TODO: Write some awesome Swift code, or import libraries like "Foundation",
//  "Dispatch", or "Glibc"

//
//  main.swift
//  HW1
//
//  Created by SDT1 on 2016. 5. 25..
//  Copyright © 2016년 SDT1. All rights reserved.
//

import Foundation

protocol Playable { // Playable Protocol
    func play() // 재생 기능 정의
}

class Music : Playable { // Playable 채택
    var title : NSString // 검색을 위해 NSString 타입 선언
    var artist : NSString
    var playTimes : Int
    
    init() { // init
        self.title = "무제"
        self.artist = "Various Artists"
        playTimes = 0 // default값
    }
    
    convenience init(title : NSString, artist : NSString) { // convenience init
        self.init()
        self.title = title
        self.artist = artist // 입력 받은 title과 artist값 대입
    }
    
    func getInfo() { // 검색 결과 출력할 때 사용하기 위해 클래스 프로퍼티 출력하는 method 작성
        print("---------------------------")
        print("title : \(self.title)")
        print("artist : \(self.artist)")
        print("playtimes : \(self.playTimes)")
        print("---------------------------")
    }
    
    private func increasePlayTimes() { // playTimes를 증가시킴
        playTimes += 1
    }
    
    func play() { // Playable.play() 구현
        self.increasePlayTimes() // playTimes 증가
        print("---------------------------")
        print("title : \(self.title)")
        print("artist : \(self.artist)")
        print("---------------------------") // 재생 정보 출력
    }
}

// 1. 음악
print("1. 음악")

let music1 = Music()
music1.title = "벚꽃 엔딩"
music1.artist = "버스커 버스커"
music1.play()
let music2 = Music(title: "위 아래", artist: "EXID")
music2.play()
music2.play()
let music3 = Music()
music3.title = "좋은 날"
music3.artist = "IU"
music3.play()

// end 음악과제

class PlayList : Playable { // Playable protocol 채택
    var title : NSString
    var musicList : [Music] // Music을 배열로 관리
    
    init() { // init
        let todaysDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateInFormat = dateFormatter.stringFromDate(todaysDate)
        self.title = dateInFormat // 초기 값으로 오늘 날짜를 타이틀로 지정
        musicList = Array<Music>() // 빈 배열 할당
    }
    
    convenience init(title : String) { // convenience init
        self.init()
        self.title = title // 입력된 title로 대입
    }
    // 음악 재생
    func play() {
        print("\n\(title) 플레이 리스트 재생") // 플레이 리스트 타이틀을 출력하고
        for music in musicList { // 모든 음악을 재생
            music.play()
        }
    }
    // 음악 검색
    func search(word : String) -> Array<Music> { // 단어를 포함하는 모든 음악을 배열로 리턴
        var cnt = 0; // search count
        var resultArr = Array<Music>() // 검색 결과 배열
        
        print("\n'\(word)'으로 검색한 결과")
        
        for music in musicList { // 이 플레이 리스트의 모든 음악에 대해서
            let range : NSRange = music.title.rangeOfString(word) // Music.title에 word가 포함되는 범위를 찾고
            if range.location != NSNotFound { // 찾았으면
                cnt += 1 // 검색 결과 수를 올리고
                resultArr.append(music) // 검색 결과 배열에 추가
            }
        }
        
        print(cnt, "건") // 검색 건 수 출력
        
        return resultArr
    }
    // 음악 추가
    func addMusic(music : Music) { // 넘겨받은 Music을 musicList에 추가
        musicList.append(music)
    }
    // 음악 삭제
    func deleteMusic(title : NSString) { // title이 일치하는 Music을 제거
        var index = 0 // index
        for music in musicList { // 플레이 리스트의 모든 음악에 대해서
            if music.title == title { // Music.title과 title이 같으면
                //musicList.remove(at : index) // swift 3.x
                musicList.removeAtIndex(index) // 해당 인덱스의 음악을 삭제한다.
                print("\n'\(music.title)'이(가) \(self.title) 플레이 리스트에서 삭제 되었습니다.")
            }
            index += 1 // index increase
        }
    }
}

// 2. 음악과 앨범
print("2. 음악과 앨범")

// 추가
let music4 = Music(title : "봄이 좋냐", artist : "10cm")
let music6 = Music(title : "안아줘", artist : "정준일")

let playListBallad = PlayList()
playListBallad.addMusic(music4)
playListBallad.addMusic(music6)

let music5 = Music(title : "우아해", artist : "CRUSH")
let music7 = Music(title : "사랑이었다", artist : "Zico")
let music8 = Music(title : "우리 사랑하지말아요", artist : "BIGBANG")

let playListHipHop = PlayList(title : "힙합")
playListHipHop.addMusic(music5)
playListHipHop.addMusic(music7)
playListHipHop.addMusic(music8)



// 재생
playListBallad.play()
playListHipHop.play()

// 검색
let result = playListHipHop.search("사랑")
for m in result {
    m.getInfo()
}

let result2 = playListHipHop.search("안해")
for m in result2 {
    m.getInfo()
}

// 제거
playListBallad.deleteMusic("봄이 좋냐")
playListBallad.play() // 삭제된 결과를 보기 위한 코드

// end 음악과 앨범