//Thanks Wil
//http://wilshipley.com/blog/2005/10/pimp-my-code-interlude-free-code.html

static inline BOOL IsEmpty(id thing) {
    return thing == nil
    || ([thing isEqual:[NSNull null]]) //SB addition for things like coredata
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

//From Aaron hillegass (modified)
//http://bignerdranch.com
#define LogMethod() \
NSAutoreleasePool *logMethodPool = [[NSAutoreleasePool alloc] init]; \
SBLog(@"[%@ %@]", self, NSStringFromSelector(_cmd));\
[logMethodPool drain];

#define WarnMethod() \
NSAutoreleasePool *warnMethodPool = [[NSAutoreleasePool alloc] init]; \
SBWarn(@"[%@ %@]", self, NSStringFromSelector(_cmd));\
[warnMethodPool drain];

#define SBWarn NSLog

#if defined(DEBUG) || defined (DEBUG_CONFIGURATION)
#define SBLog NSLog
#else
#define SBLog  //  
#endif

#if TARGET_OS_IPHONE

static inline BOOL deviceIsIPad()
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

static inline BOOL deviceIsIPhone()
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

#endif