//
//  HUDPromptToast.m
//  SmartHome
//
//  Created by zhaishixi on 14+10-15.
//  Copyright (c) 2014年 GBCOM. All rights reserved.
//

#import "HUDPromptToast.h"

@implementation HUDPromptToast
+ (MBProgressHUD *)showSimple:(UIView<MBProgressHUDDelegate>  *)context block:(SEL)method{
	// The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = context;
	
	// Show the HUD while the provided method executes in a new thread
	[HUD showWhileExecuting:method onTarget:context withObject:nil animated:YES];
    return HUD;
}

+ (MBProgressHUD *)showWithLabel:(UIView *)context{
	
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	HUD.labelText = @"Loading";
	
	//[HUD showWhileExecuting:method onTarget:self withObject:nil animated:YES];
    return HUD;
}

+ (MBProgressHUD *)showWithDetailsLabel:(UIView<MBProgressHUDDelegate>  *)context block:(SEL)method{
	
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	
	HUD.delegate = context;
	HUD.labelText = @"Loading";
	HUD.detailsLabelText = @"updating data";
	HUD.square = YES;
	
	[HUD showWhileExecuting:method onTarget:context withObject:nil animated:YES];
    return HUD;
}
+(MBProgressHUD *)showWithDetailsLabel:(UIView *)context{
	
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	HUD.labelText = @"Loading";
	HUD.detailsLabelText = @"updating data";
	HUD.square = YES;
    return HUD;
}
+ (MBProgressHUD *)showWithLabelDeterminate:(UIView<MBProgressHUDDelegate>  *)context block:(SEL)method{
	
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	
	// Set determinate mode
	HUD.mode = MBProgressHUDModeDeterminate;
	
	HUD.delegate = context;
	HUD.labelText = @"Loading";
	
	// myProgressTask uses the HUD instance to update progress
	[HUD showWhileExecuting:method onTarget:context withObject:nil animated:YES];
    return HUD;
}

+ (MBProgressHUD *)showWIthLabelAnnularDeterminate:(UIView<MBProgressHUDDelegate>  *)context block:(SEL)method{
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	
	// Set determinate mode
	HUD.mode = MBProgressHUDModeAnnularDeterminate;
	
	HUD.delegate = context;
	HUD.labelText = @"Loading";
	
	// myProgressTask uses the HUD instance to update progress
	[HUD showWhileExecuting:method onTarget:context withObject:nil animated:YES];
    return HUD;
}

+ (MBProgressHUD *)showWithLabelDeterminateHorizontalBar:(UIView<MBProgressHUDDelegate>  *)context block:(SEL)method{
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	
	// Set determinate bar mode
	HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
	
	HUD.delegate = context;
	
	// myProgressTask uses the HUD instance to update progress
	[HUD showWhileExecuting:method onTarget:context withObject:nil animated:YES];
    return HUD;
}
/**
 *  弹出带自定义图片的提示框，操作成功完成后使用
 *
 *  @param context <#context description#>
 *
 *  @return <#return value description#>
 */
+ (MBProgressHUD *)showWithCustomView:(UIView<MBProgressHUDDelegate> *)context Text:text{
     
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = text;
	
	[HUD show:YES];
	[HUD hide:YES afterDelay:1.5];
    return HUD;
}
/**
 *  弹出带自定义图片的提示框，网络不可用时使用
 *
 *  @param context <#context description#>
 *
 *  @return <#return value description#>
 */
+ (MBProgressHUD *)showWithCustomView1:(UIView<MBProgressHUDDelegate> *)context Text:text{
    
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_network.png"]];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = text;
	
	[HUD show:YES];
	[HUD hide:YES afterDelay:1.5];
    return HUD;
}

+ (MBProgressHUD *)showWithLabelMixed:(UIView<MBProgressHUDDelegate>  *)context block:(SEL)method{
	
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	HUD.delegate = context;
	HUD.labelText = @"Connecting";
	HUD.minSize = CGSizeMake(135.f, 135.f);
	[HUD showWhileExecuting:method onTarget:context withObject:nil animated:YES];
    return HUD;
}

+ (MBProgressHUD *)showUsingBlocks:(UIView<MBProgressHUDDelegate>  *)context block:(SEL)method{
#if NS_BLOCKS_AVAILABLE
	MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:hud];
	hud.labelText = @"With a block";
#endif
    return hud;
}

+ (MBProgressHUD *)showOnWindow:(UIView<MBProgressHUDDelegate>  *)context block:(SEL)method{
	// The hud will dispable all input on the window
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	HUD.delegate = context;
	HUD.labelText = @"Loading";
	[HUD showWhileExecuting:method onTarget:context withObject:nil animated:YES];
      return HUD;
}

+ (MBProgressHUD *)showURL:(UIView<MBProgressHUDDelegate>  *)context url:(NSString *)method{
	NSURL *URL = [NSURL URLWithString:method];
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:context];
	[connection start];
	MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:context animated:YES];
	HUD.delegate = context;
    return HUD;
}


+ (MBProgressHUD *)showWithGradient:(UIView<MBProgressHUDDelegate>  *)context block:(SEL)method{
	
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	
	HUD.dimBackground = YES;
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = context;
	
	// Show the HUD while the provided method executes in a new thread
	[HUD showWhileExecuting:method onTarget:context withObject:nil animated:YES];
    return HUD;
}

+ (MBProgressHUD *)showTextOnly:(UIView<MBProgressHUDDelegate>  *)context Text:text{
	
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:context animated:YES];
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = text;
	hud.margin = 10.f;
	hud.removeFromSuperViewOnHide = YES;
	
	[hud hide:YES afterDelay:1];
    return hud;
}

+ (MBProgressHUD *)showWithColor:(UIView<MBProgressHUDDelegate>  *)context block:(SEL)method{
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:context];
	[context addSubview:HUD];
	
	// Set the hud to display with a color
	HUD.color = [UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0.90];
	
	 HUD.delegate = context;
	[HUD showWhileExecuting:method onTarget:self withObject:nil animated:YES];
    return HUD;
}

@end
