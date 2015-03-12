/*
 ▖▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▚
 ▞ ofxAVSpeechSynthesizer.h                                 ▚
 ▞──────────────────────┐  project : ofxAVSpeechSynthesizer ▚
 ▞ github.com/azuremous └─────────────────────────────────▶ ▚
 ▞ Created by Jung un Kim a.k.a azuremous on 3/12/15.       ▚
 ▞▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▘
 ----------------------------------------------------------*/

#pragma once

#import <AVFoundation/AVFoundation.h>
#include "ofMain.h"

@interface speechSynthesizerDelegate : UIViewController<AVSpeechSynthesizerDelegate>
{
    AVSpeechSynthesizer* speechSynthesizer;
}
- (id)init;
- (void)play:(NSString*)text setRate:(float)rate setPitch:(float)pitch;
- (void)pause;
- (void)stop;

@end

class ofxAVSpeechSynthesizer {
private:
    speechSynthesizerDelegate* tts;

public:
    ofxAVSpeechSynthesizer();
    void play(wstring text, float rate = 0.1, float pitch = 1.0);
    void pause();
    void stop();
};
