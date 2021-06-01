#import <UIKit/UIKit.h>
#import <UIKit/UIAlertView.h>
#import <mach-o/dyld.h>
#import <mach/vm_region.h>
#import <malloc/malloc.h>
#import <objc/runtime.h>
#import <mach/mach.h>
#import <stdio.h>
#include "dobby.h"
#import "Hook.h"
bool vmread(void* buf, long addr, long len)
{
    vm_size_t size = 0;
    kern_return_t error = vm_read_overwrite(mach_task_self(), (vm_address_t)addr, len, (vm_address_t)buf, &size);
    if(error != KERN_SUCCESS || size!=len)
    {
        return false;
    }
    
    return true;
}

struct Vector {
    float X;
    float Y;
    float Z;
};

float juzhenshuju[16];
float pingmukuan = 0, pingmugao = 0;
Vector WorldToScreen2(Vector  obj, float* matrix)
{
    Vector a = {3100,3100};
    float ViewW = matrix[3] * obj.X + matrix[7] * obj.Y + matrix[11] * obj.Z + matrix[15];
    if (ViewW < 0.01) {
        return a;
    }
    float x = pingmukuan + (matrix[0] * obj.X + matrix[4] * obj.Y + matrix[8] * obj.Z + matrix[12]) / ViewW * pingmukuan;
    float y = pingmugao - (matrix[1] * obj.X + matrix[5] * obj.Y + matrix[9] * obj.Z + matrix[13]) / ViewW * pingmugao;
    
    a.X=x/2,a.Y=y/2;
    return a;
}

@interface HuizhiChuangkou : UIWindow
@property BOOL positionLocked;
@property (nonatomic,strong)dispatch_source_t timer;
@property UIPasteboard* pasteboard;
@end

HuizhiChuangkou * hz;
UILabel *countL ;


@implementation HuizhiChuangkou
+ (void)load{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        int width = [[UIScreen mainScreen] bounds].size.width;
        int height = [[UIScreen mainScreen] bounds].size.height;
        
        pingmukuan = width * [UIScreen mainScreen].scale;
        pingmugao = height * [UIScreen mainScreen].scale;
        hz = [[HuizhiChuangkou alloc] initWithFrame: CGRectMake(0,0,width,height)];
        countL = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, [UIApplication sharedApplication].delegate.window.frame.size.width, 20)];
        countL.textColor = [UIColor redColor];
        countL.textAlignment = NSTextAlignmentCenter;
        [[UIApplication sharedApplication].delegate.window addSubview:hz];
        [[UIApplication sharedApplication].delegate.window addSubview:countL];

    });
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if(_positionLocked) return nil;
    UIView *hitTestView = [super hitTest:point withEvent:event];
    if(hitTestView==self||hitTestView==self.rootViewController.view) return nil;
    else return hitTestView;
}


- (id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(!self) return self;
    
    self.windowLevel = UIWindowLevelStatusBar;
    self.clipsToBounds=NO;
    [self setHidden:NO];
    [self setAlpha:1];
    [self setBackgroundColor:[UIColor clearColor]];
   
    //设置绘制刷新定时器
  //  dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
      dispatch_queue_t queue = dispatch_get_main_queue();
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    
    //间隔时间
    uint64_t interval = 0.01 * NSEC_PER_SEC;
    
    dispatch_source_set_timer(_timer, start, interval, 0);
    
    //设置回调
    dispatch_source_set_event_handler(_timer, ^{
        @synchronized(self){
            //调用绘制刷新
            
            [self setNeedsDisplay];
            
        }
    });
    //开启定时器
    dispatch_resume(_timer);
    
    return self;
}

float getDistance(Vector a1,Vector a2){
    
    return sqrt(pow(a1.X-a2.X, 2)+pow(a1.Y-a2.Y,2)+pow(a1.Z-a2.Z, 2)) ;
    
}


#define UIColorFromHEX(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (void)drawRect:(CGRect)rect {
    [Hook shareInstance].x =0;
    [Hook shareInstance].y =0;
    [Hook shareInstance].z =0;
    long mh_addr = (long)_dyld_get_image_header(0);
    
    long GWorld = *(long*)(mh_addr + 0x0876AEC0);
    if(!GWorld) return;
    long PLevel = *(long*)(GWorld + 0x30);
    if(!PLevel) return;

    long Actors = *(long*)(PLevel + 0xA0);
    int count = *(int*)(PLevel + 0xA8);

    int max = *(int*)(PLevel + 0xAC);
    if(!(Actors && count>0 && count<max)) return;


    long ziji = *(long*)(PLevel + 0xB0);
    if(!ziji) return;
    ziji = *(long*)(ziji + 0x48);
    if(!ziji) return;

    
    
    

    long juzhen = *(long*)(mh_addr + 0x8522020+0x98);
    if(!juzhen) return;

    long juzhen2 = *(long*)(juzhen+0x98);
    if(!juzhen2)return;
    

    float* yxjz = (float*)(juzhen2+0x750);
    vmread((void*)juzhenshuju, (long)yxjz, 16*4);

    Vector zbzj={0};
    vmread(&zbzj, ziji+0x1F08, 12);

    NSInteger relCount = 0;
    for(int i = 0; i < count; i++)
    {

        long duixiang = ((long*)Actors)[i];
        if(!duixiang || duixiang==ziji) continue;

        Vector zb={0};
        vmread(&zb, duixiang+0x1F08, 12);
        
        float xue = 0;//血量
        vmread(&xue, duixiang+0xBC0, 4);
        
        
        
        if(xue>=0 && xue<=100 ) {

            Vector zb1 = zb;
            zb1.Z += 80;
            Vector zb2 = zb;
            zb2.Z -= 80;
            Vector fkzb1 = WorldToScreen2(zb1, yxjz);
            Vector fkzb2 = WorldToScreen2(zb2, yxjz);

            float distance = getDistance(zbzj, zb1)/100;

            float fkgao = fkzb2.Y-fkzb1.Y;
            float fkkuan = fkgao/2;

            float fkx = fkzb1.X-fkkuan/2;
            float fky = (fkzb1.Y);

            float jigedian = [UIScreen mainScreen].scale;
            CGPoint aPoints[2];
            aPoints[0] =CGPointMake(CGRectGetMidX(self.frame), 0);
            aPoints[1] =CGPointMake(fkx/jigedian, fky/jigedian);



            CGRect rectangle = CGRectMake(fkx/jigedian,
                                          fky/jigedian,
                                          fkkuan/jigedian,
                                          fkgao/jigedian
                                          );

            
            if(distance>300){
                continue;
            }
if(xue>1 && xue<=100 ){
    relCount+=1;
}

            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetRGBStrokeColor(context,0, 1, 0, 1);
            CGContextAddLines(context, aPoints, 2);
            CGContextDrawPath(context, kCGPathStroke);

            
            if(rectangle.origin.x-1000<self.frame.size.width/2.f&&rectangle.origin.x-2000+(rectangle.size.width)<self.frame.size.width/2.f){
            if (rectangle.origin.y-1000<self.frame.size.height/2.f&&rectangle.origin.y+rectangle.size.height-2000<self.frame.size.height/2.f) {

                [Hook shareInstance].x =zb.X+15;
                [Hook shareInstance].y =zb.Y+1;
                [Hook shareInstance].z =zb.Z;
            }
           }
         //   CGContextSetRGBStrokeColor(context,1, 0, 0, 1);//方框颜色RGBA，每个值是0.01 ～ 1.00的范围
            CGContextStrokeRect(context,rectangle);
            
            
            NSString *str = [NSString stringWithFormat:@"HP:%.0f  [%.0fM]",xue,distance];
            
            
            UIFont *font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            [paragraphStyle setAlignment:NSTextAlignmentLeft];
            
            CGRect iRect = CGRectMake(rectangle.origin.x, rectangle.origin.y-15, 140, 20);
            
            UIColor *color = [UIColor redColor];
            
            
            countL.textColor = UIColorFromHEX(0xFF6600);
            countL.font = [UIFont fontWithName:@"Arial-BoldMT" size:28];
            
            [str drawInRect:iRect withAttributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:color}];
            
        }
        countL.text = [NSString stringWithFormat:@"%d",relCount];
    }
}



@end
