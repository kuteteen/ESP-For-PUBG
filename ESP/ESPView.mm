#import "EEEEE.h"
#import "EEE.h"
#import "defs.h"
#import "Gobal.h"
#import <CoreText/CoreText.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIAlertView.h>
//#import "menuButtonConfig.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#import <WebKit/WebKit.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <AVFoundation/AVFoundation.h>
#import <AdSupport/ASIdentifierManager.h>
#import "CaptainHook.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIAlertView.h>
#import <UIKit/UIControl.h>
#import <Foundation/Foundation.h>

//#import "NCURLProtocol.h"
//#import "NCSessionConfiguration.h"

#define kTest   0
#define g 0.86602540378444
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height



//123

@interface gjbnb ()
@property (nonatomic,  strong) UILabel *numberLabel;
@property (nonatomic,  strong) CAShapeLayer *drawLayer;
@property (nonatomic,  strong) CAShapeLayer *hpLayer;
@property (nonatomic,  strong) CAShapeLayer *beijing;
@property (nonatomic,  strong) CAShapeLayer *beijinga;
@property (nonatomic,  strong) CAShapeLayer *beijingb;
@property (nonatomic,  strong) CAShapeLayer *beijingc;
@property (nonatomic,  strong) CAShapeLayer *beijingd;
@property (nonatomic,  strong) CAShapeLayer *beijinge;
@property (nonatomic,  strong) CAShapeLayer *disLayer;
@property (nonatomic,  strong) CAShapeLayer *renji;
@property (nonatomic,  strong) NSArray *rects;
@property (nonatomic,  strong) NSArray *aiData;
@property (nonatomic,  strong) NSArray *hpData;
@property (nonatomic,  strong) NSArray *disData;
@property (nonatomic,  strong) NSArray *nameData;
@property (nonatomic,  strong) NSArray *data1;
@property (nonatomic,  strong) NSArray *data2;
@property (nonatomic,  strong) NSArray *data3;
@property (nonatomic,  strong) NSArray *data4;
@property (nonatomic,  strong) NSArray *data5;
@property (nonatomic,  strong) NSArray *data6;
@property (nonatomic,  strong) NSArray *data7;
@property (nonatomic,  strong) NSArray *data8;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *yanshe;
@property (nonatomic,  weak) NSTimer *timer;
@end
static UILabel *label[100];
static CATextLayer * mzLabel[100];
static CATextLayer * po[100];
static CATextLayer * poo[100];
static CATextLayer * pooo[100];
static CAShapeLayer *drawLayer[100];
static CAShapeLayer *wjLayer[100];
NSMutableDictionary *newActions;
static UIBezierPath *Path[100];
static UIBezierPath *wjPath[100];
static UIBezierPath *beijing[100];
static UIBezierPath *beijinga[100];
static UIBezierPath *beijingb[100];
static UIBezierPath *beijingc[100];
static UIBezierPath *beijingd[100];
//static CAShapeLayer *hpLayer[100];//名字+距离
//static CATextLayer *xue[100]
CGRect rect ;
CGFloat xue;
CGFloat dis ;
BOOL kaiguan = NO;
BOOL kaiguan1 = YES;
BOOL kaiguan2 = YES;
BOOL kaiguan3 = YES;
BOOL kaiguan4 = YES;
BOOL kaiguan5 = YES;
BOOL kaiguan6 = YES;



@implementation gjbnb
#pragma mark -------------------------------------视图-------------------------------------------

+ (void)load

{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        gjbnb *view = [gjbnb gjb];
        [view show];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:view];
    });
}


+ (instancetype)gjb
{
    return [[gjbnb alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame
{
        self = [super initWithFrame:frame];
        if (self) {
            self.userInteractionEnabled = NO;
            [self.layer addSublayer:self.drawLayer];
            [self.layer addSublayer:self.hpLayer];
            [self.layer addSublayer:self.disLayer];
            [self.layer addSublayer:self.renji];
            [self.layer addSublayer:self.beijing];
            [self.layer addSublayer:self.beijinga];
            [self.layer addSublayer:self.beijingb];
            [self.layer addSublayer:self.beijingc];
            [self.layer addSublayer:self.beijingd];
            [self.layer addSublayer:self.beijinge];
            [self addSubview:self.numberLabel];
            
            
            for (NSInteger i = 0; i < 100; i++) {
                
                NSMutableDictionary*newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
                
                //名字+距离
                mzLabel[i] = [CATextLayer layer];
                mzLabel[i].actions = newActions;
                mzLabel[i].string = @"";
                mzLabel[i].bounds = CGRectMake(0, 0, 300, 30);//160
                mzLabel[i].fontSize = 8;//字体的大小
                mzLabel[i].wrapped = YES;//默认为No.  当Yes时，字符串自动适应layer的bounds大小
                mzLabel[i].alignmentMode = kCAAlignmentCenter;//字体的对齐方式
                //mzLabel[i].foregroundColor =[UIColor whiteColor].CGColor;
                mzLabel[i].position = CGPointMake(-100, -100);//layer在view的位置 适用于跟随摸一个不固定长的的控件后面需要的
                mzLabel[i].contentsScale = [UIScreen mainScreen].scale;//解决文字模糊
                [self.layer addSublayer:mzLabel[i]];
                
                NSMutableDictionary*newooo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
                //名字+距离
                po[i] = [CATextLayer layer];
                po[i].actions = newooo;
                po[i].string = @"";
                po[i].bounds = CGRectMake(0, 0, 300, 20);//160
                po[i].fontSize = 8;//字体的大小
                po[i].wrapped = YES;//默认为No.  当Yes时，字符串自动适应layer的bounds大小
                po[i].alignmentMode = kCAAlignmentCenter;//字体的对齐方式
                //mzLabel[i].foregroundColor =[UIColor whiteColor].CGColor;
                po[i].position = CGPointMake(-100, -100);//layer在view的位置 适用于跟随摸一个不固定长的的控件后面需要的
                po[i].contentsScale = [UIScreen mainScreen].scale;//解决文字模糊
                [self.layer addSublayer:po[i]];
                
                NSMutableDictionary*newoooo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
                //名字+距离
                poo[i] = [CATextLayer layer];
                poo[i].actions = newoooo;
                poo[i].string = @"";
                poo[i].bounds = CGRectMake(0, 0, 300, 20);//160
                poo[i].fontSize = 12;//字体的大小
                poo[i].wrapped = YES;//默认为No.  当Yes时，字符串自动适应layer的bounds大小
                poo[i].alignmentMode = kCAAlignmentCenter;//字体的对齐方式
                //mzLabel[i].foregroundColor =[UIColor whiteColor].CGColor;
                poo[i].position = CGPointMake(-100, -100);//layer在view的位置 适用于跟随摸一个不固定长的的控件后面需要的
                poo[i].contentsScale = [UIScreen mainScreen].scale;//解决文字模糊
                [self.layer addSublayer:poo[i]];
                
                NSMutableDictionary*newooooo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
                //名字+距离
                pooo[i] = [CATextLayer layer];
                pooo[i].actions = newooooo;
                pooo[i].string = @"";
                pooo[i].bounds = CGRectMake(0, 0, 300, 20);//160
                pooo[i].fontSize = 5;//字体的大小
                pooo[i].wrapped = YES;//默认为No.  当Yes时，字符串自动适应layer的bounds大小
                pooo[i].alignmentMode = kCAAlignmentCenter;//字体的对齐方式
    //            pooo[i].foregroundColor =[UIColor redColor].CGColor;
                pooo[i].position = CGPointMake(-100, -100);//layer在view的位置 适用于跟随摸一个不固定长的的控件后面需要的
                pooo[i].contentsScale = [UIScreen mainScreen].scale;//解决文字模糊
                [self.layer addSublayer:pooo[i]];
            }
        }
        return self;
}

#pragma mark -------------------------------------事件-------------------------------------------


- (void)clear{
    
    for (NSInteger i = 0; i < 100; i++) {
        
        
        
         mzLabel[i].string = @"";
         po[i].string = @"";
         poo[i].string = @"";
         pooo[i].string = @"";
        
        
    }
    
    
}
- (void)show
{
    self.hidden = NO;
    self.timer.fireDate = [NSDate distantPast];
}


- (void)hide
{
    self.hidden = YES;
    self.timer.fireDate = [NSDate distantFuture];
    
}




- (void)configWithData:(NSArray *)rects hpData:(NSArray *)hpData disData:(NSArray *)disData nameData:(NSArray *)nameData aiData:(NSArray *)aiData data1:(NSArray *)data1  data2:(NSArray *)data2 data3:(NSArray *)data3 data4:(NSArray *)data4 data5:(NSArray *)data5 data6:(NSArray *)data6 data7:(NSArray *)data7 data8:(NSArray *)data8


{
    
    _rects = rects;
    _hpData = hpData;
    _disData = disData;
    _nameData = nameData;
    _aiData = aiData;
    _data1 =  data1;
    _data2 =  data2;
    _data3 =  data3;
    _data4 =  data4;
    _data5 =  data5;
    _data6 =  data6;
    _data7 =  data7;
    _data8 =  data8;
    
    if(kaiguan1==YES){
        if (_rects.count==0)
        {_numberLabel.text =[ NSString stringWithFormat:@"安全"];}
        else
        { _numberLabel.text = @(_rects.count).stringValue;}
        
    }
    
    [self clear];
    [self HHHH];
    
    
}

- (void)HHHH
{
        
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        UIBezierPath *hpPath = [UIBezierPath bezierPath];
        UIBezierPath *disPath = [UIBezierPath bezierPath];
        UIBezierPath *ren = [UIBezierPath bezierPath];
        UIBezierPath *beijingpath = [UIBezierPath bezierPath];
        UIBezierPath *beijingpatha = [UIBezierPath bezierPath];
        UIBezierPath *beijingpathb = [UIBezierPath bezierPath];
        UIBezierPath *beijingpathc = [UIBezierPath bezierPath];
        UIBezierPath *beijingpathd = [UIBezierPath bezierPath];
       UIBezierPath *beijingpathe = [UIBezierPath bezierPath];
        float wanjia =0;
        for (int i = 0; i < _rects.count; i++) {
            
//            NSValue *val0  = _rects[i];
            NSNumber *val1 = _hpData[i];
            NSNumber *val2 = _disData[i];
            NSNumber *val3 = _aiData[i];
            
            NSValue *d1  = _data1[i];
            NSValue *d2  = _data2[i];
            NSValue *d3  = _data3[i];
            NSValue *d4  = _data4[i];
            NSValue *d5  = _data5[i];
            NSValue *d6  = _data6[i];
            NSValue *d7  = _data7[i];
            NSValue *d8  = _data8[i];
            _Name = _nameData[i];
            
            CGFloat xue = [val1 floatValue];
            CGFloat dis = [val2 floatValue];
            CGRect rect1 = [d1 CGRectValue];
            CGRect rect2 = [d2 CGRectValue];
            CGRect rect3 = [d3 CGRectValue];
            CGRect rect4 = [d4 CGRectValue];
            CGRect rect5 = [d5 CGRectValue];
            CGRect rect6 = [d6 CGRectValue];
            CGRect rect7 = [d7 CGRectValue];
            CGRect rect8 = [d8 CGRectValue];
            
            CGFloat headx = rect1.origin.x/kScale;
            CGFloat heady = rect1.origin.y/kScale;
            CGFloat Spinex = rect1.size.width/kScale;
            CGFloat Spiney = rect1.size.height/kScale;
            CGFloat pelvisx = rect2.origin.x/kScale;
            CGFloat pelvisy = rect2.origin.y/kScale;
            CGFloat leftShoulderx = rect2.size.width/kScale;
            CGFloat leftShouldery = rect2.size.height/kScale;
            CGFloat leftElbowx = rect3.origin.x/kScale;
            CGFloat leftElbowy = rect3.origin.y/kScale;
            CGFloat leftHandx = rect3.size.width/kScale;
            CGFloat leftHandy = rect3.size.height/kScale;
            CGFloat rightShoulderx = rect4.origin.x/kScale;
            CGFloat rightShouldery = rect4.origin.y/kScale;
            CGFloat rightElbowx = rect4.size.width/kScale;
            CGFloat rightElbowy = rect4.size.height/kScale;
            CGFloat rightHandx = rect5.origin.x/kScale;
            CGFloat rightHandy = rect5.origin.y/kScale;
            CGFloat leftPelvisx = rect5.size.width/kScale;
            CGFloat leftPelvisy = rect5.size.height/kScale;
            CGFloat leftKneex = rect6.origin.x/kScale;
            CGFloat leftKneey = rect6.origin.y/kScale;
            CGFloat leftFootx = rect6.size.width/kScale;
            CGFloat leftFooty = rect6.size.height/kScale;
            CGFloat rightPelvisx = rect7.origin.x/kScale;
            CGFloat rightPelvisy = rect7.origin.y/kScale;
            CGFloat rightKneex = rect7.size.width/kScale;
            CGFloat rightKneey = rect7.size.height/kScale;
            CGFloat rightFootx = rect8.origin.x/kScale;
            CGFloat rightFooty = rect8.origin.y/kScale;
           
            //名字是距离
            if(kaiguan1==YES){
                
                 
                 wanjia+=1;
                 
                 poo[i].position = CGPointMake(headx-40, heady-20);
                 poo[i] .string = [NSString stringWithFormat:@"%d",(int)wanjia];
                 pooo[i].position = CGPointMake(headx, heady-30);
                 pooo[i] .string = [NSString stringWithFormat:@"[%d M]",(int)dis];
                 po[i].position = CGPointMake(headx+10, heady-18);
                 po[i] .string = [NSString stringWithFormat:@"%@",_Name];
                 if ([val3 intValue] == 1) {
                     po[i] .string = [NSString stringWithFormat:@"AI %@",_Name];
                     
                 }
                if ((int)xue==0) {
                    po[i] .string = [NSString stringWithFormat:@"被击倒"];
                    UIBezierPath *line3 = [UIBezierPath bezierPath];
                    [line3 moveToPoint:CGPointMake(headx-50,heady-18)];
                    [line3 addLineToPoint:CGPointMake(headx+50, heady-18)];
                    [beijingpathb appendPath:line3];
                    
                }
                 
                     
                 }
            
            //射线
            if(kaiguan2==YES){
                //射线
                UIBezierPath *line = [UIBezierPath bezierPath];
                [line moveToPoint:CGPointMake(kWidth*0.5, 20)];
                [line addLineToPoint:CGPointMake(headx, heady-45)];
                [path appendPath:line];
                //小箭头
               UIBezierPath *line2 = [UIBezierPath bezierPath];
                [line2 moveToPoint:CGPointMake(headx-2.5, heady-10)];
                [line2 addLineToPoint:CGPointMake(headx, heady-5)];
                [line2 addLineToPoint:CGPointMake(headx+2.5, heady-10)];
               [path appendPath:line2];
                
                
            }
            
            //骨骼
            if(kaiguan3==YES){
                
                //骨骼
                UIBezierPath *line1 = [UIBezierPath bezierPath];
                [line1 moveToPoint:CGPointMake(headx, heady)];
                [line1 addLineToPoint:CGPointMake(Spinex, Spiney)];
                [disPath appendPath:line1];
                
                UIBezierPath *line2 = [UIBezierPath bezierPath];
                [line2 moveToPoint:CGPointMake(Spinex, Spiney)];
                [line2 addLineToPoint:CGPointMake(pelvisx, pelvisy)];
                [disPath appendPath:line2];
                
                
                UIBezierPath *line3 = [UIBezierPath bezierPath];
                [line3 moveToPoint:CGPointMake(Spinex, Spiney)];
                [line3 addLineToPoint:CGPointMake(leftShoulderx, leftShouldery)];
                [disPath appendPath:line3];
                
                UIBezierPath *line4 = [UIBezierPath bezierPath];
                [line4 moveToPoint:CGPointMake(leftShoulderx, leftShouldery)];
                [line4 addLineToPoint:CGPointMake(leftElbowx, leftElbowy)];
                [disPath appendPath:line4];
                
                UIBezierPath *line5 = [UIBezierPath bezierPath];
                [line5 moveToPoint:CGPointMake(leftElbowx, leftElbowy)];
                [line5 addLineToPoint:CGPointMake(leftHandx, leftHandy)];
                [disPath appendPath:line5];
                
                UIBezierPath *line6 = [UIBezierPath bezierPath];
                [line6 moveToPoint:CGPointMake(Spinex, Spiney)];
                [line6 addLineToPoint:CGPointMake(rightShoulderx, rightShouldery)];
                [disPath appendPath:line6];
                
                UIBezierPath *line7 = [UIBezierPath bezierPath];
                [line7 moveToPoint:CGPointMake(rightShoulderx, rightShouldery)];
                [line7 addLineToPoint:CGPointMake(rightElbowx, rightElbowy)];
                [disPath appendPath:line7];
                
                UIBezierPath *line8 = [UIBezierPath bezierPath];
                [line8 moveToPoint:CGPointMake(rightElbowx, rightElbowy)];
                [line8 addLineToPoint:CGPointMake(rightHandx, rightHandy)];
                [disPath appendPath:line8];
                
                UIBezierPath *line9 = [UIBezierPath bezierPath];
                [line9 moveToPoint:CGPointMake(pelvisx, pelvisy)];
                [line9 addLineToPoint:CGPointMake(leftPelvisx, leftPelvisy)];
                [disPath appendPath:line9];
                
                UIBezierPath *line10 = [UIBezierPath bezierPath];
                [line10 moveToPoint:CGPointMake(leftPelvisx, leftPelvisy)];
                [line10 addLineToPoint:CGPointMake(leftKneex, leftKneey)];
                [disPath appendPath:line10];
                
                UIBezierPath *line11 = [UIBezierPath bezierPath];
                [line11 moveToPoint:CGPointMake(leftKneex, leftKneey)];
                [line11 addLineToPoint:CGPointMake(leftFootx, leftFooty)];
                [disPath appendPath:line11];
                
                UIBezierPath *line12 = [UIBezierPath bezierPath];
                [line12 moveToPoint:CGPointMake(pelvisx, pelvisy)];
                [line12 addLineToPoint:CGPointMake(rightPelvisx, rightPelvisy)];
                [disPath appendPath:line12];
                
                UIBezierPath *line13 = [UIBezierPath bezierPath];
                [line13 moveToPoint:CGPointMake(rightPelvisx, rightPelvisy)];
                [line13 addLineToPoint:CGPointMake(rightKneex, rightKneey)];
                [disPath appendPath:line13];
                
                UIBezierPath *line14 = [UIBezierPath bezierPath];
                [line14 moveToPoint:CGPointMake(rightKneex, rightKneey)];
                [line14 addLineToPoint:CGPointMake(rightFootx, rightFooty)];
                [disPath appendPath:line14];
    //            if((int)dis>0&&(int)dis<=100 ){ _disLayer.strokeColor =  [UIColor colorWithRed: 0.87 green: 0.00 blue: 0.00 alpha: 1.00].CGColor;};
    //
    //            if((int)dis>100&&(int)dis<=400 ){ _disLayer.strokeColor =  [UIColor colorWithRed: 0.00 green: 0.77 blue: 0.00 alpha: 1.00].CGColor;};
                
            }
            
            
            //血量
            if(kaiguan4==YES){
                //名字背景
                UIBezierPath *line = [UIBezierPath bezierPath];
                [line moveToPoint:CGPointMake(headx-50,heady-22)];
                [line addLineToPoint:CGPointMake(headx+50, heady-22)];
                [beijingpath appendPath:line];
                
                //ID背景
                UIBezierPath *line3 = [UIBezierPath bezierPath];
                [line3 moveToPoint:CGPointMake(headx-50,heady-22)];
                [line3 addLineToPoint:CGPointMake(headx-30, heady-22)];
                [beijingpathb appendPath:line3];
                //血条
                UIBezierPath *line4 = [UIBezierPath bezierPath];
                [line4 moveToPoint:CGPointMake(headx-50,heady-15)];
                [line4 addLineToPoint:CGPointMake(headx-50+xue, heady-15)];
                [beijingpathc appendPath:line4];
                //血条背景
                UIBezierPath *line2 = [UIBezierPath bezierPath];
                [line2 moveToPoint:CGPointMake(headx-50+xue,heady-15)];
                [line2 addLineToPoint:CGPointMake(headx+50, heady-15)];
                [beijingpatha appendPath:line2];
                
                

                
                
            }
            
            //边缘圆圈
            if(kaiguan5==YES){

                //左边提示
                if(headx<0){
                    po[i].position = CGPointMake(13, heady+5);
                    po[i] .string = [NSString stringWithFormat:@"%dM",(int)dis];
                    
                    UIBezierPath *line = [UIBezierPath bezierPath];
                    [line moveToPoint:CGPointMake(0,heady)];
                    [line addLineToPoint:CGPointMake(30, heady)];
                    [beijingpathe appendPath:line];
                    
               
                }
                //右边提示
                if(headx>kWidth && heady>0 && heady<kHeight){
                    po[i].position = CGPointMake(kWidth-15, heady+5);
                    po[i] .string = [NSString stringWithFormat:@"%dM",(int)dis];
                    UIBezierPath *line = [UIBezierPath bezierPath];
                    [line moveToPoint:CGPointMake(kWidth-30,heady)];
                    [line addLineToPoint:CGPointMake(kWidth, heady)];
                    [beijingpathe appendPath:line];
                
                }
                //下边
                if(heady>kHeight && headx<0){
                    po[i].position = CGPointMake(i*50+15,kHeight-10);
                    po[i] .string = [NSString stringWithFormat:@"%dM",(int)dis];
                    UIBezierPath *line = [UIBezierPath bezierPath];
                    [line moveToPoint:CGPointMake(i*50,kHeight-15)];
                    [line addLineToPoint:CGPointMake(i*50+30, kHeight-15)];
                    [beijingpathe appendPath:line];
                
                }
                //上面提示
                if(heady<0){
                    po[i].position = CGPointMake(headx+15,10);
                    po[i] .string = [NSString stringWithFormat:@"%dM",(int)dis];
                    UIBezierPath *line = [UIBezierPath bezierPath];
                    [line moveToPoint:CGPointMake(headx,5)];
                    [line addLineToPoint:CGPointMake(headx+30,5)];
                    [beijingpathe appendPath:line];
                    
                }
                
            }
            if(kaiguan6==YES){
//                if(headx>kWidth-40 &&headx<kWidth+20&&heady>0&&heady<kHeight){
//                    //射线
//                    UIBezierPath *line = [UIBezierPath bezierPath];
//                    [line moveToPoint:CGPointMake(kWidth*0.5, kHeight*0.5)];
//                    [line addLineToPoint:CGPointMake(headx, heady)];
//                    [path appendPath:line];
//                }
            }
            
        }
    
        self.drawLayer.path = path.CGPath;
        self.hpLayer.path = hpPath.CGPath;
        self.disLayer.path = disPath.CGPath;
        self.renji.path = ren.CGPath;
        self.beijing.path = beijingpath.CGPath;
        self.beijinga.path = beijingpatha.CGPath;
        self.beijingb.path = beijingpathb.CGPath;
        self.beijingc.path = beijingpathc.CGPath;
        self.beijingd.path = beijingpathd.CGPath;
        self.beijinge.path = beijingpathe.CGPath;
        
        
        
        
}//;

- (void)DDD
{
    
    [[DDDD data] fetchData:^(NSArray * _Nonnull data, NSArray * _Nonnull hpData, NSArray * _Nonnull disData,  NSArray * _Nonnull nameData,  NSArray * _Nonnull aiData, NSArray * _Nonnull data1, NSArray * _Nonnull data2, NSArray * _Nonnull data3, NSArray * _Nonnull data4, NSArray * _Nonnull data5, NSArray * _Nonnull data6, NSArray * _Nonnull data7, NSArray * _Nonnull data8) {
        [self configWithData:data hpData:hpData disData:disData nameData:nameData aiData:aiData
                       data1:data1 data2:data2 data3:data3 data4:data4 data5:data5 data6:data6 data7:data7 data8:data8];
    }];
    
}

#pragma mark -------------------------------------懒加载-----------------------------------------

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(kWidth/2-17, 20, 150, 40);
        label.text = @"";
        label.textColor = [UIColor redColor];
        label.font = [UIFont boldSystemFontOfSize:30];
        label.shadowColor = [UIColor whiteColor];
        label.shadowOffset = CGSizeMake(0.5,1.1);
        _numberLabel = label;
    }
    return _numberLabel;
}

- (CAShapeLayer *)drawLayer{
    if (!_drawLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.50].CGColor;
        shapeLayer.fillColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.50].CGColor;
        _drawLayer = shapeLayer;
    }
    return _drawLayer;
}

- (CAShapeLayer *)renji{
    if (!_renji) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 0.50].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _renji = shapeLayer;
    }
    return _renji;
}
- (CAShapeLayer *)hpLayer{
    if (!_hpLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 0.50].CGColor;
        shapeLayer.fillColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 0.50].CGColor;
        shapeLayer.lineWidth = 5;//射线宽度
        _hpLayer = shapeLayer;
        
    }
    return _hpLayer;
}
- (CAShapeLayer *)beijing{
    if (!_beijing) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 0.00 green: 1.00 blue: 0.00 alpha: 0.50].CGColor;
        shapeLayer.fillColor = [UIColor colorWithRed: 0.00 green: 1.00 blue: 0.00 alpha: 0.50].CGColor;
        shapeLayer.lineWidth = 12;//射线宽度
        _beijing = shapeLayer;
        
    }
    return _beijing;
}
- (CAShapeLayer *)beijinga{
    if (!_beijinga) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.30].CGColor;
        shapeLayer.fillColor = [UIColor colorWithRed: 1.00 green: 1.00 blue: 1.00 alpha: 0.30].CGColor;
        shapeLayer.lineWidth = 3;//射线宽度
        _beijinga = shapeLayer;
        
    }
    return _beijinga;
}
- (CAShapeLayer *)beijingb{
    if (!_beijingb) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 31/255 green: 29/255 blue: 249/255 alpha: 0.50].CGColor;
        shapeLayer.fillColor = [UIColor colorWithRed: 31/255 green: 29/255 blue: 249/255 alpha: 0.50].CGColor;
        shapeLayer.lineWidth = 12;//射线宽度
        _beijingb = shapeLayer;
        
    }
    return _beijingb;
}
- (CAShapeLayer *)beijingc{
    if (!_beijingc) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 0.50].CGColor;
        shapeLayer.fillColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 0.50].CGColor;
        shapeLayer.lineWidth = 3;//射线宽度
        _beijingc = shapeLayer;
        
    }
    return _beijingc;
}
- (CAShapeLayer *)beijingd{
    if (!_beijingd) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 0.00 green: 0.50 blue: 0.50 alpha: 0.90].CGColor;
        shapeLayer.fillColor = [UIColor colorWithRed: 0.00 green: 0.50 blue: 0.50 alpha: 0.90].CGColor;
        shapeLayer.lineWidth = 0.5;//射线宽度
        _beijingd = shapeLayer;
        
    }
    return _beijingd;
}
- (CAShapeLayer *)beijinge{
    if (!_beijinge) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 0.50].CGColor;
        shapeLayer.fillColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 0.50].CGColor;
        shapeLayer.lineWidth = 12;//射线宽度
        _beijinge = shapeLayer;
        
    }
    return _beijinge;
}
- (CAShapeLayer *)disLayer{
    if (!_disLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 0.50].CGColor;
        shapeLayer.fillColor = [UIColor colorWithRed: 1.00 green: 0.00 blue: 0.00 alpha: 0.50].CGColor;
        
        _disLayer = shapeLayer;
    }
    return _disLayer;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self DDD];
        }];
    }
    return _timer;
}
@end
