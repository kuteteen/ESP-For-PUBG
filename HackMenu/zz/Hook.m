
#import <mach-o/dyld.h>
#import "Hook.h"
#import <UIKit/UIKit.h>
#import <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import "dobby.h"

@interface Hook ()


@property(nonatomic,strong)NSData *headtData;

@end

@implementation Hook

+ (instancetype)shareInstance{
    static Hook *a = nil;
    if (!a) {
        a = [[Hook alloc] init];
    }
    return a;
}

void zz_handler(RegisterContext *rs, const HookEntryInfo *info);
void zz_handler(RegisterContext *rs, const HookEntryInfo *info){

    if([Hook shareInstance].x!=0){
        *(float *)(&rs->floating.regs.q0)=    [Hook shareInstance].x;
        *(float *)(&rs->floating.regs.q1)=    [Hook shareInstance].y;
        *(float *)(&rs->floating.regs.q2)=    [Hook shareInstance].z;
    }

}


+(void)load{
    unsigned long sub_bss = ((unsigned long)_dyld_get_image_vmaddr_slide(0)) + 0x103580D80;
    DobbyInstrument((void *)sub_bss, zz_handler);
}


@end

