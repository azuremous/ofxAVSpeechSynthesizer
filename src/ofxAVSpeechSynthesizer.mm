/*
 ▖▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▘▚
 ▞ ofxAVSpeechSynthesizer.mm                                ▚
 ▞──────────────────────┐  project : ofxAVSpeechSynthesizer ▚
 ▞ github.com/azuremous └─────────────────────────────────▶ ▚
 ▞ Created by Jung un Kim a.k.a azuremous on 3/12/15.       ▚
 ▞▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▖▘
 ----------------------------------------------------------*/

#include "ofxAVSpeechSynthesizer.h"

@implementation speechSynthesizerDelegate

- (id)init{
    speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    speechSynthesizer.delegate = self;
    return self;
}

- (void)dealloc{
    [super dealloc];
}

- (void)play:(NSString *)text setRate:(float)rate setPitch:(float)pitch{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    utterance.rate = rate;
    utterance.pitchMultiplier = pitch;
    AVSpeechSynthesisVoice* currentVoice = [AVSpeechSynthesisVoice voiceWithLanguage:[AVSpeechSynthesisVoice currentLanguageCode]];
    utterance.voice =currentVoice;
    //utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    
    [speechSynthesizer speakUtterance:utterance];
}

- (void)pause{
    if( speechSynthesizer.paused){ [speechSynthesizer continueSpeaking]; }
    else{ [speechSynthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate]; }
}

- (void)stop{
    [speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    ofSendMessage("start");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    ofSendMessage("finish");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
    ofSendMessage("pause");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
    ofSendMessage("continue");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    ofSendMessage("cancle");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    NSString* currentText = [utterance.speechString substringWithRange:characterRange];
    const char * _value = [currentText UTF8String];
    ofSendMessage(_value);
}

@end


ofxAVSpeechSynthesizer::ofxAVSpeechSynthesizer()
{
    tts = [[speechSynthesizerDelegate alloc] init];
}

void ofxAVSpeechSynthesizer::play(wstring text, float rate, float pitch){
    NSString * speakingText = [[NSString alloc] initWithBytes:text.data()
                                                length:text.size() * sizeof(wchar_t)
                                              encoding:NSUTF32LittleEndianStringEncoding];
    //NSLog(@"set text: %@", speakingText);
    [tts play:speakingText setRate:rate setPitch:pitch];
}

void ofxAVSpeechSynthesizer::pause(){ [tts pause]; }

void ofxAVSpeechSynthesizer::stop(){ [tts stop]; }