//
//  MyAudioFile.swift
//  AudioFileCreateSample
//
//  Created by pebble8888 on 2017/01/21.
//  Copyright © 2017年 pebble8888. All rights reserved.
//

import Foundation
import AVFoundation
import AudioToolbox

class MyAudioFile 
{
    init() {
    }
    
    func execute(){
        if let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let path = documentsPath.appending("/test.wav")
            let format:AVAudioFormat = AVAudioFormat(commonFormat: AVAudioCommonFormat.pcmFormatInt16,
                                                     sampleRate: 44100,
                                                     channels: 2,
                                                     interleaved: true)
            if let url = URL(string:path) {
                do {
                    // WAVファイルのフォーマットを指定する
                    let file:AVAudioFile = try AVAudioFile(forWriting: url,
                                                       settings: format.settings, 
                                                       commonFormat: format.commonFormat,
                                                       interleaved: true)
                    // データ書き込みフォーマットを指定する 
                    // ここではWAVファイルと同じフォーマットを使う
                    let buffer:AVAudioPCMBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: 1024)
                    if let p:UnsafePointer<UnsafeMutablePointer<Int16>> = buffer.int16ChannelData {
                        let q:UnsafeMutablePointer<Int16> = p.pointee
                        var x:Float = 0
                        var y:Float = 0
                        let delta_x:Float = Float(440 * 2 * M_PI / 44100) // ラ(440Hz)
                        let delta_y:Float = Float(523 * 2 * M_PI / 44100) // ド(523Hz)
                        for i:Int in stride(from:0, to:1024*2, by: 2) {
                            q[i]   = Int16(sin(x) * 32767.0) // L
                            q[i+1] = Int16(sin(y) * 32767.0) // R
                            x += delta_x
                            y += delta_y
                        }
                    } else {
                        assert(false)
                    }
                    // メモリに書き込んだサンプル数をセット
                    buffer.frameLength = 1024
                    // WAVファイルへ書き込み
                    try file.write(from: buffer)
                } catch {
                    assert(false)
                }
            }
        }
    }
}
