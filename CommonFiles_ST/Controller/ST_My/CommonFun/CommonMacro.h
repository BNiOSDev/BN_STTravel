//
//  CommonMacro.h
//  LUBABA
//
//  Created by Dianar on 16/10/8.
//  Copyright © 2016年 Dianar. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

//屏幕尺寸
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height


#define RGB(r,g,b)        [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:1.f]
#define RGBA(r,g,b,a)     [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a]
#define RGBAHEX(hex,a)    RGBA((float)((hex & 0xFF0000) >> 16),(float)((hex & 0xFF00) >> 8),(float)(hex & 0xFF),a)

//Platform Uitls
#define IS_IPHONE_5_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
#define IS_IPHONE_4_7 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_4_0 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_3_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )

#endif /* CommonMacro_h */
