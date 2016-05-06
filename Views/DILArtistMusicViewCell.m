//
//  DILArtistMusicViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DILArtistMusicViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <PureLayout/PureLayout.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "ParseUI.h"

@interface DILArtistMusicViewCell()
@property (strong, nonatomic) UIButton *spotifyBtn;
@property (strong, nonatomic) UIButton *tidalBtn;
@property (strong, nonatomic) UIButton *aplBtn;
@property (strong, nonatomic) UIButton *soundcloudBtn;
@property (strong, nonatomic) UIButton *youtubeBtn;
@property (strong, nonatomic) NSString *mainSpotifyUrl;
@property (strong, nonatomic) NSString *mainTidalUrl;
@property (strong, nonatomic) NSString *aplUrl;
@property (strong, nonatomic) NSString *mainSoundcloudUrl;
@property (strong, nonatomic) NSString *youtubeUrl;
@property (strong, nonatomic) NSString *safeSpotifyUrl;
@property (strong, nonatomic) NSString *safeTidalUrl;
@property (strong, nonatomic) NSString *safeSoundcloudUrl;
@property (strong, nonatomic) UIView *btnView;
//google play
@end

@implementation DILArtistMusicViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    CGFloat icon_dim = self.contentView.frame.size.width/4;
    
    [self.contentView addSubview:self.spotifyBtn];
    [_spotifyBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [_spotifyBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0];
    [_spotifyBtn autoSetDimensionsToSize:CGSizeMake(icon_dim, icon_dim)];

    [self.contentView addSubview:self.aplBtn];
    [_aplBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [_aplBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_aplBtn autoSetDimensionsToSize:CGSizeMake(icon_dim, icon_dim)];
    
    [self.contentView addSubview:self.youtubeBtn];
    [_youtubeBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [_youtubeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0];
    [_youtubeBtn autoSetDimensionsToSize:CGSizeMake(icon_dim, icon_dim)];
    
    
    [self.contentView addSubview:self.soundcloudBtn];
    [_soundcloudBtn autoSetDimensionsToSize:CGSizeMake(icon_dim, icon_dim)];
    [_soundcloudBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_spotifyBtn];
    [_soundcloudBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(icon_dim*.75)];


    [self.contentView addSubview:self.tidalBtn];
    [_tidalBtn autoSetDimensionsToSize:CGSizeMake(icon_dim, icon_dim)];
    [_tidalBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_youtubeBtn];
    [_tidalBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:(icon_dim*.75)];
 }

//- (UIButton *)spotifyBtn {
//    if (!_spotifyBtn) {
//        _spotifyBtn = [[UIButton alloc] initForAutoLayout];
//        UIImage *btnImage = [UIImage imageNamed:@"spotify"];
//        if ([self.mainSpotifyUrl isEqual: @"spotify://artist/"]) {
//            [_spotifyBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
//            [self.spotifyBtn addTarget:self action:@selector(openSpotify:) forControlEvents:UIControlEventTouchUpInside];
//        } else {
//            UIImage *greyBtnImage = [self convertToGreyscale:btnImage];
//            [_spotifyBtn setBackgroundImage:greyBtnImage forState:UIControlStateNormal];
//        }
//    }
//    _spotifyBtn.userInteractionEnabled = YES;
//    return _spotifyBtn;
//}

- (UIButton *)spotifyBtn {
    if (!_spotifyBtn) {
        _spotifyBtn = [[UIButton alloc] initForAutoLayout];
        UIImage *btnImage = [UIImage imageNamed:@"spotify"];;
        [_spotifyBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [self.spotifyBtn addTarget:self action:@selector(openSpotify:) forControlEvents:UIControlEventTouchUpInside];
    }
    _spotifyBtn.userInteractionEnabled = YES;
    return _spotifyBtn;
}

- (UIButton *)tidalBtn {
    if (!_tidalBtn) {
        _tidalBtn = [[UIButton alloc] initForAutoLayout];
        UIImage *btnImage = [UIImage imageNamed:@"tidal"];
        [_tidalBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        _tidalBtn.frame = CGRectMake(200, 25, 150, 75);
        [self.tidalBtn addTarget:self action:@selector(openTidal:) forControlEvents:UIControlEventTouchUpInside];
    }
    _tidalBtn.userInteractionEnabled = YES;
    return _tidalBtn;
}

- (UIButton *)aplBtn {
    if (!_aplBtn) {
        _aplBtn = [[UIButton alloc] initForAutoLayout];
        UIImage *btnImage = [UIImage imageNamed:@"applemusic"];
        [_aplBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        _aplBtn.frame = CGRectMake(10, 150, 150, 75);
        [self.aplBtn addTarget:self action:@selector(openApl:) forControlEvents:UIControlEventTouchUpInside];
    }
    _aplBtn.userInteractionEnabled = YES;
    return _aplBtn;
}

- (UIButton *)soundcloudBtn {
    if (!_soundcloudBtn) {
        _soundcloudBtn = [[UIButton alloc] initForAutoLayout];
        UIImage *btnImage = [UIImage imageNamed:@"soundcloud"];
        [_soundcloudBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        _soundcloudBtn.frame = CGRectMake(200, 150, 150, 75);
        [self.soundcloudBtn addTarget:self action:@selector(openSoundcloud:) forControlEvents:UIControlEventTouchUpInside];
    }
    _soundcloudBtn.userInteractionEnabled = YES;
    return _soundcloudBtn;
}

- (UIButton *)youtubeBtn {
    if (!_youtubeBtn) {
        _youtubeBtn = [[UIButton alloc] initForAutoLayout];
        UIImage *btnImage = [UIImage imageNamed:@"youtube"];
        [_youtubeBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        _youtubeBtn.frame = CGRectMake(10, 225, 150, 75);
        [self.youtubeBtn addTarget:self action:@selector(openYoutube:) forControlEvents:UIControlEventTouchUpInside];
    }
    _youtubeBtn.userInteractionEnabled = YES;
    return _youtubeBtn;
}

- (UIImage *) convertToGreyscale:(UIImage *)i {
    
    int kRed = 1;
    int kGreen = 2;
    int kBlue = 4;
    
    int colors = kGreen | kBlue | kRed;
    int m_width = i.size.width;
    int m_height = i.size.height;
    
    uint32_t *rgbImage = (uint32_t *) malloc(m_width * m_height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImage, m_width, m_height, 8, m_width * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, m_width, m_height), [i CGImage]);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // now convert to grayscale
    uint8_t *m_imageData = (uint8_t *) malloc(m_width * m_height);
    for(int y = 0; y < m_height; y++) {
        for(int x = 0; x < m_width; x++) {
            uint32_t rgbPixel=rgbImage[y*m_width+x];
            uint32_t sum=0,count=0;
            if (colors & kRed) {sum += (rgbPixel>>24)&255; count++;}
            if (colors & kGreen) {sum += (rgbPixel>>16)&255; count++;}
            if (colors & kBlue) {sum += (rgbPixel>>8)&255; count++;}
            m_imageData[y*m_width+x]=sum/count;
        }
    }
    free(rgbImage);
    
    // convert from a gray scale image back into a UIImage
    uint8_t *result = (uint8_t *) calloc(m_width * m_height *sizeof(uint32_t), 1);
    
    // process the image back to rgb
    for(int i = 0; i < m_height * m_width; i++) {
        result[i*4]=0;
        int val=m_imageData[i];
        result[i*4+1]=val;
        result[i*4+2]=val;
        result[i*4+3]=val;
    }
    
    // create a UIImage
    colorSpace = CGColorSpaceCreateDeviceRGB();
    context = CGBitmapContextCreate(result, m_width, m_height, 8, m_width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    
    free(m_imageData);
    
    // make sure the data will be released by giving it to an autoreleased NSData
    [NSData dataWithBytesNoCopy:result length:m_width * m_height];
    
    return resultUIImage;
}

//- (void)configureCellWithArtist:(DILPFArtist *)artist{
//    self.spotifyUrl = [@"http://open.spotify.com/artist/" stringByAppendingString:artist.spotifyUrl];
//    self.tidalUrl = [@"http://tidal.com/artist/" stringByAppendingString:artist.tidalUrl];
//    self.aplUrl = [@"https://itun.es/us/" stringByAppendingString:artist.aplUrl]; // opens safari
//    self.soundcloudUrl = [@"https://soundcloud.com/" stringByAppendingString:artist.soundcloudUrl];
//    self.youtubeUrl = [@"https://www.youtube.com/user/" stringByAppendingString:artist.youtubeUrl];
//}

- (void)configureCellWithArtist:(DILPFArtist *)artist{
    self.mainSpotifyUrl = [@"spotify://artist/" stringByAppendingString:artist.spotifyUrl];
    self.mainTidalUrl = [@"tidal://artist/" stringByAppendingString:artist.tidalUrl];
    self.aplUrl = [@"https://itun.es/us/" stringByAppendingString:artist.aplUrl]; // opens safari
    self.mainSoundcloudUrl = [@"soundcloud:users:" stringByAppendingString:artist.soundcloudUrl];
    self.youtubeUrl = [@"https://www.youtube.com/user/" stringByAppendingString:artist.youtubeUrl];
    
    self.safeSpotifyUrl = [@"http://open.spotify.com/artist/" stringByAppendingString:artist.spotifyUrl];
    self.safeTidalUrl = [@"http://tidal.com/artist/" stringByAppendingString:artist.tidalUrl];
    self.safeSoundcloudUrl = [@"https://soundcloud.com/" stringByAppendingString:artist.soundcloudUsername];
}

- (void)openSpotify:(id)sender {
    if ([self.mainSpotifyUrl isEqualToString:@"spotify://artist/"]) {
        [SVProgressHUD showInfoWithStatus:@"Artist not available on Spotify"];
        return;
    }
    UIApplication *myApp = UIApplication.sharedApplication;
    NSURL *realSpotifyUrl = [NSURL URLWithString: self.mainSpotifyUrl];
    NSURL *fakeSpotifyUrl = [NSURL URLWithString: self.safeSpotifyUrl];
    if ([myApp canOpenURL:realSpotifyUrl]) {
        [myApp openURL:realSpotifyUrl];
    } else {
        [myApp openURL:fakeSpotifyUrl];
    }
}

- (void)openTidal:(id)sender {
    if ([self.mainTidalUrl isEqualToString:@"tidal://artist/"]) {
        [SVProgressHUD showInfoWithStatus:@"Artist not available on Tidal"];
        return;
    }
    UIApplication *myApp = UIApplication.sharedApplication;
    NSURL *realTidalUrl = [NSURL URLWithString: self.mainTidalUrl];
    NSURL *fakeTidalUrl = [NSURL URLWithString: self.safeTidalUrl];
    if ([myApp canOpenURL:realTidalUrl]) {
        [myApp openURL:realTidalUrl];
    } else {
        [myApp openURL:fakeTidalUrl];
    }
}

- (void)openApl:(id)sender {
    if ([self.aplUrl isEqualToString:@"https://itun.es/us/"]) {
        [SVProgressHUD showInfoWithStatus:@"Artist not available on iTunes"];
        return;
    }
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: self.aplUrl]];
}

- (void)openSoundcloud:(id)sender {
    if ([self.mainSoundcloudUrl isEqualToString:@"soundcloud:users:"]) {
        [SVProgressHUD showInfoWithStatus:@"Artist not available on Soundcloud"];
        return;
    }
    UIApplication *myApp = UIApplication.sharedApplication;
    NSURL *realSoundcloudUrl = [NSURL URLWithString: self.mainSoundcloudUrl];
    NSURL *fakeSoundcloudUrl = [NSURL URLWithString: self.safeSoundcloudUrl];
    if ([myApp canOpenURL:realSoundcloudUrl]) {
        [myApp openURL:realSoundcloudUrl];
    } else {
        [myApp openURL:fakeSoundcloudUrl];
    }
}

- (void)openYoutube:(id)sender {
    if ([self.youtubeUrl isEqualToString:@"https://www.youtube.com/user/"]) {
        [SVProgressHUD showInfoWithStatus:@"Artist not available on Youtube"];
        return;
    }
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: self.youtubeUrl]];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}
@end
