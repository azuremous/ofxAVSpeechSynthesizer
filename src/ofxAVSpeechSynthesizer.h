/*-----------------------------------------------------------/
 ofxAVSpeechSynthesizer.h
 github.com/azuremous
 Created by Jung un Kim a.k.a azuremous on 3/12/15.
/----------------------------------------------------------*/

#pragma once

#import <AVFoundation/AVFoundation.h>
#include "ofMain.h"

@interface speechSynthesizerDelegate : UIViewController<AVSpeechSynthesizerDelegate>
{
    AVSpeechSynthesizer* speechSynthesizer;
    NSArray * voice;
    
}

@property(readonly)bool isPlaying;

- (id)init;
- (void)play:(NSString*)text setRate:(float)rate setPitch:(float)pitch setVoice:(NSString*)voiceID;
- (void)pause;
- (void)stop;
- (bool)getIsPlaying;

@end

class ofxAVSpeechSynthesizer {
private:
    speechSynthesizerDelegate* tts;

public:
    ofxAVSpeechSynthesizer();
    void play(wstring text, float rate = 0.1, float pitch = 1.0, int num = 0);
    void pause();
    void stop();
    bool getIsPlaying();
};
