#import <Carbon/Carbon.h>
#import <AppKit/AppKit.h>

struct _MediastreamDatas;
typedef struct _MediastreamDatas MediastreamDatas;

extern MediastreamDatas* init_default_args();
extern BOOL parse_args(int argc, char** argv, MediastreamDatas* plop);
extern void setup_media_streams(MediastreamDatas* args);
extern void run_interactive_loop(MediastreamDatas* args);
extern void run_non_interactive_loop(MediastreamDatas* args);
extern void clear_mediastreams(MediastreamDatas* args);

@interface MyApplicationDelegate: NSObject
{
    NSWindow *window;
    MediastreamDatas* args;
}
-(void)registerArgs:(MediastreamDatas*) args;
-(void)applicationWillFinishLaunching: (NSNotification*) aNotification;
-(void)applicationDidFinishLaunching: (NSNotification*) aNotification;
-(BOOL)applicationShouldTerminateAfterLastWindowClosed: (NSApplication *)theApplication;
@end

@implementation MyApplicationDelegate

-(void)registerArgs:(MediastreamDatas*) a {
    args = a;
}

-(void) run_mediastreamer_loop {
    setup_media_streams(args);
    run_non_interactive_loop(args);
	clear_mediastreams(args);
	exit(0);
}

-(void)applicationWillFinishLaunching: (NSNotification*) aNotification
{
    [self performSelectorInBackground:@selector(run_mediastreamer_loop) withObject:nil];
}

-(void)applicationDidFinishLaunching: (NSNotification*) aNotification
{
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed: (NSApplication *)theApplication
{
    return YES;
}

-(void)dealloc
{
    [window release];
    [super dealloc];
}
@end

int main(int argc, char **argv)
{
    MediastreamDatas* args = init_default_args();
    if (!parse_args(argc, argv, args)) {
        NSLog(@"Arguments parsing fail (argc=%d)", argc);
        exit(-1);
    }
       
    
    static const ProcessSerialNumber thePSN = { 0, kCurrentProcess };
    TransformProcessType(&thePSN, kProcessTransformToForegroundApplication);
    SetFrontProcess(&thePSN);
    NSAutoreleasePool *aPool = [[NSAutoreleasePool alloc] init];
    [NSApplication sharedApplication];
    MyApplicationDelegate *aMyApplicationDelegate = [[MyApplicationDelegate alloc] init];
    [aMyApplicationDelegate registerArgs:args];
    [NSApp setDelegate: aMyApplicationDelegate]; 
    [aPool release];
    [NSApp run];
    return 0;
}
