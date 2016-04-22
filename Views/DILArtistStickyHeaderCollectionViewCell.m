
//  DILArtistStickyHeaderCollectionViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/2/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DILArtistStickyHeaderCollectionViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import <Spotify/Spotify.h>
#import <CSStickyHeaderFlowLayout/CSStickyHeaderFlowLayoutAttributes.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSDate+Utilities.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import <QuartzCore/QuartzCore.h>

@interface DILArtistStickyHeaderCollectionViewCell()
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) UILabel *timeLabel;
//@property (strong, nonatomic) UIButton *circularImageView;
@property (strong, nonatomic) UILabel *circleLabel;
@property (strong, nonatomic) HMSegmentedControl *segmentedControl;
@property (strong, nonatomic) NSMutableArray *circularImageViewLayoutConstraints;
@property (strong, nonatomic) UIView *backgroundImageViewTintView;
@property (strong, nonatomic) NSString *previewUrl;
@property (strong, nonatomic) AVPlayer *audioPlayer;
@end

static NSString *const kSegmentedControlBio     = @"BIO";
static NSString *const kSegmentedControlMusic   = @"MUSIC";
BOOL musicPlaying = NO;

@implementation DILArtistStickyHeaderCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.circularImageViewLayoutConstraints = [NSMutableArray new];
        [self configureCell];
    }
    return self;
}

- (void)configureCell {    
    self.clipsToBounds = YES;
    [self addSubview:self.backgroundImageView];
    [self.backgroundImageView addSubview:self.backgroundImageViewTintView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.segmentedControl];
    [self.backgroundImageView addSubview:self.circularImageView];
    
    self.previewUrl = @"";

    [self.backgroundImageViewTintView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    [self.segmentedControl autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    CGFloat segmentedControlHeight = kDILArtistStickyHeaderCollectionViewSegmentedControlHeight;
    [self.segmentedControl autoSetDimension:ALDimensionHeight toSize:segmentedControlHeight];

    [self.backgroundImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.backgroundImageView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.segmentedControl];
    
    [self addCircularImageView];
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    
    CGFloat timeLabelInset = 10;
    [self.timeLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.backgroundImageView withOffset:-timeLabelInset];
    [self.timeLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.backgroundImageView withOffset:-timeLabelInset];
}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    if ([touch view] == _circularImageView) {
//        NSLog(@"touch");
//    }
//    else if ([touch view] == nil) {
//        NSLog(@"check");
//    }
//    else {
//        UIView *tview = [touch view];
//        NSLog(@"%@", tview.description);
//    }
//}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initForAutoLayout];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView.clipsToBounds = YES;
        _backgroundImageView.userInteractionEnabled = YES;
    }
    return _backgroundImageView;
}

- (UIButton *)circularImageView {
    if (!_circularImageView) {
        _circularImageView = [[UIButton alloc] initForAutoLayout];
        //_circularImageView.contentMode = UIViewContentModeScaleAspectFill;
        _circularImageView.clipsToBounds = YES;
        _circularImageView.layer.shadowOpacity = 1;
        _circularImageView.layer.shadowOffset = CGSizeZero;
        _circularImageView.layer.shadowRadius = 10;
        _circleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _circularImageView.frame.size.height, _circularImageView.frame.size.width)];
        _circleLabel.text = @"\u25B6";
        _circleLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
        _circleLabel.font = [UIFont systemFontOfSize:80];
        [_circularImageView addSubview:_circleLabel];
        [self.circleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.circularImageView];
        [self.circleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.circularImageView];
        
        [RACObserve(self, circularImageView.bounds) subscribeNext:^(NSNumber *bounds) {
            CGRect imageViewBounds = bounds.CGRectValue;
            _circularImageView.layer.cornerRadius = CGRectGetHeight(imageViewBounds)/2.0;
        }];
        
    }
    return _circularImageView;
}

- (void)removeCircularImageView {
    if (_circularImageView) {
        [self.circularImageView removeFromSuperview];
        _circularImageView = nil;
    }
}

- (void)addCircularImageView {
    [self.circularImageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.backgroundImageView];
    [self.circularImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.backgroundImageView];

    CGFloat inset = 60;
    [self.circularImageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.backgroundImageView withOffset:-inset];
    [self.circularImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.circularImageView];
//    [self.circularImageView addTarget:self action:@selector(controlTrack1:) forControlEvents:UIControlEventTouchUpInside];
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initForAutoLayout];
    }
    return _timeLabel;
}


- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[kSegmentedControlBio, kSegmentedControlMusic]];
        _segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsZero;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentedControl.backgroundColor = [DilloDayStyleKit artistInfoSegmentedControlBackgroundColor];
        _segmentedControl.selectionIndicatorColor = [DilloDayStyleKit artistInfoSegmentedControlSelectedSegmentIndicatorColor];
        [_segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            NSAttributedString *formattedTitleString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [DilloDayStyleKit artistInfoSegmentedControlTextColor], NSFontAttributeName : [UIFont boldFlatFontOfSize:18]}];
            return formattedTitleString;
        }];
        [_segmentedControl addTarget:self action:@selector(handleSegmentedControlChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (void)handleSegmentedControlChange:(HMSegmentedControl *)sender {
    DILArtistInfoType type;
    NSString *selectedTitle = sender.sectionTitles[sender.selectedSegmentIndex];
    if ([selectedTitle isEqualToString:kSegmentedControlBio]) {
        type = DILArtistInfoTypeBio;
    } else if ([selectedTitle isEqualToString:kSegmentedControlMusic]) {
        type = DILArtistInfoTypeMusic;
    }
    [self.delegate displayArtistInfoType:type];
}

- (UIView *)backgroundImageViewTintView {
    if (!_backgroundImageViewTintView) {
        _backgroundImageViewTintView = [[UIView alloc] initForAutoLayout];
        _backgroundImageViewTintView.backgroundColor = [UIColor blackColor];
        _backgroundImageViewTintView.alpha = 0.20;
    }
    return _backgroundImageViewTintView;
}

- (void)controlTrack1:(id)sender {
    if (musicPlaying == NO) {
        musicPlaying = YES;
        [_audioPlayer play];
        _circleLabel.text = @"   \u258D\u258D";
        _circleLabel.font = [UIFont systemFontOfSize:35];
        _circleLabel.textAlignment = NSTextAlignmentRight;
    } else {
        musicPlaying = NO;
        [_audioPlayer pause];
        _circleLabel.text = @"\u25B6";
        _circleLabel.textAlignment = NSTextAlignmentRight;
        _circleLabel.font = [UIFont systemFontOfSize:80];
    }
}

- (void)initTrack {
    NSURL *urlStream = [[NSURL alloc] initWithString:self.previewUrl];
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:urlStream options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:avAsset];
    _audioPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    _audioPlayer = [AVPlayer playerWithURL:urlStream];
}

- (void)applyLayoutAttributes:(CSStickyHeaderFlowLayoutAttributes *)layoutAttributes {


}

#pragma mark - Public Methods
- (void)configureCellWithArtist:(DILPFArtist *)artist {
    [artist imageDownloadPromise].then(^(UIImage *image){
        self.backgroundImageView.image = image;
        self.previewUrl = [@"https://p.scdn.co/mp3-preview/" stringByAppendingString:artist.previewUrl];
        [self initTrack];
        [_circularImageView addTarget:self action:@selector(controlTrack1:) forControlEvents:UIControlEventTouchUpInside];
    });
    
   // [self addCircularImageView];


    self.circularImageView.alpha = 0;
    [artist iconImageDownloadPromise].then(^(UIImage *image){
        [_circularImageView setBackgroundImage:image forState:UIControlStateNormal];
        //_circularImageView.image = image;
        //UIImage *btnImage = image;
        //[_circularImageView setImage:btnImage forState:UIControlStateNormal];
        self.circularImageView.alpha = 1;
    });

//    self.timeLabel.text = [artist.performanceTime mediumTimeString];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
